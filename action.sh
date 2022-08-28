#!/bin/bash

pnpm install --frozen-lockfile

SCRIPTS_TO_RUN=("build" "test" "lint")

for script in "${SCRIPTS_TO_RUN[@]}"; do
  echo "Running $script"
  pnpm run --if-present "$script"
done
