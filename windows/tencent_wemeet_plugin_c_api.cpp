#include "include/tencent_wemeet/tencent_wemeet_plugin_c_api.h"

#include <flutter/plugin_registrar_windows.h>

#include "tencent_wemeet_plugin.h"

void TencentWemeetPluginCApiRegisterWithRegistrar(
    FlutterDesktopPluginRegistrarRef registrar) {
  tencent_wemeet::TencentWemeetPlugin::RegisterWithRegistrar(
      flutter::PluginRegistrarManager::GetInstance()
          ->GetRegistrar<flutter::PluginRegistrarWindows>(registrar));
}
