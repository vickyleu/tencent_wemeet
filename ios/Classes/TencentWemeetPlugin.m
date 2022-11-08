#import "TencentWemeetPlugin.h"
#if __has_include(<tencent_wemeet/tencent_wemeet-Swift.h>)
#import <tencent_wemeet/tencent_wemeet-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "tencent_wemeet-Swift.h"
#endif

@implementation TencentWemeetPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftTencentWemeetPlugin registerWithRegistrar:registrar];
}
@end
