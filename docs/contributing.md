# Contributing

Contributions of new wordlists, corrections, or improvements are welcome. Please follow these guidelines to keep the repository consistent.

---

## Adding wordlists

1. Place new wordlists in the appropriate subdirectory under `data/`.
2. If no existing subdirectory fits, propose a new one via issue first.
3. Files must be:
   - **Plain text** (`.txt`), UTF-8 encoded
   - One entry per line
   - Sorted alphabetically
   - Lowercase unless capitals are semantically relevant (filenames, proper nouns)
   - Free of blank lines, unprintable characters, and inline comments

---

## Attribution

Every wordlist must include provenance. Update `notice.md` with:

- The source URL
- The original license (if applicable)
- Any modifications applied (sorting, deduplication, cleaning)

Example entry:

```
- [`data/BruteFiles/example.txt`](data/BruteFiles/example.txt) — [Source](https://example.com/source) — MIT
```

---

## Pull request checklist

- [ ] Wordlists are in `data/` under the correct subdirectory
- [ ] Files follow the formatting rules above
- [ ] Sources are credited in `notice.md`
- [ ] Run `tree data/ --sort=name > docs/list_of_wordlist.txt` to refresh the structure file (or wait for CI)

---

## Code of conduct

This project is intended for **ethical and legal use only**. Contributions promoting illegal activity, unauthorised access, or harmful content will be rejected.
