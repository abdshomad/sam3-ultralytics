#!/bin/bash

# Get the absolute path of the project root
PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$PROJECT_ROOT"

# Check if virtual environment exists
if [ ! -d ".venv" ]; then
    echo "Error: Virtual environment not found. Please run ./install.sh first."
    exit 1
fi

# Function to show usage
show_usage() {
    echo "Usage: $0 [MODE] [OPTIONS]"
    echo ""
    echo "Modes:"
    echo "  demo <submodule> <script>    Run a demo/example script from ultralytics or sam3"
    echo "  shell                         Launch an interactive shell (default)"
    echo "  exec <command>                Execute a command in the environment"
    echo ""
    echo "Examples:"
    echo "  $0                                    # Launch interactive shell"
    echo "  $0 shell                              # Launch interactive shell"
    echo "  $0 exec python script.py              # Run a Python script"
    echo "  $0 demo sam3 examples/sam3_image_predictor_example.ipynb"
    echo ""
}

# Activate virtual environment
source .venv/bin/activate

# Handle different modes
if [ "$#" -eq 0 ] || [ "$1" == "shell" ]; then
    # Interactive shell mode (default)
    echo "Starting interactive shell with activated virtual environment..."
    echo "Type 'deactivate' to exit the virtual environment."
    echo ""
    exec "$SHELL"
elif [ "$1" == "demo" ]; then
    # Demo mode
    if [ "$#" -lt 3 ]; then
        echo "Error: demo mode requires submodule and script arguments"
        echo ""
        show_usage
        exit 1
    fi
    
    SUBMODULE="$2"
    SCRIPT="$3"
    
    if [ ! -d "$SUBMODULE" ]; then
        echo "Error: Submodule '$SUBMODULE' not found"
        exit 1
    fi
    
    if [ ! -f "$SUBMODULE/$SCRIPT" ]; then
        echo "Error: Script '$SUBMODULE/$SCRIPT' not found"
        exit 1
    fi
    
    echo "Running demo: $SUBMODULE/$SCRIPT"
    cd "$SUBMODULE"
    if [[ "$SCRIPT" == *.ipynb ]]; then
        # For Jupyter notebooks, use jupyter
        python -m jupyter nbconvert --to notebook --execute "$SCRIPT" || jupyter notebook "$SCRIPT"
    else
        python "$SCRIPT"
    fi
    cd "$PROJECT_ROOT"
elif [ "$1" == "exec" ]; then
    # Execute command mode
    if [ "$#" -lt 2 ]; then
        echo "Error: exec mode requires a command"
        echo ""
        show_usage
        exit 1
    fi
    shift  # Remove "exec" argument
    exec "$@"
elif [ "$1" == "--help" ] || [ "$1" == "-h" ]; then
    show_usage
    exit 0
else
    echo "Error: Unknown mode '$1'"
    echo ""
    show_usage
    exit 1
fi

