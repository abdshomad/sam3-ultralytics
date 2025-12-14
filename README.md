# sam3-ultralytics

Integration project combining [SAM3](https://github.com/facebookresearch/sam3) (Segment Anything Model 3) and [Ultralytics YOLO](https://github.com/ultralytics/ultralytics) for advanced computer vision tasks.

## Overview

This project integrates two state-of-the-art computer vision libraries:
- **SAM3**: Meta AI Research's Segment Anything Model 3 for image and video segmentation
- **Ultralytics YOLO**: YOLO implementation for object detection, tracking, segmentation, pose estimation, and classification

Both libraries are included as git submodules and installed as editable dependencies, allowing for seamless development and integration.

## Prerequisites

- Python 3.8 or higher
- Git
- [uv](https://github.com/astral-sh/uv) package manager

### Installing uv

If you don't have `uv` installed, you can install it using:

```bash
curl -LsSf https://astral.sh/uv/install.sh | sh
```

Or via pip:
```bash
pip install uv
```

## Installation

### Clone the Repository

Clone this repository with submodules:

```bash
git clone --recurse-submodules https://github.com/yourusername/sam3-ultralytics.git
cd sam3-ultralytics
```

If you've already cloned without submodules:

```bash
git submodule update --init --recursive
```

### Run Installation Script

Make the installation script executable and run it:

```bash
chmod +x install.sh
./install.sh
```

The installation script will:
1. Initialize and update git submodules
2. Check for `uv` installation
3. Install ultralytics and sam3 from submodules in editable mode
4. Sync project dependencies using `uv sync`
5. Create a virtual environment at `.venv/`

## Usage

### Running Scripts

Use the `run.sh` script to execute code with the proper environment:

#### Interactive Shell (Default)

Launch an interactive shell with the virtual environment activated:

```bash
./run.sh
# or
./run.sh shell
```

#### Execute a Command

Run a specific command in the activated environment:

```bash
./run.sh exec python your_script.py
./run.sh exec python -m pytest
```

#### Run Demos

Run example scripts from the submodules:

```bash
# Run an ultralytics example
./run.sh demo ultralytics examples/tutorial.ipynb

# Run a sam3 example
./run.sh demo sam3 examples/sam3_image_predictor_example.ipynb
```

### Manual Environment Activation

You can also manually activate the virtual environment:

```bash
source .venv/bin/activate
python your_script.py
deactivate
```

## Project Structure

```
sam3-ultralytics/
├── ultralytics/          # Ultralytics YOLO submodule
├── sam3/                 # SAM3 submodule
├── .venv/                # Virtual environment (created by uv sync)
├── pyproject.toml        # Project dependencies and metadata
├── install.sh            # Installation script
├── run.sh                # Execution script
├── AGENTS.md             # AI agent instructions
└── README.md             # This file
```

## Updating Submodules

To update the submodules to their latest versions:

```bash
git submodule update --remote
./install.sh  # Reinstall with updated submodules
```

## Dependencies

- **ultralytics**: Installed from `./ultralytics/` submodule (editable)
- **sam3**: Installed from `./sam3/` submodule (editable)

Additional dependencies are managed through `pyproject.toml` and installed via `uv sync`.

## Development

### Adding Dependencies

Add new dependencies to `pyproject.toml`:

```toml
[project]
dependencies = [
    "your-package>=1.0.0",
]
```

Then run:
```bash
uv sync
```

### Development Dependencies

Development dependencies are listed in `[project.optional-dependencies.dev]`. Install them with:

```bash
uv sync --extra dev
```

## References

- [Ultralytics YOLO Documentation](https://docs.ultralytics.com)
- [SAM3 Repository](https://github.com/facebookresearch/sam3)
- [uv Documentation](https://github.com/astral-sh/uv)

## License

This integration project follows the licenses of its submodules. Please refer to:
- [Ultralytics License](ultralytics/LICENSE)
- [SAM3 License](sam3/LICENSE)

## Contributing

Contributions are welcome! Please ensure that:
1. Submodules are properly initialized before making changes
2. All code runs within the virtual environment
3. Dependencies are properly declared in `pyproject.toml`