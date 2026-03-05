# 缺失实验执行计划

按优先级排列。所有命令在 **服务器** 上执行（需要 OpenBLAS）。

---

## 优先级 1：DiMergeCo-SCC on Classic4（10 seeds）

**当前状态：** 仅有 Rust 单 seed (NMI=0.749, ARI=0.681)
**目标：** 10 seeds 的 mean±std

### 方案 A：Python DiMergeCo（推荐，已有脚本）
```bash
cd /home/jie/fast_cocluster
uv run python baselines/run_dimerge_co_variants.py \
  --dataset classic4 \
  --methods SCC-Dhillon \
  --seeds 0,1,2,3,4,5,6,7,8,9 \
  --m-blocks 2 --n-blocks 2 --t-p 30
```
输出: `baselines/results/classic4_dimerge_co_variants.json`

### 方案 B：Rust（需修改代码加多 seed 支持）
```bash
cd /home/jie/fast_cocluster
# 需修改 examples/evaluate_classic4.rs 增加 seed 循环
cargo run --release --example evaluate_classic4
```

---

## 优先级 2：BCW 数据集准备 + 全部方法实验

**当前状态：** 无 BCW 数据
**目标：** 下载数据 + 7 个方法 × 10 seeds

### Step 1: 下载 BCW 数据
```bash
cd /home/jie/fast_cocluster
uv run python -c "
from sklearn.datasets import load_breast_cancer
import numpy as np
data = load_breast_cancer()
np.save('data/bcw.npy', data.data)
np.save('data/bcw_labels.npy', data.target)
print(f'Shape: {data.data.shape}, Classes: {len(set(data.target))}')
"
```

### Step 2: 跑 standalone 基线
需要新建脚本 `baselines/run_bcw_baselines.py`（参考 `run_classic4_baselines.py`）
- 方法: SpectralCC, NBVD, ONM3F, ONMTF, PNMTF, FNMF
- k=2（BCW 是二分类）

### Step 3: 跑 DiMergeCo variants
```bash
uv run python baselines/run_dimerge_co_variants.py \
  --dataset bcw \
  --methods SCC-Dhillon,SpectralCC \
  --seeds 0,1,2,3,4,5,6,7,8,9 \
  --n-clusters 2 --m-blocks 2 --n-blocks 2 --t-p 10
```
注意：`run_dimerge_co_variants.py` 目前可能不支持 `--dataset bcw`，需要先加载数据逻辑。

---

## 优先级 3：Amazon 数据集实验

**当前状态：** 有 `amazon_electronics_sparse.npz`，但无标签、无实验结果
**目标：** 确认是否有真实标签（co-clustering 通常不需要外部标签）

### 检查数据
```bash
cd /home/jie/fast_cocluster
uv run python -c "
import scipy.sparse as sp, numpy as np
d = sp.load_npz('data/amazon_electronics_sparse.npz')
print(f'Shape: {d.shape}, nnz: {d.nnz}, density: {d.nnz/(d.shape[0]*d.shape[1]):.6f}')
"
```

### 注意
Amazon 数据集通常用于可扩展性演示（大矩阵），不一定有 ground-truth 标签用于 NMI/ARI 评估。
需要确认论文中 Amazon 数据集的评估方式（是否用内部指标如重建误差，还是有外部标签）。

---

## 优先级 4：RCV1-Large DiMergeCo-SCC

**当前状态：** 仅有 FNMF baseline (10 seeds, NMI≈0.30)
**目标：** DiMergeCo-SCC on RCV1

### Rust 方式
```bash
cd /home/jie/fast_cocluster
RUST_LOG=info cargo run --release --example evaluate_rcv1_all
```

### Python 方式
```bash
uv run python baselines/run_dimerge_co_variants.py \
  --dataset rcv1 \
  --rcv1-subset train \
  --methods SCC-Dhillon \
  --seeds 0,1,2,3,4,5,6,7,8,9 \
  --m-blocks 2 --n-blocks 2 --t-p 30
```

