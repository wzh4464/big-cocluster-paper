# big-cocluster-paper

[![Build LaTeX document](https://github.com/wzh4464/big-cocluster-paper/actions/workflows/build-latex.yml/badge.svg)](https://github.com/wzh4464/big-cocluster-paper/actions/workflows/build-latex.yml)

## Overview

This paper presents DiMergeCo, an efficient framework for large-scale matrix co-clustering. DiMergeCo addresses computational bottlenecks in traditional co-clustering methods when processing large-scale data through a theoretically guaranteed probabilistic partitioning algorithm and a hierarchical merging strategy.

### Key Innovations

1. **Probabilistic Partitioning with Theoretical Guarantees**: Proposes a partitioning algorithm that preserves co-clustering structures during division, transforming the global co-clustering problem into independent local problems.
2. **Hierarchical Merging Strategy**: Designs a binary tree-based hierarchical merging strategy that eliminates central coordinator bottlenecks, reducing per-node communication complexity from O(n) to O(log n).
3. **Efficient Distributed Implementation**: Implements the solution through Message Passing Interface (MPI) where the main node only computes initial partitioning thresholds, effectively processing million-dimensional matrices.

## Authors

- **Zihan Wu** - Department of Electrical Engineering, City University of Hong Kong
- **Zhaoke Huang** - School of Data Science, City University of Hong Kong
- **Hong Yan** - Department of Electrical Engineering, City University of Hong Kong

## File Structure

- `root.tex`: Main LaTeX file
- `references.bib`: Bibliography database
- `images/`: Image folder
- `sections/`: Chapter contents
  - `introduction.tex`: Introduction
  - `related_work.tex`: Related work
  - `problem_formulation.tex`: Problem formulation
  - `proposed_model.tex`: Proposed model
  - `theoretical_foundations.tex`: Theoretical foundations
  - `experiment.tex`: Experimental evaluation
  - `conclusion.tex`: Conclusion

## Compilation Guide

This paper is written in LaTeX and can be compiled using:

### Using arara (recommended)

The paper header contains arara directives, simply run:

```bash
arara root.tex
```

### Manual Compilation

```bash
pdflatex --synctex=1 root.tex
biber root
pdflatex --synctex=1 root.tex
pdflatex --synctex=1 root.tex
```

### Requirements

- TeX Live 2021 or higher
- BibLaTeX + Biber
- IEEE Transactions template

## Contributions

For any questions or suggestions, please submit an issue or pull request.
