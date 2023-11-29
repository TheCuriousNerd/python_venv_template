#!/bin/bash

# Source the zprofile to get pyenv and pyenv-virtualenv initialized
# source ~/.zprofile

# Full path to pyenv, replace this with the result of `which pyenv`
PYENV_CMD="/opt/homebrew/bin/pyenv"


# Virtual environment name
venv_name="testing_env_310"



echo "Activating $venv_name..."
# Activate virtual environment
if source activate $venv_name; then
  # Full path to pip, replace this with the result of `which pip` within the activated environment
  PIP_CMD="$HOME/.pyenv/versions/$venv_name/bin/pip"
  echo "Activated $venv_name"

  # Install requirements if requirements.txt exists
  python main.py;

  echo "Deactivating $venv_name..."
  # Deactivate the virtual environment
  if source deactivate; then
   echo "Deactivated $venv_name"
  else
   echo "FAILED to deactivate $venv_name"
  fi
else
  echo "Failed to activate $venv_name"
fi