---

## 优先级 5：内存 Profiling（R1-RC3）

**当前状态：** 无任何内存数据
**目标：** 每个方法在每个数据集上的峰值 RSS (MB)

### 方法：用 `/usr/bin/time -v` 包装
```bash
# 示例：测量 Python 基线的峰值内存
/usr/bin/time -v uv run python baselines/run_classic4_baselines.py \
  --methods SpectralCC --seeds 0 2>&1 | grep "Maximum resident"
```

### 方法：Rust 内部测量
```rust
// 在 Rust 代码中加入：
use std::fs;
fn peak_rss_mb() -> f64 {
    let status = fs::read_to_string("/proc/self/status").unwrap();
    for line in status.lines() {
        if line.starts_with("VmHWM:") {
            let kb: f64 = line.split_whitespace().nth(1).unwrap().parse().unwrap();
            return kb / 1024.0;
        }
    }
    0.0
}
```

---

## 优先级 6：Scalability 对比图（R1-RC2）

**当前状态：** 占位图
**目标：** wall-clock time vs 线程数/节点数曲线

### 使用已有 Rust benchmark
```bash
cd /home/jie/fast_cocluster
# 需要修改 benchmark_dimerge_advantage.rs 使其输出 CSV
OPENBLAS_NUM_THREADS=1 cargo run --release --example benchmark_dimerge_advantage
```

### 需要的数据点
- X 轴：线程数 (1, 2, 4, 8, 16, 32)
- Y 轴：wall-clock time (s)
- 两条线：DiMergeCo-SCC vs standalone SCC (baseline)
- 在 Classic4 和 RCV1 数据集上

### 生成图
```bash
uv run python -c "
import matplotlib.pyplot as plt
# ... 用实验数据画图
plt.savefig('/home/jie/big-cocluster-paper/src/images/scalability_comparison.pdf')
"
```

---

## 优先级 7：消融实验 - Merging 策略（R2-RC1）

**当前状态：** Rust 代码支持 4 种策略 (Union, Intersection, Weighted, Adaptive)
**论文需要：** 5 种策略对比 (Hierarchical, Random, Centralized, Greedy, Union)

### 需要确认
1. 论文中策略名与代码实现的对应关系
2. 是否需要新增 "Random"、"Centralized"、"Greedy" 策略实现
3. 在哪些数据集上跑（Classic4 + BCW + Amazon）

### Rust 运行方式（需修改代码）
```bash
cd /home/jie/fast_cocluster
# 需要新建 examples/ablation_merge_strategy.rs
# 对每种策略跑 10 seeds，输出 NMI/ARI/time
cargo run --release --example ablation_merge_strategy
```

---

## 数据更新后的论文修改清单

完成实验后，需要更新以下论文文件：

### `src/root.tex`
- [ ] Table I (`tab:evaluation-metrics`): 所有数据集、所有方法的 NMI/ARI
- [ ] Table: Running Time (`tab:running-time`)
- [ ] Table: Memory Usage (`tab:memory-usage`)
- [ ] Figure: Scalability Comparison (`fig:scalability-comparison`)
- [ ] Table: Ablation - Merging Quality (`tab:merging-quality`)
- [ ] Table: Ablation - Merging Cost (`tab:merging-cost`)
- [ ] Figure: Merging Convergence (`fig:merging-convergence`)

### `src/response.tex`
- [ ] R1-RC1: 更新统计显著性描述（所有数据集完成后）
- [ ] R1-RC2: 更新 scalability 描述
- [ ] R1-RC3: 更新内存数据
- [ ] R2-RC1: 更新消融实验描述
- [ ] R2-RC3: 更新 SpectralCC 在 BCW 上的数字

### `src/supplement.tex`
- [ ] Merging quality bound 证明中的实验验证数据
