# Baseline Methods for DiMergeCo Paper

## Method Coverage

| Paper Method | Citation | Implementation | Status |
|---|---|---|---|
| SCC | Dhillon 2001 | `sklearn.cluster.SpectralCoclustering` (same algorithm) | pip install |
| SpectralCC | sklearn | `sklearn.cluster.SpectralCoclustering` | pip install |
| NMTF | Long 2005 | `NMTFcoclust` (NBVD) | submodule |
| ONMTF | Ding 2006 | `NMTFcoclust` (ONM3F) | submodule |
| FNMTF | Kim 2011 | `nonnegfac-python` (fast NMF, 2-factor) + argmax | submodule |
| PNMTF | Chen 2023 | **No code released** - use NMTFcoclust PNMTF (Wang 2017) as proxy | submodule |
| WC-NMTF | Salah 2018 | **No code released** | missing |
| DiMergeCo-SCC | Ours | `/home/jie/fast_cocluster` | separate repo |
| DiMergeCo-PNMTF | Ours | `/home/jie/fast_cocluster` | separate repo |

## Submodules

- `NMTFcoclust/` - NBVD, ONMTF, ONM3F, PNMTF (7 NMTF variants)
- `fast-nmtf/` - Fast NMTF with MU/ALS/PG/COD optimizers
- `nonnegfac-python/` - Kim & Park fast NMF (ANLS-BPP)

## Setup

```bash
# Clone with submodules
git submodule update --init --recursive

# Create conda environment
conda create -n baselines python=3.10
conda activate baselines
pip install numpy scipy scikit-learn matplotlib

# NMTFcoclust deps
pip install pandas coclust

# fast-nmtf deps (optional)
cd fast-nmtf && pip install -e . && cd ..
```

## Dataset

Classic4 (paper version): `/home/jie/fast_cocluster/data/classic4_paper.npy` (6460 x 4667)
Labels: `/home/jie/fast_cocluster/data/classic4_paper_labels.npy`

## Run All Baselines

```bash
python run_classic4_baselines.py
```

## Notes

- PNMTF (Chen 2023) is a **Parallel** (MPI-distributed) NMTF. No code released.
  NMTFcoclust's PNMTF is a **Penalized** NMTF (Wang 2017) - different algorithm.
  We use NMTFcoclust's PNMTF as a reasonable NMTF baseline.
- FNMTF (Kim 2011) is actually fast **NMF** (2-factor A~WH), not tri-factorization.
  For co-clustering, row labels = argmax(W), col labels = argmax(H^T).
- WC-NMTF (Salah 2018) has no public code. May need to re-implement or drop.
