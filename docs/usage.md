# Usage

All examples assume wordlists are installed at `/usr/share/wordlists` (Linux) or `%WORDLISTS%` (Windows).

---

## Directory enumeration (Gobuster / Dirb)

```bash
# Linux
gobuster dir -u http://target.com -w /usr/share/wordlists/data/BruteFiles/directories.txt

# Windows
gobuster dir -u http://target.com -w "$env:WORDLISTS\data\BruteFiles\directories.txt"
```

---

## Password brute-force (Hydra)

```bash
# SSH
hydra -L /usr/share/wordlists/data/BruteFiles/users.txt -P /usr/share/wordlists/data/BruteFiles/2_digits.txt ssh://target.com

# FTP
hydra -L /usr/share/wordlists/data/BruteFiles/users.txt -P /usr/share/wordlists/data/BruteFiles/4_digits.txt ftp://target.com
```

---

## Subdomain enumeration (Subfinder)

```bash
subfinder -d target.com -w /usr/share/wordlists/data/BruteFiles/subdomains.txt
```

---

## Password cracking (John / Hashcat)

```bash
# John the Ripper
john --wordlist=/usr/share/wordlists/data/BruteFiles/4_digits.txt hash.txt

# Hashcat
hashcat -m 0 -a 0 hash.txt /usr/share/wordlists/data/BruteFiles/2_digits.txt
```

---

## Nmap brute-force scripts

```bash
nmap --script http-brute -p 80 --script-args userdb=/usr/share/wordlists/data/BruteFiles/users.txt,passdb=/usr/share/wordlists/data/BruteFiles/4_digits.txt target.com
```

---

## Language wordlists

Useful for dictionary attacks, spell-check testing, or NLP preprocessing:

```bash
# Italian words
cat /usr/share/wordlists/data/Languages/italian.txt

# French words
cat /usr/share/wordlists/data/Languages/french.txt
```

---

## View installed structure

```bash
./src/view_wordlist.sh
# or with custom path:
./src/view_wordlist.sh /custom/path
```

---

## Environment variable (Windows)

After installation via [script](installation.md#windows), `$env:WORDLISTS` points to the installation directory:

```powershell
# Navigate to wordlists
cd $env:WORDLISTS

# List contents
ls $env:WORDLISTS\data\
```
