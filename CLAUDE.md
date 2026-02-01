# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a LaTeX-based academic paper repository for "DiMergeCo", presenting an efficient framework for large-scale matrix co-clustering. Source files live in `src/`, build output goes to `build/`.

## Repository Structure

```
.
├── src/                          # All LaTeX source files
│   ├── root.tex                  # Main paper
│   ├── response.tex              # Reviewer response
│   ├── supplement.tex            # Supplementary material
│   ├── cover_letter.tex          # Cover letter
│   ├── references.bib            # Bibliography
│   ├── ar2rc.cls                 # Custom class for response
│   ├── ieeeconf.cls              # IEEE conf class
│   ├── sn-mathphys.bst           # BST style
│   ├── .latexmkrc                # latexmk config
│   ├── arararc.yaml              # arara config (for CWD=src/)
│   ├── rules/                    # Custom arara rules
│   │   └── latexmk.yaml
│   └── images/                   # All figures
│       └── *.png, *.pdf
├── build/                        # Build output (gitignored)
│   ├── root/
│   ├── response/
│   ├── supplement/
│   └── cover_letter/
├── docs/                         # Notes and documentation
│   ├── abstract.md
│   ├── Parameter Sensitivity.md
│   ├── cover_letter_and_diff.md
│   ├── Diff_statement.md
│   └── comments.docx
├── scripts/                      # Utility scripts
│   └── update_bib_subdoi.py
├── arararc.yaml                  # arara config (project root)
├── Makefile
├── .gitignore
├── .pre-commit-config.yaml
├── .github/workflows/
├── README.md, CLAUDE.md, License.txt
```

## Build System

### Primary Build Commands

- **Build everything**: `make` or `make all` - Builds all documents in correct order
- **Build individual documents**:
  - `make root` - Compiles main paper to `build/root/root.pdf`
  - `make response` - Compiles reviewer response (depends on root) to `build/response/response.pdf`
  - `make supplement` - Compiles supplement to `build/supplement/supplement.pdf`
  - `make cover_letter` - Compiles cover letter to `build/cover_letter/cover_letter.pdf`
- **Clean build artifacts**: `make clean` - Removes the entire `build/` directory

### Using arara (from project root)

```bash
arara -v src/root.tex          # -> build/root/root.pdf
arara -v src/response.tex      # -> build/response/response.pdf (build root first!)
arara -v src/supplement.tex    # -> build/supplement/supplement.pdf
arara -v src/cover_letter.tex  # -> build/cover_letter/cover_letter.pdf
```

### Build Configuration

- **Source directory**: `src/`
- **Build output**: `build/<target>/`
- **Bibliography system**: Uses biber (not bibtex) as configured in `src/.latexmkrc`
- **Build engine**: latexmk with `-cd` flag (changes to source directory before compiling)
- **Build order**: `response.tex` depends on `root.tex` (uses `\externaldocument`)

## Document Class and Style

- Main paper uses IEEE Transactions journal format (`IEEEtran` class)
- Response letter uses custom `ar2rc` class
- Configured for hyperlinks, cross-references, and theorem environments

## Development Tools

- **Pre-commit hooks**: Configured to run `latexindent` on `src/*.tex` files for formatting
- **Git integration**: Repository is version controlled with GitHub Actions for LaTeX builds
- **IDE configuration**: `.vscode/` directory contains VS Code / LaTeX Workshop settings

## Development Workflow

1. Edit LaTeX source files in `src/`
2. Use `make` to build (or `make root` for just the main paper)
3. PDFs appear in `build/<target>/`
4. Pre-commit hooks automatically format `.tex` files with `latexindent`
5. Clean build output with `make clean`

## Bibliography Management

- Bibliography entries are stored in `src/references.bib`
- Uses biblatex with biber backend (configured in `src/.latexmkrc`)
- Python script `scripts/update_bib_subdoi.py` available for bibliography maintenance

## Requirements

- TeX Live 2021 or higher
- BibLaTeX + Biber
- IEEE Transactions LaTeX template
- arara (optional, for directive-based builds)
- `latexindent` for code formatting (used by pre-commit hooks)
