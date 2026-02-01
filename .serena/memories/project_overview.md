# Project Overview

## Purpose
This is a LaTeX-based academic paper repository for **"DiMergeCo"**, presenting an efficient framework for large-scale matrix co-clustering. The paper is targeted at an IEEE Transactions journal.

## Tech Stack
- **Document system**: LaTeX (IEEEtran journal class)
- **Bibliography**: BibLaTeX with Biber backend
- **Build tool**: GNU Make + latexmk (alternative: arara)
- **Formatting**: latexindent (via pre-commit hooks)
- **CI/CD**: GitHub Actions for LaTeX builds and releases
- **Scripting**: Python (for bibliography maintenance: `update_bib_subdoi.py`)

## Key Files
- `src/root.tex` — Main paper document (all content inline, no separate section files)
- `src/references.bib` — Bibliography database
- `src/supplement.tex` — Supplementary material
- `src/response.tex` — Response to reviewers
- `src/cover_letter.tex` — Journal submission cover letter
- `Makefile` — Build automation
- `src/.latexmkrc` — latexmk configuration (biber, pdflatex)
- `.pre-commit-config.yaml` — Pre-commit hook for latexindent

## Repository Structure
```
.
├── src/                          # All LaTeX source files
│   ├── root.tex                  # Main paper
│   ├── response.tex              # Reviewer response
│   ├── supplement.tex            # Supplementary material
│   ├── cover_letter.tex          # Cover letter
│   ├── references.bib            # Bibliography
│   ├── ar2rc.cls, ieeeconf.cls, sn-mathphys.bst
│   ├── .latexmkrc                # latexmk config
│   ├── arararc.yaml              # arara config (for CWD=src/)
│   ├── rules/latexmk.yaml        # Custom arara rule
│   └── images/                   # All figures (PNG, PDF)
├── build/                        # Build output (gitignored)
│   ├── root/, response/, supplement/, cover_letter/
├── docs/                         # Notes and documentation
├── scripts/                      # Utility scripts
│   └── update_bib_subdoi.py
├── arararc.yaml                  # arara config (project root)
├── Makefile
├── .github/workflows/            # CI (build-latex.yml, release.yml)
├── .pre-commit-config.yaml
└── CLAUDE.md
```

## Images (in src/images/)
- `cluster.png`, `ari_small.png`, `coc.png`, `cocomparison.png`, `optimisation.png`, `nmi_small.png`, `efficiency.png`, `workflow.png`, `orcid.pdf`
