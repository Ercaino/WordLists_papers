ARG BASE_IMAGE
FROM $BASE_IMAGE

LABEL maintainer="Ercaino" \
      description="WordLists Papers - Curated wordlist collection for penetration testing" \
      org.opencontainers.image.source="https://github.com/Ercaino/WordLists_papers"

WORKDIR /wordlists
COPY data/ ./
COPY notice.md term_of_use.md LICENSE ./
