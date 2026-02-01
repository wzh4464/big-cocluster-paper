# Suggested Commands

## Building the Paper
- `make` or `make all` — Build all documents (root, response, supplement, cover_letter)
- `make root` — Build main paper → `build/root/root.pdf`
- `arara -v src/root.tex` — Alternative build using arara directives

## Cleaning
- `make clean` — Remove entire `build/` directory

## Building Other Documents
- `make response` — Build reviewer response → `build/response/response.pdf` (depends on root)
- `make supplement` — Build supplement → `build/supplement/supplement.pdf`
- `make cover_letter` — Build cover letter → `build/cover_letter/cover_letter.pdf`
- `arara -v src/response.tex` — Build response via arara (build root first!)

## Formatting
- `latexindent <file>.tex` — Format a single TeX file
- Pre-commit hooks automatically run latexindent on staged `.tex` files

## Git / Version Control
- `git status` — Check working tree status
- `git log --oneline -10` — View recent commits
- `git diff` — View unstaged changes

## System Utilities (macOS / Darwin)
- `open root.pdf` — Open PDF in default viewer
- `ls`, `find`, `grep` — Standard file utilities
