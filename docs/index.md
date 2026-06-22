# WordLists Papers

Curated wordlist collection for ethical hacking and authorised penetration testing.

- [Installation](installation.md)
- [Usage](usage.md)
- [Directory structure](structure.md)
- [Contributing](contributing.md)

---

## Quick start

**Linux:**
```bash
sudo git clone https://github.com/Ercaino/WordLists_papers /usr/share/wordlists
```

**Windows (PowerShell as Administrator):**
```powershell
git clone https://github.com/Ercaino/WordLists_papers C:\Wordlists
[Environment]::SetEnvironmentVariable("WORDLISTS", "C:\Wordlists", "User")
```

**Docker:**
```bash
docker pull Ercaino/WordLists_papers:debian-latest
docker run -it --rm Ercaino/WordLists_papers ls /wordlists
```

See [installation](installation.md) for more methods (curl, gh, irm, scripts).

---

## Supported platforms

| Platform | Package manager | Script |
|---|---|---|
| Arch Linux · BlackArch | `pacman` | `src/install.sh` |
| Debian · Linux Mint | `apt` | `src/install.sh` |
| Fedora | `dnf` | `src/install.sh` |
| Windows | — | `src/install.ps1` |

## Docker images

Published on [Docker Hub](https://hub.docker.com/r/Ercaino/WordLists_papers):

- `Ercaino/WordLists_papers:arch-latest`
- `Ercaino/WordLists_papers:debian-latest`
- `Ercaino/WordLists_papers:windows-latest`

Wordlists are mounted at `/wordlists`.
