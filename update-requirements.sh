#!/bin/sh

# This script can be used for updating the requirements for each of the environments.
# Execute command: `./update-requirements.sh <sub-directories>`
# Example: `./update-requirements.sh ubi8-py39 f34-py39`
# Prerequisite: Pipenv, micropipenv and different Python interpreter versions

set -o errexit
trap 'echo "Aborting due to errexit on line $LINENO. Exit code: $?" >&2' ERR
set -o errtrace
set -o pipefail


# check all the arguements.
for path in "$@"
do
  python_var="${path: -2: -1}.${path:(-1)}"
  if [ -d "$path" ]; then
    echo "$path sub directory exists."
    cd $path
    pipenv install -r requirements.in --python $python_var
    micropipenv requirements --no-dev > requirements.txt
    rm -rf Pipfile Pipfile.lock
    cd ..
  else
    echo "$path sub directory does not exist."
  fi
done
