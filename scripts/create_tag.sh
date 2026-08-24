#!/bin/bash

VERSION=1.5.0
TAG_NAME="v"$VERSION

git tag $TAG_NAME
git push origin $TAG_NAME
