#!/bin/sh
set -e

source ${COPY_EMBED_FRAMEWORK_PATH}/copy_embed_framework.sh

echo $(pwd)

app_common_path=$(cd ${MODULE_OUTPUT_PATH}; pwd)

install_framework "${app_common_path}/${MODULE_NAME}.framework" "${TARGET_BUILD_DIR}/${FRAMEWORKS_FOLDER_PATH}"

install_framework "${app_common_path}/${MODULE_NAME}.framework/Resources/manifest.json" "${TARGET_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}"

install_framework "${app_common_path}/${MODULE_NAME}.framework/Resources/module.res" "${TARGET_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}"

if ! [ -z ${RUNTIME_APP_PATH+x} ]; then
  debug_app_path="${RUNTIME_APP_PATH}/TencentMeeting.app"
  app_module_path="${debug_app_path}/Contents/Frameworks/WeMeetFramework.framework/Versions/Current/Frameworks/ModulesDependency.framework/Versions/A/Frameworks"
  if [ -d ${app_module_path} ]; then
    echo "copy WarmupMedia.framework to ${app_module_path}"
    install_framework "${TARGET_BUILD_DIR}/WarmupMediaModule.framework" "${app_module_path}"
  fi
fi
