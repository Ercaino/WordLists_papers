# Directory structure

<!-- TREE -->
<!-- END -->

---

## BruteFiles reference

| File | Content | Use case |
|---|---|---|
| `2_digits.txt` | 000–999 | Simple PIN brute-force |
| `3_digits.txt` | 0000–9999 | 4-digit PIN / numeric tokens |
| `4_digits.txt` | 00000–99999 | 5-digit codes, OTP fuzzing |
| `directories.txt` | Common HTTP paths | Web directory enumeration (Gobuster, Dirb) |
| `gitignore.txt` | Git artifacts | `.git/config`, `.gitignore` detection |
| `subdomains.txt` | Subdomain names | Subdomain enumeration (Subfinder, ffuf) |
| `users.txt` | Common usernames | Brute-force (Hydra, Nmap http-brute) |

---

## Languages

All language wordlists are derived from [Hunspell dictionaries](https://github.com/titoBouzout/Dictionaries) (georgian from [wooorm/dictionaries](https://github.com/wooorm/dictionaries)). Each file contains alphabetically sorted, lowercased words with no metadata lines. See [notice.md](../notice.md) for full attribution.
