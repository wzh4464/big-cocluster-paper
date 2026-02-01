# Task Completion Checklist

After completing an editing task on this LaTeX project:

1. **Verify LaTeX syntax** — Ensure no unmatched braces, missing `\end{}` tags, or broken commands
2. **Build the document** — Run `make` to confirm it compiles without errors
3. **Check bibliography** — If references were added/modified, ensure `references.bib` entries are correct and biber resolves them
4. **Review formatting** — Run `latexindent` on modified `.tex` files (or rely on pre-commit hooks)
5. **Check cross-references** — If labels were added/changed, verify `\ref`, `\cref`, `\label` consistency
6. **Visual check** — Open the generated PDF to verify figures, tables, and formatting look correct (`open root.pdf` on macOS)
