import 'package:tencent_wemeet/api_generated.dart';

import 'tencent_wemeet_platform_interface.dart';
export 'package:tencent_wemeet/api_generated.dart';

class TencentWemeet {
  TencentWemeet._();

  static TencentWemeet? _shareInstance;

  /// 采用单例模式,插件需要在合适的时候释放
  factory TencentWemeet.instance() {
    _shareInstance ??= TencentWemeet._();
    return _shareInstance!;
  }

  Future registerCallback(WeMeetHostApi api) async {
    await TencentWemeetPlatform.instance.registerNativeCallback(api);
    print("onAttachedToActivity onAttachedToEngine attach:registerCallback");
  }

  Future registerGrantedCallback(
      WeMeetAndroidGrantedHostApi grantedHostApi) async {
    await TencentWemeetPlatform.instance
        .registerGrantedNativeCallback(grantedHostApi);
    print(
        "onAttachedToActivity onAttachedToEngine attach:registerGrantedCallback");
  }

  Future<void> initWeMeet(DartInitParams params) {
    return TencentWemeetPlatform.instance.initWeMeet(params);
  }

  Future<void> loginMeeting(String ssoUrl) {
    return TencentWemeetPlatform.instance.loginMeeting(ssoUrl);
  }

  Future<void> joinMeeting(DartJoinParam param) {
    return TencentWemeetPlatform.instance.joinMeeting(param);
  }

  Future<void> jumpToHistory() {
    return TencentWemeetPlatform.instance.jumpToHistory();
  }

  Future<void> notifyPrivacyGranted() {
    return TencentWemeetPlatform.instance.notifyPrivacyGranted();
  }

  Future<bool> isInitialized() {
    return TencentWemeetPlatform.instance.isInitialized();
  }

  Future<bool> isLoggedIn() {
    return TencentWemeetPlatform.instance.isLoggedIn();
  }

  Future<void> leaveMeeting() {
    return TencentWemeetPlatform.instance.leaveMeeting();
  }

  Future<void> releaseWeMeet() {
    return TencentWemeetPlatform.instance.releaseWeMeet();
  }

  Future<void> logout() {
    return TencentWemeetPlatform.instance.logout();
  }

  Future<int> refreshSDKToken(String newSdkToken) {
    return TencentWemeetPlatform.instance.refreshSDKToken(newSdkToken);
  }

  Future<void> showMeetingDetailView(String meetingId,
      String currentSubMeetingId, String startTime, bool isHistory) {
    return TencentWemeetPlatform.instance.showMeetingDetailView(
        meetingId, currentSubMeetingId, startTime, isHistory);
  }

  Future<void> jumpUrlWithLoginStatus(String targetUrl) {
    return TencentWemeetPlatform.instance.jumpUrlWithLoginStatus(targetUrl);
  }

  Future<String> getUrlWithLoginStatus(String targetUrl) {
    return TencentWemeetPlatform.instance.getUrlWithLoginStatus(targetUrl);
  }

  Future<String> getCurrentSDKToken() {
    return TencentWemeetPlatform.instance.getCurrentSDKToken();
  }
}
