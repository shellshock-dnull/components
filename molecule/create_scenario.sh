#!/bin/bash
# TODO: make this more usable


COMPONENT="${1}"

cd $(git rev-parse --show-toplevel)/molecule

cp -rf default "${COMPONENT}"
if [[ "$(uname -o)" == "Darwin" ]]; then
  sed -i '' "s/dummy/${COMPONENT}/g" "${COMPONENT}/converge.yml"
else
  sed -i "s/dummy/${COMPONENT}/g" "${COMPONENT}/converge.yml"
fi

cd $(git rev-parse --show-toplevel)/.github/workflows
cp -f ../dummy.yml "${COMPONENT}.yml"
if [[ "$(uname -o)" == "Darwin" ]]; then
  sed -i '' "s/dummy/${COMPONENT}/g" "${COMPONENT}.yml"
else
  sed -i "s/dummy/${COMPONENT}/g" "${COMPONENT}.yml"
fi
