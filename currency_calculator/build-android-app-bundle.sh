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
# zsh permission deniedが発生する場合、chmod u+x build-android-app-bundle.sh

function log_info() {
    echo "$(date +"%Y-%m-%d %H:%M:%S") - INFO - $*"
}

# flavor: stub, production
FLAVOR=$1
# git tag
GIT_TAG_NAME=$2
# app version
APP_VERSION=$3

if [[ $# != 3 ]]; then
    echo "[Error] Usage: ./build-android-app-bundle.sh [stub|production] [git tag name] [app version]"
    exit 1
fi

ANDROID_APP_BUNDLE_NAME="app-${FLAVOR}-${GIT_TAG_NAME}.aab"

cur_dir=$(pwd)
AAB_OUTPUT_DIR=$cur_dir/release/${GIT_TAG_NAME}/
AAB_OUTPUT_PATH=$AAB_OUTPUT_DIR/${ANDROID_APP_BUNDLE_NAME}

if test ! -e "${AAB_OUTPUT_DIR}" ; then
    mkdir -p "${AAB_OUTPUT_DIR}"
fi

# pubspec.yamlからapp versionを取得

version=$(grep -E '^version:' pubspec.yaml | awk -F+ '{print $2}')

log_info "TARGET_APP_VERSION: ${version}"

git checkout -f "${GIT_TAG_NAME}"
log_info "Generate AAB Start"
log_info "flutter clean"
log_info flutter clean
log_info "android clean"
cd android && ./gradlew clean
cd ..

flutter build appbundle --flavor "${FLAVOR}" --target-platform android-arm,android-arm64 --build-number "${version}" --build-name "${APP_VERSION}"

cp -p build/app/outputs/bundle/"${FLAVOR}"Release/app-"${FLAVOR}"-release.aab "${AAB_OUTPUT_PATH}"

log_info "Build Android AAB successfully"