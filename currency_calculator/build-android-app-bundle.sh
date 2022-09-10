#!/bin/zsh
set -x
set -e
set -o pipefail

# This script is used to build the files for android.
# ./build-android-app-bundle.sh <flavor> <git-tag-name> <app-version>
# flavor: stub, production
# git tag
# app version
# 1. 引数からflavorを取得
# 2. タグ名からgit tagを取得
#　3. pubspec.yamlからapp versionを取得

# flavor: stub, production
FLAVOR=$1
# git tag
GIT_TAG_NAME=$2
# app version
APP_VERSION=$3

if [[ $# != 3 ]]; then
    echo "[Error] Usage: ./build-files.sh [stub|production] [git tag name] [app version]"
    exit 1
fi

if [[ $# != 3 ]]; then
    echo "[Error] Usage: ./build-android-app-bundle.sh [stub|production] [git tag name] [app version]"
    exit 1
fi

ANDROID_APP_BUNDLE_NAME="app-${FLAVOR}-${GIT_TAG_NAME}.aab"

AAB_OUTPUT_PATH=~/Release/${GIT_TAG_NAME}/${ANDROID_APP_BUNDLE_NAME}

if test -e "${AAB_OUTPUT_PATH}" ; then
    mkdir -p "${AAB_OUTPUT_PATH}"
fi

# pubspec.yamlからapp versionを取得
# shellcheck disable=SC2207
version=($(grep "version:" pubspec.yaml | awk '{print $2}'))
TARGET_APP_VERSION="${version[0]}"

git checkout "${GIT_TAG_NAME}"
log_info "Generate AAB Start"
log_info "flutter clean"
log_info flutter clean
log_info "android clean"
cd android && ./gradlew clean
cd ..

flutter build appbundle --flavor "${FLAVOR}" --target-platform android-arm,android-arm64 --build-number "${APP_VERSION}" --build-name "${TARGET_APP_VERSION}"

cp -p build/app/outputs/bundle/"${FLAVOR}"/app-"${FLAVOR}".aab "${AAB_OUTPUT_PATH}"

log_info "Build Android AAB successfully"