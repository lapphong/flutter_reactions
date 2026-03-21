#!/bin/bash

VERSION=1.2.2
TAG_NAME="v"$VERSION

git tag $TAG_NAME
git push origin $TAG_NAME
