#!/bin/bash
# --- Checking whether the user is root
check_root() {
    if [[ $EUID -ne 0 ]]; then
        echo "⚠️  Please run this script with sudo."
        exit 1
    fi
}


# --- Determine the Linux distribution
detect_distro() {
    DISTRO=""
    if [ -f /etc/os-release ]; then
        . /etc/os-release
        DISTRO=$ID
    elif type lsb_release >/dev/null 2>&1; then
        DISTRO=$(lsb_release -si | tr '[:upper:]' '[:lower:]')
    else
        echo "❌ Unable to recognise the distribution."
        exit 1
    fi
    echo "📦 Distribution detected: $DISTRO"
}

# --- Install necessary packages (git and tree)
install_packages() {
    echo "🔧 Beginning of installation of required packages..."
    if [[ "$DISTRO" == "arch" ]]; then
        echo "🔧 Arch OS: installation of git and tree..."
        pacman -Sy --noconfirm git tree
    elif [[ "$DISTRO" == "debian" ]]; then
        echo "🔧 Debian OS: installation of git and tree..."
        apt update && apt install -y git tree
    else
        echo "❌ Unsupported distribution."
        exit 1
    fi
}

# --- Removes old wordlists directory if it exists
remove_old_dir() {
    if [ -d "/usr/share/wordlists" ]; then
        echo "🗑️  Removing the old /usr/share/wordlists directory"
        rm -rf /usr/share/wordlists
    fi
}

# --- Clone the repository to the correct directory
clone_repo() {
    echo "📂 Cloning the repository in /usr/share/wordlists..."
    git clone https://github.com/Ercaino/WordLists_papers  /usr/share/wordlists
}

# --- Configure the alias “wordlists” in .zshrc
setup_shell_alias() {
    # Determines the user and configuration file
    if [ -n "$SUDO_USER" ]; then
        USER_HOME="/home/$SUDO_USER"
        ZSHRC="$USER_HOME/.zshrc"
        BASHRC="$USER_HOME/.bashrc"
    else
        USER_HOME="/root"
        ZSHRC="$USER_HOME/.zshrc"
        BASHRC="$USER_HOME/.bashrc"
    fi

    echo "📎 Configuration of the “wordlists” alias..."

    # If .zshrc exists, add the alias (if it does not exist)
    if [ -f "$ZSHRC" ]; then
        if ! grep -q "alias wordlists=" "$ZSHRC"; then
            echo "alias wordlists='cd /usr/share/wordlists'" >> "$ZSHRC"
            echo "✅ Alias added to $ZSHRC"
        else
            echo "ℹ️ Alias already present in $ZSHRC"
        fi
    fi

    # If .bashrc exists, add the alias (if it does not exist)
    if [ -f "$BASHRC" ]; then
        if ! grep -q "alias wordlists=" "$BASHRC"; then
            echo "alias wordlists='cd /usr/share/wordlists'" >> "$BASHRC"
            echo "✅ Alias added to $BASHRC"
        else
            echo "ℹ️ Alias already present in $BASHRC"
        fi
    fi
}

# --- Reload zshrc configuration 
reload_shell_config() {
    if [ -n "$SUDO_USER" ]; then
        USER_HOME="/home/$SUDO_USER"
        echo "🔄 Reloading the configuration for the user $SUDO_USER..."
        if [ -f "$USER_HOME/.zshrc" ]; then
            su - "$SUDO_USER" -c "source $USER_HOME/.zshrc"
        elif [ -f "$USER_HOME/.bashrc" ]; then
            su - "$SUDO_USER" -c "source $USER_HOME/.bashrc"
        fi
    else
        if [ -f "/root/.zshrc" ]; then
            source "/root/.zshrc"
        elif [ -f "/root/.bashrc" ]; then
            source "/root/.bashrc"
        fi
    fi
}


# --- Unistall option
uninstall_wordlists() {
    echo "💣 Starting the uninstallation procedure..."

    # Rimuove la directory
    if [ -d "/usr/share/wordlists" ]; then
        echo "🗑️  Removing /usr/share/wordlists..."
        rm -rf /usr/share/wordlists
    else
        echo "ℹ️  The /usr/share/wordlists directory does not exist."
    fi

    # Removes the alias from .zshrc and .bashrc
    if [ -n "$SUDO_USER" ]; then
        USER_HOME="/home/$SUDO_USER"
    else
        USER_HOME="/root"
    fi

    ZSHRC="$USER_HOME/.zshrc"
    BASHRC="$USER_HOME/.bashrc"

    echo "🧹 Removing the alias “wordlists” from configuration files..."

    if [ -f "$ZSHRC" ]; then
        sed -i '/alias wordlists=/d' "$ZSHRC"
        echo "✅ Alias removed from $ZSHRC"
    fi

    if [ -f "$BASHRC" ]; then
        sed -i '/alias wordlists=/d' "$BASHRC"
        echo "✅ Alias removed from $BASHRC"
    fi

    # Reload configuration
    reload_shell_config

    echo "🎉 Uninstallation completed!"
}


check_root

if [[ "$1" == "--uninstall" ]]; then
    uninstall_wordlists
    exit 0
fi
echo "🚀 Starting the script"

detect_distro
install_packages
remove_old_dir
clone_repo
setup_alias
reload_zshrc

echo "🎉 Setup completed!"
echo "👉 Use “wordlists” to move to the wordlist directory."

# Make executable: chmod +x install.sh
# launch: sudo ./install.sh