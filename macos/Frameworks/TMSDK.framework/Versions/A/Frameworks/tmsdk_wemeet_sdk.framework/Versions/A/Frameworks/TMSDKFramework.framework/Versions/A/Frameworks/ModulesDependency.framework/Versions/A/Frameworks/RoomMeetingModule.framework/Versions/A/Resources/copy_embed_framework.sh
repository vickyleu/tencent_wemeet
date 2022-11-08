#!/bin/sh
set -e

source ${COPY_EMBED_FRAMEWORK_PATH}/copy_embed_framework.sh

echo $(pwd)

app_common_path=$(cd ${APP_COMMON_OUTPUT_PATH}; pwd)

install_framework "${app_common_path}/${MODULE_NAME}.framework" "${TARGET_BUILD_DIR}/${FRAMEWORKS_FOLDER_PATH}"

install_framework "${app_common_path}/${MODULE_NAME}.framework/Resources/manifest.json" "${TARGET_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}"

install_framework "${app_common_path}/${MODULE_NAME}.framework/Resources/module.res" "${TARGET_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}"
