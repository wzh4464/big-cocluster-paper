# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a LaTeX-based academic paper repository for "DiMergeCo", presenting an efficient framework for large-scale matrix co-clustering. The main document is `root.tex` with supporting files including bibliography, images, and supplementary materials.

## Build System

### Primary Build Commands

- **Build main document**: `make` or `make all` - Compiles `root.tex` to PDF using latexmk with biber for bibliography
- **Clean build artifacts**: `make clean` - Removes all intermediate LaTeX files
- **Full clean**: `latexmk -CA` - Complete cleanup including PDFs

### Alternative Compilation Methods

1. **Using arara (recommended)**: `arara root.tex` - Uses arara directives in the document header
2. **Manual compilation**:
   ```bash
   pdflatex --synctex=1 root.tex
   biber root
   pdflatex --synctex=1 root.tex
   pdflatex --synctex=1 root.tex
   ```

### Build Configuration

- **Main LaTeX file**: `root.tex`
- **Bibliography system**: Uses biber (not bibtex) as configured in `.latexmkrc`
- **Watched directories**: `sections/` (though this directory doesn't currently exist), `images/`
- **Bibliography files**: `*.bib` (primarily `references.bib`)

## Repository Structure

### Core Files
- `root.tex` - Main LaTeX document with all content inline
- `references.bib` - Bibliography database
- `supplement.tex` - Supplementary material document
- `response.tex` - Response to reviewers document
- `cover_letter.tex` - Cover letter for journal submission

### Document Class and Style
- Uses IEEE Transactions journal format (`IEEEtran` class)
- Includes comprehensive LaTeX packages for algorithms, mathematics, graphics, and citations
- Configured for hyperlinks, cross-references, and theorem environments

### Development Tools
- **Pre-commit hooks**: Configured to run `latexindent` on all `.tex` files for formatting
- **Git integration**: Repository is version controlled with GitHub Actions for LaTeX builds
- **IDE configuration**: `.vscode/` directory contains VS Code settings

### Generated Files
The build process creates various intermediate files:
- `.aux`, `.bbl`, `.bcf`, `.log`, `.out`, `.synctex.gz` - LaTeX compilation artifacts
- `root.pdf` - Final compiled document

## Development Workflow

1. Edit LaTeX source files directly (content is primarily in `root.tex`)
2. Use `make` to build and test changes
3. Pre-commit hooks will automatically format `.tex` files with `latexindent`
4. Clean intermediate files with `make clean` when needed

## Bibliography Management

- Bibliography entries are stored in `references.bib`
- Uses biblatex with biber backend (configured in `.latexmkrc`)
- Python script `update_bib_subdoi.py` available for bibliography maintenance

## Requirements

- TeX Live 2021 or higher
- BibLaTeX + Biber
- IEEE Transactions LaTeX template
- `latexindent` for code formatting (used by pre-commit hooks)