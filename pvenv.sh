#!/bin/bash

print_help() {
    echo "Usage: $0 [option] [env_name]"
    echo "Options:"
    echo "  create      Create a new virtual environment"
    echo "  activate    Activate the virtual environment"
    echo "  install     Install dependencies from requirements.txt or setup.py"
    echo "  export      Export installed dependencies to requirements.txt within a virtual environment (default name: .venv)"
    echo "  remove      Deactivate and remove the virtual environment"
}

check_virtualenv() {
    if ! command -v virtualenv &> /dev/null; then
        echo "virtualenv is not installed. Installing..."
        python3 -m pip install --user virtualenv
        echo "virtualenv installation complete."
    fi
}

create_venv() {
    # Check if virtualenv is installed, if not, install it
    check_virtualenv
    
    local env_name=${1:-".venv"}

    if [ -d "$env_name" ]; then
        echo "Virtual environment '$env_name' already exists. Aborting."
        return 1
    fi

    python3 -m venv "$env_name"
    source "./$env_name/bin/activate"
    pip install -U pip
}

activate_venv() {
    local env_name=${1:-".venv"}

    if [ ! -d "$env_name" ]; then
        echo "Virtual environment '$env_name' not found. Use '$0 create [env_name]' to create one."
        return 1
    fi

    source "./$env_name/bin/activate"
}

install_deps() {
    local env_name=${1:-".venv"}

    if [ ! -d "$env_name" ]; then
        echo "Virtual environment '$env_name' not found. Use '$0 create [env_name]' to create one."
        return 1
    fi

    source "./$env_name/bin/activate"

    if [ -f "requirements.txt" ]; then
        pip install -r ./requirements.txt
    fi

    if [ -f "setup.py" ]; then
        pip install -e .
    fi
}

export_deps() {
    local env_name=${1:-".venv"}

    if [ ! -d "$env_name" ]; then
        echo "Virtual environment '$env_name' not found. Use '$0 create [env_name]' to create one."
        return 1
    fi

    source "./$env_name/bin/activate"
    pip freeze > requirements.txt
    echo "Dependencies exported to requirements.txt"
}

remove_venv() {
    local env_name=${1:-".venv"}

    if [ ! -d "$env_name" ]; then
        echo "Virtual environment '$env_name' not found."
        return 1
    fi

    deactivate
    rm -rf "$env_name"
}

if [ "$1" = "--help" ] || [ "$1" = "-h" ]; then
    print_help
    return 0
fi

case "$1" in
    "create")
        create_venv "$2"
        ;;
    "activate")
        activate_venv "$2"
        ;;
    "install")
        install_deps "$2"
        ;;
    "export")
        export_deps "$2"
        ;;
    "remove")
        remove_venv "$2"
        ;;
    *)
        echo "Unknown option: $1"
        print_help
        exit 1
        ;;
esac