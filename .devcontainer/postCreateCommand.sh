#!/bin/bash

initial_dir=${PWD}

# dotfiles
git clone https://github.com/ktman-ktman/dotfiles.git ~/dotfiles
cd ~/dotfiles
sh ./install_vscode.sh
cd ${initial_dir}

# rye
if [[ ! -f "./.venv" ]] && [[ -f "./pyproject.toml" ]]
then
	rye sync
fi

# julia
if [ ! -f "./.julia" ] && [ -f "./Project.toml" ]
then
        julia --project=@. -e "using Pkg; Pkg.instantiate()"
fi