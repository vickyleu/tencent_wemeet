#!/bin/sh
set -e

source ${COPY_EMBED_FRAMEWORK_PATH}/copy_embed_framework.sh

echo $(pwd)

app_common_path=$(cd ${APP_COMMON_OUTPUT_PATH}; pwd)

install_framework "${MODULE_FRAMEWORK_PATH}" "${TARGET_BUILD_DIR}/${FRAMEWORKS_FOLDER_PATH}"

install_framework "${MODULE_FRAMEWORK_PATH}/Resources/manifest.json" "${TARGET_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}"

install_framework "${MODULE_FRAMEWORK_PATH}/Resources/module.res" "${TARGET_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}"

#if [ -e  "${TARGET_BUILD_DIR}/${FRAMEWORKS_FOLDER_PATH}/copy_embed_framework.sh" ]; then
#rm -R "${TARGET_BUILD_DIR}/${FRAMEWORKS_FOLDER_PATH}/copy_embed_framework.sh"
#fi

if ! [ -z ${RUNTIME_APP_PATH+x} ]; then
  debug_app_path="${RUNTIME_APP_PATH}/TencentMeeting.app"
  app_module_path="${debug_app_path}/Contents/Frameworks/WeMeetFramework.framework/Versions/Current/Frameworks/ModulesDependency.framework/Versions/A/Frameworks"
  if [ -d ${app_module_path} ]; then
    echo "copy ScreenShare.framework to ${app_module_path}"
    install_framework "${TARGET_BUILD_DIR}/ScreenShareModule.framework" "${app_module_path}"
  fi
fi
