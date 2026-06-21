# Installation

In operating systems such as Arch, Debian and Windows, there are no default wordlists installed at the time of standard system installation.

In distributions such as kali linux there are already wordlists:
```sh
root@kali:~# wordlists -h

> wordlists ~ Contains the rockyou wordlist

/usr/share/wordlists
|-- amass -> /usr/share/amass/wordlists
|-- brutespray -> /usr/share/brutespray/wordlist
|-- dirb -> /usr/share/dirb/wordlists
|-- dirbuster -> /usr/share/dirbuster/wordlists
|-- dnsmap.txt -> /usr/share/dnsmap/wordlist_TLAs.txt
|-- fasttrack.txt -> /usr/share/set/src/fasttrack/wordlist.txt
|-- fern-wifi -> /usr/share/fern-wifi-cracker/extras/wordlists
|-- john.lst -> /usr/share/john/password.lst
|-- legion -> /usr/share/legion/wordlists
|-- metasploit -> /usr/share/metasploit-framework/data/wordlists
|-- nmap.lst -> /usr/share/nmap/nselib/data/passwords.lst
|-- rockyou.txt.gz
|-- seclists -> /usr/share/seclists
|-- sqlmap.txt -> /usr/share/sqlmap/data/txt/wordlist.txt
|-- wfuzz -> /usr/share/wfuzz/wordlist
|-- wifite.txt -> /usr/share/dict/wordlist-probable.txt
```

## 🔹 1. Arch Linux / Debian without script

> In Arch Linux, Debian and Ubuntu, you will not find pre-installed wordlists unless they are added manually or through the installation of specific packages.

#### If not yet installed, install git
```bash
  sudo pacman -S git -- arch
  sudo apt install git -- debian
```

#### Install the ropository
```bash
  # installs it in the /usr/share/wordlists directory
  sudo git clone https://github.com/Ercaino/WordLists_papers  /usr/share/wordlists
```

Wordlists can be accessed like this:
```sh
  /usr/share/wordlists/data/Languages/filename.txt
  /usr/share/wordlists/data/BruteFiles/filename.txt
  /usr/share/wordlists/data/Passwords/filename.txt
```

#### Aggiungi un Alias in .zshrc

```bash
  nano ~/.zshrc
  # alias wordlists='cd /usr/share/wordlists'
```
save (Ctrl+O, then Enter) and close (Ctrl+X).

apply the changes:
```bash
  source ~/.zshrc
```

## Output standard

You can use this command to display the list of directories
```sh
  ls -la /usr/share/wordlists

  total 24
  drwxr-xr-x  6 root root 4096 Apr  5 10:00 .
  drwxr-xr-x 72 root root 4096 Apr  5 09:50 ..
  lrwxrwxrwx  1 root root   20 Apr  5 09:55 dirb -> /usr/share/dirb/wordlists
  lrwxrwxrwx  1 root root   28 Apr  5 09:55 metasploit -> /usr/share/metasploit-framework/data/wordlists
  lrwxrwxrwx  1 root root   23 Apr  5 09:55 seclists -> /usr/share/seclists
  -rw-r--r--  1 root root  13M Mar  1 00:00 rockyou.txt.gz
  -rw-r--r--  1 root root  12K Feb 28 12:00 fasttrack.txt
  -rw-r--r--  1 root root  31K Feb 28 12:00 john.lst
  -rw-r--r--  1 root root  18K Feb 28 12:00 sqlmap.txt
```

## Output custom

You can install tree (if you don't have it): `sudo pacman -S tree`

run: `sudo ./src/view_wordlist.sh`

example:
```bash
  /usr/share/wordlists
  ├── dirb -> /usr/share/dirb/wordlists
  │   ├── common.txt
  │   ├── huge.txt
  │   └── small.txt
  ├── metasploit -> /usr/share/metasploit-framework/data/wordlists
  │   ├── passwords.json
  │   └── usernames.json
  ├── seclists -> /usr/share/seclists
  │   ├── Usernames
  │   └── Passwords
  ├── rockyou.txt.gz
  └── fasttrack.txt
```


## Execution

Brute-force SSH with Hydra
```bash
hydra -L /usr/share/wordlists/users/common_users.txt -P /usr/share/wordlists/passwords/weak_passwords.txt ssh://target.com
```

Enumerating subdomains with Subfinder
```bash
subfinder -d target.com -w /usr/share/wordlists/subdomains/big_subdomains.txt
```