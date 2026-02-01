# Review Decision — IEEE TSMC: Systems

**Date:** 18-Dec-2025
**Decision:** Reject with invitation to resubmit as new submission

> Based on the referee reports and the Associate Editors recommendation with which I concur, I regret to inform you that your paper, in its current form, cannot be accepted for publication in the Transactions. Your paper does have merit and you are welcome to revise the manuscript keeping in mind the reviewer comments and to resubmit your paper as a new submission.

— Robert Kozma, Editor-In-Chief

---

## Editor Comments

### Senior Editor

Based on the reviewers' feedback and the AE's recommendation, the authors are required to conduct additional experimental analyses and further refine the manuscript.

### Associate Editor

Please address the comments issued by the reviewers.

---

## Reviewer 1

### Contributions (recognised)

DiMergeCo is a distributed co-clustering algorithm designed to handle massive matrices by dividing the problem into smaller, parallel tasks. It operates in three phases:

1. **Probabilistic Partitioning:** The matrix is split probabilistically to preserve meaningful co-clusters.
2. **Local Co-clustering:** Each submatrix is processed in parallel on separate nodes using existing co-clustering algorithms.
3. **Hierarchical Merging:** Local results are merged using a binary tree communication pattern, reducing bottlenecks and scaling efficiently across nodes.

Key contributions:

a) Theoretically-Guaranteed Probabilistic Partitioning: A novel algorithm for partitioning large matrices in a way that probabilistically preserves co-clusters within submatrices.

b) Communication-Optimal Hierarchical Merging Strategy: A binary tree-based approach for merging local co-clustering results, reducing the dependency on a central coordinator and optimizing communication overhead.

c) Integrated Algorithmic Framework with Theoretical Foundations: A comprehensive framework that integrates the above two ideas, backed by theoretical guarantees (error bounds and convergence guarantees).

### Requested Improvements

1. **Statistical Significance:** The results in Table I (Clustering Quality) are presented as single values. For DiMergeCo it is expected to run experiments with multiple random seeds and report the mean and standard deviation. A statistical significance test (e.g., a paired t-test) showing that DiMergeCo's improvements are statistically significant would strengthen the claims.

2. **Direct Scalability Comparison:** The scalability analysis in Figure 4 only shows DiMergeCo's own performance. It would be very powerful to include a scalability comparison with the strongest baseline, like PNMTF, on the same cluster.

3. **Memory Usage Profiling:** For large-scale data analysis, memory footprint is as important as time. The fact that SCC and others fail on large datasets (denoted by \*) is likely due to memory constraints. Explicitly reporting the peak memory usage on the large datasets (Amazon, RCV1) would provide a more complete picture of resource efficiency.

4. **Clarity on "Amazon 1000":** There is an inconsistency. The main dataset is called "Amazon" (123,321 docs), but the scalability analysis uses "Amazon 1000". Is this a subset? A different dataset? This should be clarified in the text or a footnote.

---

## Reviewer 2

### Contributions (recognised)

*(Attached — no inline text provided.)*

### Detailed Comments (from attachment)

**Overall Evaluation:**
This paper presents DiMergeCo, a scalable co-clustering framework that integrates probabilistic partitioning, local clustering, and a hierarchical merging strategy. The authors provide theoretical analysis and experimental validation on several datasets.

1. **Theoretical gap in hierarchical merging:** The theoretical framework contains a fundamental break. While rigorous probabilistic guarantees and error bounds are provided for the matrix partitioning and local co-clustering stages (Theorems 4 and 6), the crucial "hierarchical merging" step is explicitly labeled as a heuristic method (Remark 1). This merging process optimizes a self-designed composite score. It neither guarantees monotonic decrease of the globally defined objective function $J$, nor provides any approximation ratio guarantee regarding how closely its output solution approaches the global optimum. This results in a lack of strict theoretical support for the quality of the final global solution derived from the theoretically guaranteed local solutions, severely weakening the theoretical integrity of the entire algorithm.

2. **Presentation quality and notation inconsistencies:** The presentation quality of the manuscript fails to meet publication standards, containing several clear errors and inconsistencies. The data matrix is sometimes denoted in bold ($\mathbf{A}$) and sometimes in plain font ($A$) in the main text; the co-cluster set is defined as $\mathbf{C}_k$ in the notation table but appears as $C_k$ in the appendix proofs; the block size parameters in the algorithm pseudocode ($\vartheta_i, \varpi_j$) do not match those used in the main body of the text ($\phi_i, \psi_j$).

3. **Insufficient comparative baselines:** The selection of comparative methods in the experimental section (SCC, PNMTF, ONMTF, etc.) does not sufficiently demonstrate DiMergeCo's advancement in the current technological context. The lack of comparison with baseline methods based on modern distributed computing frameworks, or other recently proposed co-clustering algorithms, undermines the persuasiveness of the paper's claims regarding "significant performance improvement" and "architectural advancement."
