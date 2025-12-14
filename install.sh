#!/bin/bash
set -e

# Get the absolute path of the project root
PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$PROJECT_ROOT"

echo "Initializing and updating git submodules..."
git submodule update --init --recursive

echo "Checking for uv..."
if ! command -v uv &> /dev/null; then
    echo "Error: uv is not installed. Please install uv first:"
    echo "  curl -LsSf https://astral.sh/uv/install.sh | sh"
    exit 1
fi

echo "Creating virtual environment..."
# Create virtual environment first if it doesn't exist
# Use Python 3.12 to avoid compatibility issues with numpy 1.26.0
if [ ! -d ".venv" ]; then
    # Try to find Python 3.12 or earlier
    PYTHON_CMD="python3.12"
    if ! command -v "$PYTHON_CMD" &> /dev/null; then
        PYTHON_CMD="python3.11"
        if ! command -v "$PYTHON_CMD" &> /dev/null; then
            PYTHON_CMD="python3.10"
            if ! command -v "$PYTHON_CMD" &> /dev/null; then
                PYTHON_CMD="python3"
                echo "Warning: Using default python3. Some dependencies may have compatibility issues."
            fi
        fi
    fi
    echo "Using $PYTHON_CMD for virtual environment"
    uv venv --python "$PYTHON_CMD"
fi

echo "Installing dependencies with uv..."
# Activate venv and install local editable packages
source .venv/bin/activate

echo "Installing ultralytics from submodule..."
uv pip install -e ./ultralytics

echo "Installing sam3 from submodule..."
uv pip install -e ./sam3

# Sync project dependencies (installs optional deps)
uv sync

deactivate

echo ""
echo "Installation complete!"
echo "The virtual environment is located at: .venv/"
echo "To activate manually, run: source .venv/bin/activate"
echo "Or use ./run.sh to run scripts with the environment activated"

