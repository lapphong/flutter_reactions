#!/bin/bash

# v.[version]
# TAG_NAME=v1.0.3
VERSION=1.0.9
TAG_NAME="v"$VERSION

git tag $TAG_NAME
git push origin $TAG_NAME
