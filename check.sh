#!/bin/bash

AVAILABLE_SCRIPTS=$(npm run)

has_script() {
  local script_name="$1"
  local SCRIPT_COUNT
  SCRIPT_COUNT=$(echo "$AVAILABLE_SCRIPTS" | grep -c "^  $script_name")
  [[ $SCRIPT_COUNT -gt 0 ]]
}

echo "Install dependencies"
pnpm install --frozen-lockfile

if has_script "build"; then
  echo "Running build"
  pnpm run build
else
  echo "No build script"
fi

if has_script "test"; then
  echo "Running tests"
  pnpm run test
else
  echo "No test script"
fi

if has_script "lint"; then
  echo "Checking lint"
  pnpm run lint
else
  echo "No lint script"
fi

if has_script "docs"; then
  echo "Checking docs"
  git reset --hard > /dev/null 2>&1
  pnpm run docs
  git diff --quiet || {
    echo 'Working tree is dirty. Did you forget to update the docs?'
    exit 1
  }
else
  echo "No docs script"
fi

echo "Check Finished"
