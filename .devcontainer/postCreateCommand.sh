#!/bin/bash

initial_dir=${PWD}

# dotfiles
git clone https://github.com/ktman-ktman/dotfiles.git ~/dotfiles
cd ~/dotfiles
sh ./install_vscode.sh
cd ${initial_dir}

# poetry
if [[ ! -f "./.venv" ]] && [[ -f "./poetry.lock" ]]
then
	poetry install
fi

# julia
if [[ ! -f "./.julia" ]] && [[ -f "./Project.toml" ]]
then
	julia --project=@. -e "using Pkg; Pkg.instantiate()"
fi