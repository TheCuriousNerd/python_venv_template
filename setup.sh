#!/bin/bash

# Source the zprofile to get pyenv and pyenv-virtualenv initialized
# source ~/.zprofile

# Full path to pyenv, replace this with the result of `which pyenv`
PYENV_CMD="/opt/homebrew/bin/pyenv"

# Install Python version if it's not installed
$PYENV_CMD install 3.10 -s

# Virtual environment name
venv_name="testing_env_310"

# Check if virtual environment already exists, create if not
if $PYENV_CMD versions --bare | grep -q $venv_name; then
  echo "Virtual environment $venv_name already exists..."
else
  $PYENV_CMD virtualenv 3.10 $venv_name
  echo "Virtual environment $venv_name created."
fi

# Activate virtual environment
if source activate $venv_name; then
  # Full path to pip, replace this with the result of `which pip` within the activated environment
  PIP_CMD="$HOME/.pyenv/versions/$venv_name/bin/pip"
  echo "Activated $venv_name"

  # Install requirements if requirements.txt exists
  if [ -f "requirements.txt" ]; then
    $PIP_CMD install -r requirements.txt
  else
    echo "No requirements.txt found."
  fi

  echo "Deactivating $venv_name..."
  # Deactivate the virtual environment
  if source deactivate; then
   echo "Deactivated $venv_name"
  else
   echo "FAILED to deactivate $venv_name"
  fi
else
  echo "Failed to activate $venv_name."
fi
