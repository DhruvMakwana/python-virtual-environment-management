# Python Virtual Environment Management

## Streamlined Bash scripts for managing Python virtual environments, with support for both virtualenv and conda.

In the coding universe, things can sometimes get confusing when dealing with virtual spaces. But don't worry! There's a cool trick that can make your life a whole lot easier: a special bash script that takes care of all the confusing parts for you. Bash scripts provides:

1. Checking Virtual Environment Installation
2. Creating Virtual Environments
3. Activate Virtual Environments
4. Streamlined Dependency Installation
5. Export dependencies
6. Remove Virtual Environments

## How to run?

Using `pvenv.sh` is straightforward, but let's walk through each action step by step. Here's how you can utilize its features right from your terminal:

### Step 1: Make the Script Executable

Before you dive in, ensure that the script is executable. You can grant the necessary permissions using the command:

```bash
chmod +x pvenv.sh
```

### Step 2: Printing the Help Message

If you're ever unsure about what `pvenv.sh` can do for you, just ask it for help! To display a comprehensive explanation of the script's capabilities and available options, simply run:

```bash
./pvenv.sh --help
```

or 

```bash
./pvenv.sh -h
```

### Step 3: Creating a Virtual Environment

To craft a new virtual environment (default name: .venv), execute:

```bash
source ./pvenv.sh create
```

You can also assign a distinct name to your environment:

```bash
source ./pvenv.sh create myenv
```

### Step 4: Activating a Virtual Environment

For activating an existing virtual environment (default name: .venv), use:

```bash
source ./pvenv.sh activate
```

If your environment boasts a unique name:

```bash
source ./pvenv.sh activate myenv
```

### Step 5: Installing Dependencies

In an existing virtual environment (default name: .venv), installing dependencies is a breeze:

```bash
source ./pvenv.sh install
```

For environments with custom names:

```bash
source ./pvenv.sh install myenv
```

### Step 6: Exporting Dependencies

For exporting installed libraries to requirements.txt file, use:

```bash
source ./pvenv.sh export
```

For environments with custom names:

```bash
source ./pvenv.sh export myenv
```

### Step 7: Removing a Virtual Environment

When you're ready to remove an environment (default name: .venv), use:

```bash
source ./pvenv.sh remove
```

If the environment has a specific name:

```bash
source ./pvenv.sh remove myenv
```

Just as `pvenv.sh` simplifies Python virtual environment management using virtualenv, `cvenv.sh` streamlines the process using conda. This companion script offers similar functionalities for managing Conda environments.