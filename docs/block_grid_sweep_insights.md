# Block Grid Parameter Sweep: Experimental Insights

**Date**: 2026-02-01
**Dataset**: Classic4 benchmark (500 docs x 1000 features, 4 classes, 125 per class)
**Baseline**: SVD+KMeans on full matrix, NMI = 0.575

## Sweep Setup

Swept 40 configurations: 8 block grid shapes x 5 T_p values.

- Block grids: 2x2, 2x3, 3x2, 2x4, 4x2, 3x3, 4x4, 5x5
- T_p: 5, 10, 15, 20, 30
- Fixed: k=4, delta=0.05, threads=4

## Top 10 Results (sorted by NMI)

| Config   | Blocks | T_p | NMI    | Runtime | Co-clusters |
|----------|--------|-----|--------|---------|-------------|
| 2x4_i20  | 2x4    | 20  | 0.6908 | 2.57s   | 636         |
| 2x4_i30  | 2x4    | 30  | 0.6864 | 4.38s   | 955         |
| 2x3_i30  | 2x3    | 30  | 0.6790 | 3.83s   | 720         |
| 2x4_i10  | 2x4    | 10  | 0.6723 | 1.49s   | 318         |
| 2x3_i15  | 2x3    | 15  | 0.6691 | 1.97s   | 360         |
| 2x3_i20  | 2x3    | 20  | 0.6686 | 2.68s   | 480         |
| 2x3_i10  | 2x3    | 10  | 0.6675 | 1.29s   | 240         |
| 2x4_i15  | 2x4    | 15  | 0.6633 | 1.99s   | 477         |
| 5x5_i30  | 5x5    | 30  | 0.6596 | 2.59s   | 2940        |
| 3x3_i15  | 3x3    | 15  | 0.6457 | 1.51s   | 540         |

Previous 2x2 with T_p=10: NMI = 0.6049.
Larger grids (10x10): NMI = 0.058 (collapse).

## Insight 1: Asymmetric Block Grid Matches Matrix Aspect Ratio

The best block grid (2x4) has aspect ratio 1:2, matching the matrix shape (500x1000 = 1:2).

| Grid   | m/n ratio | Matrix M/N | NMI (T_p=10) |
|--------|-----------|------------|---------------|
| 2x4    | 0.50      | 0.50       | **0.6723**    |
| 2x3    | 0.67      | 0.50       | 0.6675        |
| 2x2    | 1.00      | 0.50       | 0.6049        |
| 3x3    | 1.00      | 0.50       | 0.5877        |
| 4x2    | 2.00      | 0.50       | 0.4717        |
| 4x4    | 1.00      | 0.50       | 0.2915        |
| 5x5    | 1.00      | 0.50       | 0.1519        |

**Pattern**: NMI is highest when `m/n approx M/N`. Each block then preserves the original matrix's local structure, which benefits the local SVD+KMeans.

**Implication for Algorithm 2**: The initialization `m = ceil(M/T_m), n = ceil(N/T_n)` should incorporate an aspect-ratio matching principle:

```
m/n should approximate M/N
```

Or equivalently, block dimensions should be roughly equal: `phi approx psi`, i.e., `M/m approx N/n`.

## Insight 2: Finite-Sample Block Size Lower Bound Is a Hard Constraint

The paper states (supplement): `min(phi_i, psi_j) >= 10 * log^2(max(m,n))`.

Checking against experimental results:

| Grid  | phi=M/m | psi=N/n | min(phi,psi) | Threshold 10*log^2(max) | NMI   |
|-------|---------|---------|--------------|-------------------------|-------|
| 2x2   | 250     | 500     | 250          | 5                       | 0.605 |
| 2x4   | 250     | 250     | 250          | 21                      | 0.672 |
| 3x3   | 167     | 333     | 167          | 13                      | 0.588 |
| 5x5   | 100     | 200     | 100          | 26                      | 0.152 |
| 10x10 | 50      | 100     | 50           | 53                      | 0.058 |

The 10x10 grid **violates** the lower bound (50 < 53), and indeed it collapses.
The 5x5 grid satisfies it (100 > 26) but local SVD quality is already degraded.

**Implication**: The theoretical lower bound is necessary but not sufficient. In practice, local spectral clustering requires substantially more samples per block. A practical rule of thumb:

```
min(phi, psi) >= max(10 * log^2(max(m,n)), C * k)
```

where `C approx 30-50` ensures enough samples per cluster for reliable SVD+KMeans.

## Insight 3: T_p Saturation and Merge Interaction

Fixing blocks at 2x4, varying T_p:

| T_p | NMI    | Co-clusters | Runtime |
|-----|--------|-------------|---------|
| 5   | 0.6401 | 159         | 0.72s   |
| 10  | 0.6723 | 318         | 1.49s   |
| 15  | 0.6633 | 477         | 1.99s   |
| 20  | 0.6908 | 636         | 2.57s   |
| 30  | 0.6864 | 955         | 4.38s   |

**Theory predicts** monotonic increase in detection probability P with T_p.
**Experiment shows** NMI is non-monotonic: rises to T_p=20 then slightly declines.

The gap is explained by the merge step. More iterations produce more co-clusters (636 at T_p=20, 955 at T_p=30). The current Union merge strategy (exact-index deduplication) does not consolidate highly overlapping co-clusters. At T_p=30, redundant co-clusters create noise in the consensus K-means step.

**Implication**: The paper's detection probability guarantee holds (more iterations = higher detection probability), but the final clustering quality depends on:

1. **Detection** (improved by T_p) -- what the theorem guarantees
2. **Merge quality** (potentially degraded by excess co-clusters) -- not covered by the theorem

This suggests:
- The theoretical analysis should distinguish between detection probability and end-to-end clustering quality
- An overlap-based merge with Jaccard threshold (tau = 0.45 as in the paper) would likely raise the effective T_p ceiling
- There exists a practical T_p* that depends on the merge strategy

## Insight 4: Efficiency Sweet Spot

| Config   | NMI    | Runtime | NMI/second |
|----------|--------|---------|------------|
| 2x3_i10  | 0.6675 | 1.29s   | **0.518**  |
| 2x4_i10  | 0.6723 | 1.49s   | 0.451      |
| 2x4_i20  | 0.6908 | 2.57s   | 0.269      |
| 2x4_i30  | 0.6864 | 4.38s   | 0.157      |

For practical use, **2x3 blocks with T_p=10** achieves 97% of the best NMI at half the runtime.

## Suggested Paper Modifications

### Algorithm 2 (Adaptive Matrix Partitioning)

Add to the initialization step:

> **Aspect-ratio matching**: Choose m, n such that M/m approx N/n (equal block dimensions), subject to `min(M/m, N/n) >= C*k` for a constant C >= 30.

### Theorem Discussion

Add a remark after the preservation theorem:

> **Remark**: The detection probability P increases monotonically with T_p. However, the end-to-end clustering quality (e.g., NMI) may saturate or slightly decrease beyond a practical threshold T_p*, due to the accumulation of redundant co-clusters in the merge phase. The value of T_p* depends on the merge strategy: overlap-based merging with quality scoring tolerates larger T_p than simple union deduplication.

### Experimental Section

Add a sensitivity analysis:

1. **Block grid shape sensitivity**: Fix T_p, vary m x n across symmetric and asymmetric grids. Show that optimal m/n correlates with M/N.
2. **T_p saturation curve**: Fix optimal block grid, plot NMI vs T_p. Show diminishing returns and identify practical T_p*.
3. **Block size lower bound validation**: Show NMI collapse when min(phi, psi) approaches the theoretical lower bound 10*log^2(max(m,n)).
