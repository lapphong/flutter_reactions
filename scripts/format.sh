#!/bin/bash
set -e

dart format --set-exit-if-changed .

# delete unused imports
dart fix --apply --code=unused_import
echo "Remove unused imports completed!"
