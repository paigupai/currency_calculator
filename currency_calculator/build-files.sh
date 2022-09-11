#!/bin/zsh
set -x
set -e
set -o pipefail

# This script is used to build the files for the project.
# ./build-files.sh <flavor> <git-tag-name> <app-version>
# flavor: stub, production
# git tag
# app version
# 1. 引数からflavorを取得
# 2. タグ名からgit tagを取得
#　3. pubspec.yamlからapp versionを取得

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
    echo "[Error] Usage: ./build-files.sh [stub|production] [git tag name] [app version]"
    exit 1
fi

log_info "資材作成開始"
git checkout -f "${GIT_TAG_NAME}"
log_info flutter pub get
./build-android-app-bundle.sh "${FLAVOR}" "${GIT_TAG_NAME}" "${APP_VERSION}"
# TODO: iOSの資材作成
#./build-iOS.sh "${FLAVOR}" "${GIT_TAG_NAME}" "${APP_VERSION}"

log_info " successfully build files for $FLAVOR flavor"
