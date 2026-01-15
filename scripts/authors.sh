#!/bin/bash
set -e

flutter pub get
flutter pub publish --dry-run

echo "Deploy Done !!!"
