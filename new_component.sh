#!/bin/bash

COMPONENT="${1}"
TOPLEVEL=$(git rev-parse --show-toplevel)

function create_molecule {
  local FILENAME="${TOPLEVEL}/molecule/${COMPONENT}/converge.yml"
  echo "Creating ${COMPONENT} molecule test suit: ${FILENAME}"
  cp -rf "${TOPLEVEL}/molecule/default" "${TOPLEVEL}/molecule/${COMPONENT}"
  if [[ "$(uname -o)" == "Darwin" ]]; then
    sed -i '' "s/COMPONENT_NAME/${COMPONENT}/g" "${FILENAME}"
  else
    sed -i "s/COMPONENT_NAME/${COMPONENT}/g" "${FILENAME}"
  fi
}

function create_action {
  local FILENAME="${TOPLEVEL}/.github/workflows/${COMPONENT}.yml"
  echo "Creating ${COMPONENT} github action: ${FILENAME}"
  cp -f "${TOPLEVEL}/templates/_new/actions.yml" "${FILENAME}"
  if [[ "$(uname -o)" == "Darwin" ]]; then
    sed -i '' "s/COMPONENT_NAME/${COMPONENT}/g" "${FILENAME}"
  else
    sed -i "s/COMPONENT_NAME/${COMPONENT}/g" "${FILENAME}"
  fi
}

function create_defaults {
  local FILENAME="${TOPLEVEL}/defaults/main/${COMPONENT}.yml"
  echo "Creating ${COMPONENT} default values: ${FILENAME}"
  cp -f "${TOPLEVEL}/templates/_new/defaults.yml" "${FILENAME}"
  if [[ "$(uname -o)" == "Darwin" ]]; then
    sed -i '' "s/COMPONENT_NAME/${COMPONENT}/g" "${FILENAME}"
  else
    sed -i "s/COMPONENT_NAME/${COMPONENT}/g" "${FILENAME}"
  fi
}

create_molecule
create_action
create_defaults
