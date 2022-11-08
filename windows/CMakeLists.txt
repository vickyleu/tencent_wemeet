# The Flutter tooling requires that developers have a version of Visual Studio
# installed that includes CMake 3.14 or later. You should not increase this
# version, as doing so will cause the plugin to fail to compile for some
# customers of the plugin.
cmake_minimum_required(VERSION 3.14)

# Project-level configuration.
set(PROJECT_NAME "tencent_wemeet")
project(${PROJECT_NAME} LANGUAGES CXX)

# This value is used when generating builds using this plugin, so it must
# not be changed
set(PLUGIN_NAME "tencent_wemeet_plugin")

# Any new source files that you add to the plugin should be added here.
list(APPEND PLUGIN_SOURCES
  "tencent_wemeet_plugin.cpp"
  "tencent_wemeet_plugin.h"
)

# Define the plugin library target. Its name must not be changed (see comment
# on PLUGIN_NAME above).
#add_library(${PLUGIN_NAME} SHARED
#  "include/tencent_wemeet/tencent_wemeet_plugin_c_api.h"
#  "tencent_wemeet_plugin_c_api.cpp"
#  ${PLUGIN_SOURCES}
#)
add_library(${PLUGIN_NAME} SHARED
        "include/**/*.h"
        "*.cpp"
        ${PLUGIN_SOURCES}
)

#set(WEMEET_HEADER_FILES "include/wemeet_sdk.h"
#        "include/wemeet_sdk_def.h"
#        "include/wemeet_sdk_interface.h"
#)


add_library(wemeet_base "wemeet_base.dll")
set_target_properties(wemeet_base PROPERTIES LINKER_LANGUAGE C)


add_library(wemeet_base_x64 "wemeet_base_x64.dll")
set_target_properties(wemeet_base_x64 PROPERTIES LINKER_LANGUAGE C)


add_library(wemeetsdk_x64 "wemeetsdk_x64.dll")
set_target_properties(wemeetsdk_x64 PROPERTIES LINKER_LANGUAGE C)



# Apply a standard set of build settings that are configured in the
# application-level CMakeLists.txt. This can be removed for plugins that want
# full control over build settings.
apply_standard_settings(${PLUGIN_NAME})

# Symbols are hidden by default to reduce the chance of accidental conflicts
# between plugins. This should not be removed; any symbols that should be
# exported should be explicitly exported with the FLUTTER_PLUGIN_EXPORT macro.
set_target_properties(${PLUGIN_NAME} PROPERTIES
  CXX_VISIBILITY_PRESET hidden)
target_compile_definitions(${PLUGIN_NAME} PRIVATE FLUTTER_PLUGIN_IMPL)

# Source include directories and library dependencies. Add any plugin-specific
# dependencies here.
target_include_directories(${PLUGIN_NAME} INTERFACE
  "${CMAKE_CURRENT_SOURCE_DIR}/include")



target_link_libraries(${PLUGIN_NAME} PRIVATE
        flutter
        flutter_wrapper_plugin
        )

# List of absolute paths to libraries that should be bundled with the plugin.
# This list could contain prebuilt libraries, or libraries created by an
# external build triggered from this build file.
set(tencent_wemeet_bundled_libraries
  ""
  PARENT_SCOPE
)
