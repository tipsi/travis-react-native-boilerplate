#!/bin/bash

set -e

npm i

proj_dir=example

library_name=$(node -p "require('./package.json').name")
library_version=$(node -p "require('./package.json').version")

isMacOS() {
  [ "$(uname)" == "Darwin" ]
}

###################
# BEFORE INSTALL  #
###################

# Skip iOS step if current os is not macOS
!isMacOS && echo "Current os is not macOS, setup for iOS will be skipped"

# Install react-native-cli if not exist
if ! type react-native > /dev/null; then
  npm install -g react-native-cli
fi

# Remove existing tarball
rm -rf *.tgz

# Create new tarball
npm pack

cd $proj_dir

###################
# INSTALL         #
###################

# Install dependencies
rm -rf node_modules && npm install

###################
# BEFORE BUILD    #
###################

# Run appium
(pkill -9 -f appium || true)
npm run appium > /dev/null 2>&1 &

###################
# BUILD           #
###################

# Run Android emulator
npm run run-emulator:android
trap 'adb shell reboot -p' 0

# Build Android app
npm run build:android

# Build iOS app
isMacOS && npm run build:ios | xcpretty

###################
# TESTS           #
###################

# Run Android e2e tests
npm run test:android

# Run iOS e2e tests
isMacOS && npm run test:ios
