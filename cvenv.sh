#!/bin/bash

print_help() {
    echo "Usage: $0 [option] [env_name]"
    echo "Options:"
    echo "  create      Create a new conda environment"
    echo "  activate    Activate the conda environment"
    echo "  install     Install dependencies from requirements.txt or setup.py or environment.yml"
    echo "  export      Export installed dependencies to requirements.txt within a conda environment (default name: .venv)"
    echo "  remove      Deactivate and remove the conda environment"
}

check_conda() {
    if ! command -v conda &> /dev/null; then
        echo "conda is not installed. Please install conda before proceeding."
        exit 1
    fi
}

create_env() {
    check_conda

    local env_name=${1:-".venv"}

    if conda info --envs | grep -q "/$env_name$"; then
        echo "Conda environment '$env_name' already exists. Aborting."
        return 1
    fi

    conda create -y -n "$env_name" python
    conda activate "$env_name"
    pip install -U pip
}

activate_env() {
    local env_name=${1:-".venv"}

    if ! conda info --envs | grep -q "/$env_name$"; then
        echo "Conda environment '$env_name' not found. Use '$0 create [env_name]' to create one."
        return 1
    fi

    conda activate "$env_name"
}

install_deps() {
    local env_name=${1:-".venv"}

    if ! conda info --envs | grep -q "/$env_name$"; then
        echo "Conda environment '$env_name' not found. Use '$0 create [env_name]' to create one."
        return 1
    fi

    conda activate "$env_name"

    if [ -f "requirements.txt" ]; then
        pip install -r ./requirements.txt
    fi

    if [ -f "setup.py" ]; then
        pip install -e .
    fi

    if [ -f "environment.yml" ]; then
        conda env update --file environment.yml --prune
    fi
}

export_deps() {
    local env_name=${1:-".venv"}

    if ! conda info --envs | grep -q "/$env_name$"; then
        echo "Conda environment '$env_name' not found. Use '$0 create [env_name]' to create one."
        return 1
    fi

    conda activate "$env_name"
    pip freeze > requirements.txt
    echo "Dependencies exported to requirements.txt"
    conda env export --file environment.yml
    echo "Dependencies exported to environment.yml"
}

remove_env() {
    local env_name=${1:-".venv"}

    if ! conda info --envs | grep -q "/$env_name$"; then
        echo "Conda environment '$env_name' not found."
        return 1
    fi

    conda deactivate
    conda env remove -n "$env_name" --yes
}

if [ "$1" = "--help" ] || [ "$1" = "-h" ]; then
    print_help
    exit 0
fi

case "$1" in
    "create")
        create_env "$2"
        ;;
    "activate")
        activate_env "$2"
        ;;
    "install")
        install_deps "$2"
        ;;
    "export")
        export_deps "$2"
        ;;
    "remove")
        remove_env "$2"
        ;;
    *)
        echo "Unknown option: $1"
        print_help
        exit 1
        ;;
esac
