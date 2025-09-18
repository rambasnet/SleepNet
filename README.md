## SleepNet — Exploratory Data Analysis

This repository contains notebooks and data for initial experiments with the SleepNet dataset.

### Files

- `RawDataset.xlsx` — original dataset (place in repository root or update path in notebooks).
- `XGBoost.ipynb`
  — exploratory analysis notebook that inspects the dataset and generates basic visualizations.
  - modeling experiments using XGBoost.

### Quick start

- run env-creation script to create and activate a virtual environment and install dependencies

```bash
bash env-creation.sh
```

### Create and activate a virtual environment and install dependencies

- if bash is not available, follow one of these steps:

1. Create a Python virtual environment (recommended):

```bash
python -m venv .venv
source .venv/bin/activate
```

2. Install dependencies (pip):

```bash
python -m pip install -r requirements.txt
```

3. Alternatively, create and activate a Conda environment (recommended if you use Conda):

```bash
conda create -n sleepnet python=3.10 -y
conda activate sleepnet
pip install -r requirements.txt
```

4. Open `RawDataset.ipynb` in VS Code or Jupyter and run cells. If `RawDataset.xlsx` is not in the same folder, update the `path` variable in the load cell.
