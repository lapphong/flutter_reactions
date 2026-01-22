#!/bin/sh
set -e

echo "Checking release tag and version..."

# GITHUB_REF = refs/tags/vX.Y.Z
TAG_NAME=$(echo "$GITHUB_REF" | sed 's|refs/tags/||')

echo "Tag: $TAG_NAME"

# 1. Check tag format vX.Y.Z (POSIX)
echo "$TAG_NAME" | grep -Eq '^v[0-9]+\.[0-9]+\.[0-9]+$'
if [ $? -ne 0 ]; then
  echo "Invalid tag format (expected vX.Y.Z)"
  exit 1
fi

# 2. Fetch main branch
git fetch origin main --depth=1

# 3. Get commit of tag
TAG_COMMIT=$(git rev-list -n 1 "$TAG_NAME")

# 4. Check commit is contained in main
git branch -r --contains "$TAG_COMMIT" | grep -q 'origin/main'
if [ $? -ne 0 ]; then
  echo "Tag commit is NOT on main branch"
  exit 1
fi

echo "Tag commit is on main branch"

# 5. Check pubspec.yaml version
PUB_VERSION=$(grep '^version:' pubspec.yaml | awk '{print $2}')
EXPECTED_VERSION=$(echo "$TAG_NAME" | sed 's/^v//')

echo "pubspec.yaml version: $PUB_VERSION"
echo "expected version: $EXPECTED_VERSION"

if [ "$PUB_VERSION" != "$EXPECTED_VERSION" ]; then
  echo "Version mismatch between tag and pubspec.yaml"
  exit 1
fi

echo "Release tag validation passed"
