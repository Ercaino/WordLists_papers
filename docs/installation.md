<p align="center">
    <h2 align="center">Wordlists Papers</h2>
</p>

<p align="center">
  <strong>
    <big>
      <a href="#linux">Arch Linux</a> ·
      <a href="#linux">BlackArch</a> ·
      <a href="#linux">Debian</a> ·
      <a href="#linux">Linux Mint</a> ·
      <a href="#linux">Fedora</a> ·
      <a href="#windows">Windows</a>
    </big>
  </strong>
</p>

---

## 🐧 Linux

**📦 Git clone**
```bash
sudo git clone https://github.com/Ercaino/WordLists_papers  /usr/share/wordlists
```

**📥 Curl**
```bash
curl -LO https://github.com/Ercaino/WordLists_papers/archive/refs/heads/main.tar.gz
tar -xzf main.tar.gz
sudo mv WordLists_papers-main /usr/share/wordlists
rm main.tar.gz
```

**🐙 gh — GitHub CLI**
```bash
sudo gh repo clone Ercaino/WordLists_papers  /usr/share/wordlists
```

**⚙️ Script installer**
> **Supported distros:** Arch Linux, BlackArch, Debian, Linux Mint, Fedora
```bash
sudo ./src/install.sh
```
> 💡 To uninstall: `sudo ./src/install.sh --uninstall`

---

## 🪟 Windows

**📦 Git clone**
```powershell
git clone https://github.com/Ercaino/WordLists_papers  C:\Wordlists
```

**🐙 gh — GitHub CLI**
```powershell
gh repo clone Ercaino/WordLists_papers  C:\Wordlists
```

**⚙️ Script installer** (PowerShell as Administrator)
```powershell
.\src\install.ps1
```
> 💡 To uninstall: `.\src\install.ps1 -Uninstall`

**📥 irm — PowerShell remote download**
```powershell
$url = "https://github.com/Ercaino/WordLists_papers/archive/refs/heads/main.zip"
irm $url -OutFile "$env:TEMP\WordLists.zip"
Expand-Archive -Path "$env:TEMP\WordLists.zip" -DestinationPath C:\Wordlists -Force
Remove-Item "$env:TEMP\WordLists.zip"
```
