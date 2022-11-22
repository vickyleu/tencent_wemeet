import 'package:tencent_wemeet/api_generated.dart';

import 'tencent_wemeet_platform_interface.dart';

class TencentWemeet {
  static Future registerCallback(WeMeetHostApi api) async{
     await TencentWemeetPlatform.instance.registerNativeCallback(api);
     print("onAttachedToActivity onAttachedToEngine attach:registerCallback");
  }

  static Future<void> initWeMeet(DartInitParams params) {
    return TencentWemeetPlatform.instance.initWeMeet(params);
  }

  static Future<void> loginMeeting(String ssoUrl) {
    return TencentWemeetPlatform.instance.loginMeeting(ssoUrl);
  }

  static Future<void> joinMeeting(DartJoinParam param) {
    return TencentWemeetPlatform.instance.joinMeeting(param);
  }
  static Future<void> jumpToHistory() {
    return TencentWemeetPlatform.instance.jumpToHistory();
  }

  static Future<bool> isInitialized() {
    return TencentWemeetPlatform.instance.isInitialized();
  }

  static Future<bool> isLoggedIn() {
    return TencentWemeetPlatform.instance.isLoggedIn();
  }

  static Future<void> leaveMeeting() {
    return TencentWemeetPlatform.instance.leaveMeeting();
  }

  static Future<void> releaseWeMeet() {
    return TencentWemeetPlatform.instance.releaseWeMeet();
  }

  static Future<void> logout() {
    return TencentWemeetPlatform.instance.logout();
  }

  static Future<int> refreshSDKToken(String newSdkToken) {
    return TencentWemeetPlatform.instance.refreshSDKToken(newSdkToken);
  }
}
