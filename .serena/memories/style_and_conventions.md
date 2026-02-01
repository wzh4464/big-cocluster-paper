# Style and Conventions

## LaTeX Style
- **Document class**: `\documentclass[journal]{IEEEtran}` (IEEE Transactions format)
- **All content is inline** in `root.tex` — no separate section files
- **Bibliography**: BibLaTeX with Biber (NOT bibtex). Configured in `.latexmkrc` with `$bibtex_use = 2`
- **Formatting tool**: `latexindent` is enforced via pre-commit hooks on all `.tex` files

## Key Packages Used
- `amsmath`, `amssymb`, `amsthm` — Mathematics
- `algorithm`, `algorithmic` — Algorithm typesetting
- `graphicx`, `subcaption` — Graphics and subfigures
- `hyperref`, `cleveref`, `doi` — Cross-references and links
- `tcolorbox` — Colored boxes
- `xcolor`, `color` — Colors (note: blue is redefined to black `\definecolor{blue}{rgb}{0,0,0}`)
- `csquotes` — Quotation handling
- `enumitem` — List customization

## Theorem Environments
- `theorem`, `lemma`, `proposition`, `corollary` (numbered together)
- `definition`, `example` (separate numbering)
- `remark` style also defined

## Commit Messages
- Commit messages are written in Chinese (中文)
- Descriptive of the changes made

## Pre-commit Hooks
- Runs `latexindent` on all `.tex` files before commit
- Binary path: `/Library/TeX/texbin/latexindent`
