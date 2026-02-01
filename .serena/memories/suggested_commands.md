# Suggested Commands

## Building Documents
- `make` or `make all` — Build all documents in correct order (root → response, supplement, cover_letter)
- `make root` — Build main paper → `build/root/root.pdf`
- `make response` — Build reviewer response → `build/response/response.pdf` (auto-builds root first)
- `make supplement` — Build supplement → `build/supplement/supplement.pdf`
- `make cover_letter` — Build cover letter → `build/cover_letter/cover_letter.pdf`

## Using arara (alternative)
- `arara -v src/root.tex` — Build root via arara directives
- `arara -v src/response.tex` — Build response via arara (build root first!)
- `arara -v src/supplement.tex` — Build supplement
- `arara -v src/cover_letter.tex` — Build cover letter

## Cleaning
- `make clean` — Remove entire `build/` directory

## Formatting
- `latexindent <file>.tex` — Format a single TeX file
- Pre-commit hooks automatically run latexindent on staged `src/*.tex` files

## Viewing Output (macOS)
- `open build/root/root.pdf` — Open main paper PDF
- `open build/response/response.pdf` — Open response PDF

## Git / Version Control
- `git status` — Check working tree status
- `git log --oneline -10` — View recent commits
- `git diff` — View unstaged changes

## System Utilities (macOS / Darwin)
- `ls`, `find`, `grep` — Standard file utilities
