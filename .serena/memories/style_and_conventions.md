# Style and Conventions

## LaTeX Style
- **Document class**: `\documentclass[journal]{IEEEtran}` (IEEE Transactions format)
- **All content is inline** in `src/root.tex` — no separate section files
- **Bibliography**: BibLaTeX with Biber (NOT bibtex). Configured in `src/.latexmkrc` with `$bibtex_use = 2`
- **Formatting tool**: `latexindent` is enforced via pre-commit hooks on `src/*.tex` files
- **Build output**: All build artifacts go to `build/<target>/`, never alongside source files

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

## Cross-Document References
- `response.tex` uses `\externaldocument{../build/root/root}` (xr package) to reference labels from root.tex
- This requires root to be built first

## Build System Convention
- Each .tex file has an arara directive: `% arara: latexmk: { options: ["-cd", "-outdir=../build/<target>"] }`
- The `-cd` flag makes latexmk change to the source file's directory, so all relative paths resolve from `src/`
- `\graphicspath{{images/}}` and `\bibliography{references}` work because CWD is `src/`

## Commit Messages
- Commit messages are written in Chinese (中文) or English
- Descriptive of the changes made

## Pre-commit Hooks
- Runs `latexindent` on `src/*.tex` files before commit
- Binary path: `/Library/TeX/texbin/latexindent`
