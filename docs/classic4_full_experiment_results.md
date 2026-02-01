# Classic4 Full Dataset Experiment Results

## Dataset
- **Matrix**: 6460 x 4667 (matching paper's dimensions)
- **Classes**: 4 (Cranfield: 1398, CISI: 1460, MEDLINE: 1033, CACM: 2569)
- **Seeds**: 3 per config (note: effectively 1 due to deterministic partitioning bug)

## Baseline

| Method | NMI | ARI | Time (s) |
|--------|-----|-----|----------|
| SVD + KMeans (our impl) | 0.7908 | 0.7498 | 1930 |
| SCC (paper reported) | 0.922 | 0.771 | — |
| DiMergeCo-SCC (paper) | 0.865 | 0.776 | 112.5 |

**Baseline gap**: Our SVD+KMeans baseline gets NMI=0.791 vs paper's 0.922 (14% lower). This likely reflects differences in data preprocessing, feature selection, or SVD implementation.

## DiMergeCo Results — Top Configs

Sorted by NMI. All using SVD as local clusterer.

| Config | Blocks | T_p | NMI | ARI | Time (s) | NMI/Baseline |
|--------|--------|-----|-----|-----|----------|--------------|
| 2x2_tp20 | 2x2 | 20 | **0.7462** | 0.6815 | 5559 | 94.4% |
| 3x2_tp20 | 3x2 | 20 | 0.7438 | 0.6638 | 3681 | 94.1% |
| 2x3_tp30 | 2x3 | 30 | 0.7435 | 0.6465 | 3176 | 94.0% |
| 3x2_tp30 | 3x2 | 30 | 0.7424 | 0.6530 | 4583 | 93.9% |
| 3x2_tp10 | 3x2 | 10 | 0.7423 | 0.6749 | 2323 | 93.9% |
| 2x2_tp10 | 2x2 | 10 | 0.7418 | **0.6905** | 3418 | 93.8% |
| 2x2_tp5 | 2x2 | 5 | 0.7382 | 0.6595 | 2057 | 93.3% |
| 2x3_tp20 | 2x3 | 20 | 0.7338 | 0.6256 | 2598 | 92.8% |
| 2x4_tp30 | 2x4 | 30 | 0.7294 | 0.5866 | 2319 | 92.2% |
| 2x4_tp20 | 2x4 | 20 | 0.7290 | 0.5834 | 1905 | 92.2% |
| 3x3_tp30 | 3x3 | 30 | 0.7289 | 0.6013 | 4238 | 92.2% |
| 3x3_tp20 | 3x3 | 20 | 0.7258 | 0.5980 | 3207 | 91.8% |
| 2x3_tp10 | 2x3 | 10 | 0.7251 | 0.5892 | 1572 | 91.7% |
| 3x3_tp10 | 3x3 | 10 | 0.7244 | 0.6337 | 2218 | 91.6% |
| 2x4_tp10 | 2x4 | 10 | 0.7189 | 0.5981 | 1080 | 90.9% |
| 2x3_tp5 | 2x3 | 5 | 0.7155 | 0.5962 | 1020 | 90.5% |

## DiMergeCo Results — Full Grid (sorted by NMI)

| Config | M | N | T_p | NMI | ARI | Time (s) |
|--------|---|---|-----|-----|-----|----------|
| 2x2_tp20 | 2 | 2 | 20 | 0.7462 | 0.6815 | 5559 |
| 3x2_tp20 | 3 | 2 | 20 | 0.7438 | 0.6638 | 3681 |
| 2x3_tp30 | 2 | 3 | 30 | 0.7435 | 0.6465 | 3176 |
| 3x2_tp30 | 3 | 2 | 30 | 0.7424 | 0.6530 | 4583 |
| 3x2_tp10 | 3 | 2 | 10 | 0.7423 | 0.6749 | 2323 |
| 2x2_tp10 | 2 | 2 | 10 | 0.7418 | 0.6905 | 3418 |
| 2x2_tp5 | 2 | 2 | 5 | 0.7382 | 0.6595 | 2057 |
| 2x3_tp20 | 2 | 3 | 20 | 0.7338 | 0.6256 | 2598 |
| 2x4_tp30 | 2 | 4 | 30 | 0.7294 | 0.5866 | 2319 |
| 2x4_tp20 | 2 | 4 | 20 | 0.7290 | 0.5834 | 1905 |
| 3x3_tp30 | 3 | 3 | 30 | 0.7289 | 0.6013 | 4238 |
| 3x3_tp20 | 3 | 3 | 20 | 0.7258 | 0.5980 | 3207 |
| 2x3_tp10 | 2 | 3 | 10 | 0.7251 | 0.5892 | 1572 |
| 4x3_tp30 | 4 | 3 | 30 | 0.7249 | 0.5995 | 3359 |
| 3x4_tp30 | 3 | 4 | 30 | 0.7244 | 0.5709 | 2608 |
| 3x3_tp10 | 3 | 3 | 10 | 0.7244 | 0.6337 | 2218 |
| 4x3_tp20 | 4 | 3 | 20 | 0.7239 | 0.6220 | 2786 |
| 3x4_tp20 | 3 | 4 | 20 | 0.7235 | 0.5986 | 1967 |
| 2x4_tp10 | 2 | 4 | 10 | 0.7189 | 0.5981 | 1080 |
| 2x3_tp5 | 2 | 3 | 5 | 0.7155 | 0.5962 | 1020 |
| 4x4_tp30 | 4 | 4 | 30 | 0.7018 | 0.5278 | 3094 |
| 5x4_tp30 | 5 | 4 | 30 | 0.6856 | 0.5157 | 2849 |
| 4x5_tp30 | 4 | 5 | 30 | 0.6830 | 0.5007 | 2267 |
| 5x5_tp30 | 5 | 5 | 30 | 0.6651 | 0.4914 | 2650 |
| 3x2_tp5 | 3 | 5 | 5 | 0.6189 | 0.4844 | 1408 |
| 4x3_tp10 | 4 | 3 | 10 | 0.5209 | 0.4310 | 1935 |
| 3x3_tp5 | 3 | 3 | 5 | 0.5164 | 0.3974 | 1228 |
| 4x4_tp20 | 4 | 4 | 20 | 0.4261 | 0.2672 | 2562 |
| 2x4_tp5 | 2 | 4 | 5 | 0.4263 | 0.2866 | 634 |
| 5x4_tp20 | 5 | 4 | 20 | 0.4201 | 0.2586 | 2343 |
| 4x5_tp20 | 4 | 5 | 20 | 0.4035 | 0.2184 | 1742 |
| 5x5_tp20 | 5 | 5 | 20 | 0.3940 | 0.2054 | 1983 |
| 6x5_tp30 | 6 | 5 | 30 | 0.3915 | 0.2105 | 2345 |
| 3x4_tp10 | 3 | 4 | 10 | 0.2696 | 0.1592 | 1320 |
| 3x4_tp5 | 3 | 4 | 5 | 0.2640 | 0.1535 | 700 |
| 10x7_tp30 | 10 | 7 | 30 | 0.1498 | 0.0231 | 1410 |
| 8x6_tp30 | 8 | 6 | 30 | 0.1340 | 0.0553 | 1722 |
| 10x7_tp20 | 10 | 7 | 20 | 0.0731 | 0.0453 | 1111 |
| 8x6_tp20 | 8 | 6 | 20 | 0.0252 | 0.0321 | 1348 |
| 10x7_tp10 | 10 | 7 | 10 | 0.0059 | 0.0281 | 563 |
| 8x6_tp5 | 8 | 5 | 5 | 0.0029 | 0.0149 | 386 |
| 8x6_tp10 | 8 | 6 | 10 | 0.0018 | 0.0120 | 749 |
| 6x5_tp5 | 6 | 5 | 5 | 0.0013 | -0.002 | 625 |
| All 4x4–5x5 tp5/tp10 | — | — | — | <0.001 | ~0 | — |

## Key Findings

### 1. Block Grid Size Is Critical (Sharp Phase Transition)

There is a **sharp phase transition** in NMI based on block grid size:

- **2x2 to 3x3**: NMI = 0.72–0.75 (>90% of baseline)
- **3x4 to 4x4**: NMI = 0.27–0.72 (depends heavily on T_p)
- **5x5+**: NMI < 0.01 with T_p ≤ 10, barely recoverable with T_p = 30

**Root cause**: With 6460 docs in 5+ row blocks, each block has ~1290 docs. The 4 clusters (sizes 1398, 1460, 1033, 2569) get severely fragmented.

### 2. T_p Helps But Saturates

For a fixed block grid, NMI improves with T_p but saturates:

| Block Grid | T_p=5 | T_p=10 | T_p=20 | T_p=30 |
|------------|-------|--------|--------|--------|
| 2x2 | 0.7382 | 0.7418 | **0.7462** | (pending) |
| 2x3 | 0.7155 | 0.7251 | 0.7338 | 0.7435 |
| 3x2 | 0.6189 | 0.7423 | **0.7438** | 0.7424 |
| 3x3 | 0.5164 | 0.7244 | 0.7258 | 0.7289 |
| 4x3 | 0.0008 | 0.5209 | 0.7239 | 0.7249 |
| 5x5 | 0.0008 | 0.0008 | 0.3940 | 0.6651 |

Saturation typically occurs around T_p=10–20 for small grids, but T_p=30 still helps large grids.

### 3. Aspect Ratio Matters

The matrix ratio M/N = 6460/4667 ≈ 1.38. Block grids where m/n ≈ M/N tend to perform better:

- **3x2** (ratio 1.5, close to 1.38): NMI=0.7438 at T_p=20
- **2x3** (ratio 0.67, inverse): NMI=0.7435 at T_p=30 (needs more T_p to compensate)
- **2x2** (ratio 1.0): NMI=0.7462 at T_p=20 (slightly better overall, but slower)

### 4. DiMergeCo NMI/Baseline Ratio ≈ 94%

Our best DiMergeCo achieves 94.4% of our baseline NMI. The paper reports DiMergeCo at 93.8% of its baseline (0.865/0.922). This ratio is **consistent**, suggesting the algorithm works correctly and the baseline gap is due to implementation differences.

| | Paper | Ours |
|--|-------|------|
| Baseline NMI | 0.922 | 0.791 |
| DiMergeCo NMI | 0.865 | 0.746 |
| Ratio | 93.8% | 94.4% |

### 5. ARI Tells a Different Story

While NMI is best for 2x2_tp20, ARI is best for **2x2_tp10** (0.6905). The 2x2 grid consistently has the highest ARI across T_p values, suggesting it preserves cluster boundaries better than larger grids.

### 6. Time vs Quality Tradeoff

| Config | NMI | Time (s) | Speedup vs Baseline |
|--------|-----|----------|---------------------|
| Baseline | 0.7908 | 1930 | 1.0x |
| 2x3_tp5 | 0.7155 | 1020 | 1.9x |
| 2x4_tp10 | 0.7189 | 1080 | 1.8x |
| 2x3_tp10 | 0.7251 | 1572 | 1.2x |
| 2x2_tp5 | 0.7382 | 2057 | 0.9x (slower) |
| 2x2_tp20 | 0.7462 | 5559 | 0.3x (3x slower) |

**DiMergeCo is NOT faster** for this dataset size with our implementation. The paper's 112.5s speedup likely comes from:
1. More efficient local clustering (not full SVD on each sub-matrix)
2. C/MATLAB implementation with better BLAS integration
3. Different partitioning strategy

## Experimental Setup

- Server: 144-core machine
- Parallelism: 57 configs run simultaneously via `xargs -P`, each using 2 OpenBLAS threads
- Block grids tested: 2x2, 2x3, 3x2, 3x3, 2x4, 3x4, 4x3, 4x4, 5x4, 4x5, 5x5, 6x5, 8x6, 10x7
- T_p values: 5, 10, 20, 30
- Total experiment wall time: ~5 hours
