<#
.SYNOPSIS
    Windows installer for WordLists_papers.
.DESCRIPTION
    Clones the WordLists_papers repository into C:\Wordlists and sets
    the WORDLISTS user environment variable.
.PARAMETER Uninstall
    Remove the installation directory and environment variable.
.EXAMPLE
    .\install.ps1
    .\install.ps1 -Uninstall
.NOTES
        Author          : Ercaino @Ercaino
        GitHub          : https://github.com/Ercaino 
        Version        : #{replaceme}
#>
# For Get-Help .\install.ps1

[CmdletBinding()] # Pw power (-Verbose -Debug -WhatIf)
param(
    [switch]$Uninstall  # Parameter "-Uninstall" removes everything
)

Set-StrictMode -Version Latest 

# Configuration ---
$dest    = "C:\Wordlists"
$envName = "WORDLISTS"
$repoUrl = "https://github.com/Ercaino/WordLists_papers"

# Check admin privileges ---
function Test-Admin {
    $identity = [Security.Principal.WindowsIdentity]::GetCurrent()
    $principal = New-Object Security.Principal.WindowsPrincipal($identity)  
    return $principal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
}

# Main function ---
function Main {
    # Privileges check
    if (-not (Test-Admin)) {
        Write-Host "⚠️ Please run this script as Administrator."
        return 1
    }

    # Uninstall ---
    if ($Uninstall) {
        Write-Host "💣 Starting the uninstallation procedure..."

        # Remove C:\Wordlists
        if (Test-Path -LiteralPath $dest) {
            Write-Host "🗑️  Removing $dest..."
            Remove-Item -LiteralPath $dest -Recurse -Force
        } else {
            Write-Host "ℹ️  The directory $dest does not exist."
        }

        # Remove WORDLISTS user environment variable
        [Environment]::SetEnvironmentVariable($envName, $null, "User")
        Write-Host "🧹 Environment variable $envName removed."

        Write-Host "🎉 Uninstallation completed!"
        return 0
    }


    # Install ---
    # Ensure git is available
    if (-not (Get-command git -ErrorAction SilentlyContinue)) {
        $title = "Git not found"
        $message = "Git is required but not installed on this system. Install it now?"
        $yes     = New-Object System.Management.Automation.Host.ChoiceDescription("&Yes", "Install Git via package manager")
        $no      = New-Object System.Management.Automation.Host.ChoiceDescription("&No", "Cancel installation")
        $choice  = $host.UI.PromptForChoice($title, $message, @($yes, $no), 1) # Prompt user for confirmation

        if ($choice -ne 0) {
            Write-Host "Installation cancelled. Install git manually from https://git-scm.com/ and re-run this script."
            return 0
        }

        # Try package managers in order: Chocolatey → winget
        $installers = @(
            @{ Name = "Chocolatey"; Cmd = "choco"; Args = @("install", "git", "-y") }
            @{ Name = "winget";     Cmd = "winget"; Args = @("install", "--id", "Git.Git", "-e", "--source", "winget") }
        )

        $installed = $false
        foreach ($item in $installers) {
            if (Get-Command $item.Cmd -ErrorAction SilentlyContinue) {
                Write-Host "📦 Installing git via $($item.Name)..."
                $proc = Start-Process -FilePath $item.Cmd -ArgumentList $item.Args -NoNewWindow -Wait -PassThru
                if ($proc.ExitCode -eq 0) {
                    $installed = $true
                    break
                }
                Write-Warning "$($item.Name) failed (exit code $($proc.ExitCode)). Trying next..."
            }
        }
        if (-not $installed) {
            Write-Error "Could not install Git. No package manager succeeded."
            Write-Error "Install git manually from https://git-scm.com/ and re-run this script."
            return 2
        }

        # Refresh PATH from registry so the new git.exe is found immediately
        $machinePath = [Environment]::GetEnvironmentVariable("Path", "Machine")
        $userPath    = [Environment]::GetEnvironmentVariable("Path", "User")
        $env:Path = (@($machinePath; $userPath) -split ';' | Where-Object { $_ } | Select-Object -Unique) -join ';'

        if (-not (Get-Command git -ErrorAction SilentlyContinue)) {
            Write-Error "Git installed but not found in PATH after refresh."
            return 2
        }

        Write-Host "✅ Git installed successfully."
    }

    Write-Host "🚀 Starting the installation..."

    # Clean previous installation if any
    if (Test-Path -LiteralPath $dest) {
        Write-Host "🗑️  Removing the old $dest directory"
        Remove-Item -LiteralPath $dest -Recurse -Force
    }

    # Clone repository
    try {
        Write-Host "📂 Cloning the repository in $dest..."
        git clone $repoUrl $dest
        if ($LASTEXITCODE -ne 0) { throw "Clone failed with exit code $LASTEXITCODE" }
    }
    catch {
        Write-Error "❌ $_"
        return 3
    }

    # Persist WORDLISTS user environment variable pointing to installation path
    [Environment]::SetEnvironmentVariable($envName, $dest, "User")
    $env:WORDLISTS = $dest
    Write-Host "📎 Environment variable $envName set to $dest"

    Write-Host "🎉 Setup completed!"
    Write-Host "👉 Restart your terminal or log out and back in for the WORDLISTS variable to take effect."
    return 0
}

# Entry point ---
$exitCode = Main
if ($exitCode -ne 0) {
    Write-Host "❌ Error $exitCode — see messages above."
    Write-Host "Press any key to exit..."
    $null = $Host.UI.RawUI.ReadKey("NoEmit,IncludeKeyDown")
}
exit $exitCode