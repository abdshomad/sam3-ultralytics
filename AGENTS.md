# Project Instructions for AI Agents

This document provides context and instructions for AI coding agents working with the sam3-ultralytics integration project.

## Project Structure

This project integrates two major computer vision libraries as git submodules:

- **ultralytics**: YOLO (You Only Look Once) implementation for object detection, tracking, segmentation, and classification
  - Location: `./ultralytics/`
  - Repository: https://github.com/ultralytics/ultralytics.git
  
- **sam3**: Segment Anything Model 3 implementation from Meta AI Research
  - Location: `./sam3/`
  - Repository: https://github.com/facebookresearch/sam3

Both libraries are installed as **editable dependencies** from their respective submodule directories.

## Dependency Management

This project uses **`uv`** (https://github.com/astral-sh/uv) as the package manager:

- Dependencies are defined in `pyproject.toml`
- Local editable dependencies are installed from the submodule directories
- The virtual environment is managed by `uv` and located at `.venv/`
- Installation workflow: Run `./install.sh` which uses `uv sync` and `uv pip install -e` for local packages

## Installation Workflow

1. **Initialize submodules**: `git submodule update --init --recursive`
2. **Run installation script**: `./install.sh`
   - This script initializes submodules, checks for `uv`, and installs all dependencies
   - Local packages (ultralytics and sam3) are installed in editable mode using `uv pip install -e`
   - Project dependencies are synced using `uv sync`

## Execution Patterns

Use `./run.sh` for running code in the activated environment:

- **Interactive shell**: `./run.sh` or `./run.sh shell`
- **Execute command**: `./run.sh exec <command>`
- **Run demo**: `./run.sh demo <submodule> <script_path>`

Examples:
```bash
./run.sh exec python my_script.py
./run.sh demo sam3 examples/sam3_image_predictor_example.ipynb
```

## Coding Guidelines

When working with this project:

1. **Submodule handling**: 
   - Do not commit changes directly to submodule directories unless intentionally updating them
   - To update submodules: `git submodule update --remote`
   
2. **Virtual environment**: 
   - Always work within the `.venv` virtual environment created by `uv sync`
   - Use `./run.sh` to ensure the correct environment is activated

3. **Dependencies**: 
   - Add new dependencies to `pyproject.toml` under `[project.dependencies]`
   - Run `uv sync` to update the environment after adding dependencies
   - For development tools, use `[project.optional-dependencies.dev]`

4. **Python version**: 
   - Requires Python >= 3.8 (as specified in `pyproject.toml`)

## Project Context

This integration project allows combining the capabilities of:
- **Ultralytics YOLO**: Fast object detection, tracking, and segmentation
- **SAM3**: Advanced segment anything model for image and video understanding

Both libraries are kept as editable dependencies to enable:
- Easy development and testing
- Access to latest features from source
- Seamless integration between both libraries

