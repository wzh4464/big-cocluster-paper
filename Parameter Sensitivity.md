# Parameter Sensitivity

## Figure 1: Block Size Sensitivity Analysis

**Reference:** `fig:block_sensitivity`

### Experimental Settings

```
Datasets: CLASSIC4, Amazon
Partition configurations: 5×5 (25), 6×6 (36), 8×8 (64), 10×10 (100), 12×12 (144), 14×14 (196)
Fixed parameters: Tm = Tn = 10, P_thresh = 0.95, Tp = 4
Metrics to measure: NMI, ARI, Runtime (seconds), Memory usage (MB), Detection rate (%)
```

### Figure Design

- **Multi-panel figure (2×2 layout)**
- Panel A: NMI vs Total Partitions (line plot with error bars)
- Panel B: ARI vs Total Partitions (line plot with error bars)
- Panel C: Runtime vs Total Partitions (bar chart)
- Panel D: Detection Rate vs Total Partitions (line plot)
- **X-axis:** Total partition count (25, 36, 64, 100, 144, 196)
- **Colors:** CLASSIC4 (blue), Amazon (orange)
- **Highlight:** Optimal region around 100 partitions with shaded area

## Figure 2: Threshold Parameter Sensitivity

**Reference:** `fig:threshold_sensitivity`

### Experimental Settings

```
Datasets: Synthetic data with embedded co-clusters of sizes {5×5, 10×10, 20×20, 50×50}
Threshold values: Tm = Tn ∈ {5, 10, 15, 20, 30, 50, 75, 100}
Fixed parameters: 10×10 partitions, P_thresh = 0.95, Tp = 4
Metrics: Detection rate by co-cluster size, False positive rate, F1-score
```

### Figure Design

- **Multi-panel figure (1×3 layout)**
- Panel A: Detection Rate vs Threshold (multiple lines for different co-cluster sizes)
- Panel B: False Positive Rate vs Threshold (single line)
- Panel C: F1-Score vs Threshold (single line)
- **X-axis:** Threshold values (5, 10, 15, 20, 30, 50, 75, 100)
- **Highlight:** Optimal region (10-30) with vertical dashed lines

## Figure 3: Probability Threshold Sensitivity

**Reference:** `fig:probability_sensitivity`

### Experimental Settings

```
Datasets: CLASSIC4, Amazon
P_thresh values: {0.80, 0.85, 0.90, 0.95, 0.99}
Fixed parameters: 10×10 partitions, Tm = Tn = 10, Tp = 4
Metrics: NMI, ARI, Precision, Recall, Computation time
```

### Figure Design

- **Multi-panel figure (2×2 layout)**
- Panel A: NMI vs P_thresh (line plot, both datasets)
- Panel B: ARI vs P_thresh (line plot, both datasets)
- Panel C: Precision vs Recall (scatter plot with P_thresh as color)
- Panel D: Computation Time vs P_thresh (bar chart)
- **X-axis:** P_thresh values (0.80, 0.85, 0.90, 0.95, 0.99)
- **Highlight:** Optimal point at 0.95

## Figure 4: Parameter Interaction Analysis

**Reference:** `fig:parameter_interaction`

### Experimental Settings

```
Parameter combinations:
- Partition count: {64, 100, 144}
- P_thresh: {0.85, 0.90, 0.95, 0.99}
- Tm: {10, 20, 30}
Total combinations: 3×4×3 = 36 experiments
Dataset: CLASSIC4 (for computational feasibility)
Metric: NMI (primary), Runtime (secondary)
```

### Figure Design

- **Multi-panel figure (1×3 layout)**
- Panel A: 3D surface plot (P_thresh × Tm × NMI, with partition count as separate surfaces)
- Panel B: Heatmap (P_thresh vs Tm, NMI as color, averaged over partition counts)
- Panel C: Runtime heatmap (Partition count vs P_thresh, Tm fixed at 20)

## Enhanced Figure: Optimization Analysis

**Reference:** `fig:optimisation` (existing, needs enhancement)

### Current Settings (keep)

```
Partition counts: 25, 36, 49, 81, 100, 121
Metrics: Number of repetitions, Computation time
```

### Enhancement Needed

- Add third metric: Quality score (average NMI)
- Add confidence intervals from multiple runs
- Enhance caption to reference the broader parameter analysis

## Implementation Recommendations

### Data Collection Protocol

1. **Multiple runs**: 5 independent runs per configuration for statistical reliability
2. **Error bars**: Standard deviation or 95% confidence intervals
3. **Synthetic data generation**: For threshold sensitivity, create controlled datasets with known ground truth

### Figure Quality Standards

- **Resolution**: 300 DPI minimum for publication
- **Font size**: 12pt minimum for readability
- **Color scheme**: Colorblind-friendly palette
- **Annotations**: Clear legends, axis labels, and optimal region highlighting

### Statistical Validation

- Include p-values for significant differences
- Report effect sizes for parameter changes
- Add correlation coefficients for interaction analysis

This comprehensive figure set will provide strong empirical support for your parameter sensitivity claims and directly address Reviewer 1's concerns about parameter selection guidance.
