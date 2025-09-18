#!/usr/bin/env bash
# env-creation.sh — create or update a development environment for this project
# Usage: ./env-creation.sh [--update]
# If Conda is available this will create/update the `sleepnet` environment from environment.yml.
# Otherwise it will create a Python venv at .venv and install packages from requirements.txt.

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

UPDATE=false
if [ "${1:-}" = "--update" ]; then
  UPDATE=true
fi

# Prefer conda if available
if command -v conda >/dev/null 2>&1; then
  echo "Conda detected. Using environment.yml to create/update environment 'sleepnet'."
  if [ "$UPDATE" = true ]; then
    conda env update -f environment.yml --prune
  else
    conda env create -f environment.yml || { echo "Environment already exists — updating instead."; conda env update -f environment.yml --prune; }
  fi
  echo "To activate: conda activate sleepnet"
  exit 0
fi

# Fallback to python venv
if command -v python3 >/dev/null 2>&1; then
  PY=python3
elif command -v python >/dev/null 2>&1; then
  PY=python
else
  echo "No python or conda found on PATH. Install one and retry." >&2
  exit 2
fi

if [ "$UPDATE" = true ]; then
  echo "Updating virtual environment .venv"
  $PY -m pip install --upgrade pip
  . .venv/bin/activate
  pip install -r requirements.txt
  echo "Virtualenv updated; activate with: source .venv/bin/activate"
  exit 0
fi

# create venv
if [ -d .venv ]; then
  echo ".venv already exists — activating and installing dependencies"
  . .venv/bin/activate
  pip install -r requirements.txt
  echo "Activated .venv; activate with: source .venv/bin/activate"
  exit 0
fi

echo "Creating virtual environment at .venv"
$PY -m venv .venv
. .venv/bin/activate
pip install --upgrade pip
pip install -r requirements.txt

echo "Virtual environment created. Activate with: source .venv/bin/activate"

exit 0
