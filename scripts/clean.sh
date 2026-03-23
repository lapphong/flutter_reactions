#!/bin/bash
set -e

flutter clean
rm -rf build/
rm -rf coverage/

cd example/
flutter clean
rm -f build/

cd ..
flutter pub get

echo "Pub get completed!"
