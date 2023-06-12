#!/bin/bash

COMPONENT="${1}"

cd $(git rev-parse --show-toplevel)/molecule

cp -rf default "${COMPONENT}"
sed -i "s/dummy/${COMPONENT}/g" "${COMPONENT}/converge.yml"

cd $(git rev-parse --show-toplevel)/.github/workflows
cp -f ../dummy.yml "${COMPONENT}.yml"
sed -i "s/dummy/${COMPONENT}/g" "${COMPONENT}.yml"
