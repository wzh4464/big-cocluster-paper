# Project Overview

## Purpose
This is a LaTeX-based academic paper repository for **"DiMergeCo"**, presenting an efficient framework for large-scale matrix co-clustering. The paper is targeted at IEEE Transactions on Systems, Man, and Cybernetics: Systems.

## Tech Stack
- **Document system**: LaTeX (IEEEtran journal class)
- **Bibliography**: BibLaTeX with Biber backend
- **Build tool**: GNU Make + latexmk with `-cd` flag (alternative: arara with custom latexmk rule)
- **Formatting**: latexindent (via pre-commit hooks, restricted to `src/*.tex`)
- **CI/CD**: GitHub Actions for LaTeX builds and releases
- **Scripting**: Python (for bibliography maintenance)

## Repository Structure
```
.
├── src/                          # All LaTeX source files
│   ├── root.tex                  # Main paper (all content inline)
│   ├── response.tex              # Response to reviewers (uses \externaldocument from root)
│   ├── supplement.tex            # Supplementary material
│   ├── cover_letter.tex          # Cover letter
│   ├── references.bib            # Bibliography
│   ├── ar2rc.cls                 # Custom class for response
│   ├── ieeeconf.cls              # IEEE conf class
│   ├── sn-mathphys.bst           # BST style
│   ├── .latexmkrc                # latexmk config (biber, pdflatex)
│   ├── arararc.yaml              # arara config (CWD=src/)
│   ├── rules/latexmk.yaml        # Custom arara rule
│   └── images/                   # All figures (PNG, PDF)
├── build/                        # Build output (gitignored)
│   ├── root/                     # root.pdf + aux files
│   ├── response/                 # response.pdf + aux files
│   ├── supplement/
│   └── cover_letter/
├── docs/                         # Notes and documentation
│   ├── 20260201_comments/        # Reviewer comments
│   ├── abstract.md
│   ├── Parameter Sensitivity.md
│   └── ...
├── scripts/                      # Utility scripts
│   └── update_bib_subdoi.py
├── arararc.yaml                  # arara config (project root)
├── Makefile
├── .github/workflows/            # CI (build-latex.yml, release.yml)
├── .pre-commit-config.yaml
└── CLAUDE.md
```

## Build Dependencies
- response.tex depends on root.tex (via `\externaldocument{../build/root/root}`)
- Build order: root must be built before response

## Images (in src/images/)
- cluster.png, ari_small.png, coc.png, cocomparison.png, optimisation.png, nmi_small.png, efficiency.png, workflow.png, orcid.pdf
