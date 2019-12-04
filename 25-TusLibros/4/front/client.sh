#!/bin/bash

parent_path=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )
cd "$parent_path"

# auto compile on file changed
echo "Start auto-compile" &
python3 scripts/autoreload.py python3 scripts/compiler.py &
echo "Start browser auto-refresh" &
# browser refresh on file changed
python3 scripts/refreshbrowser.py