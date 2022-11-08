import 'package:tencent_wemeet/api_generated.dart';

import 'tencent_wemeet_platform_interface.dart';

/// An implementation of [TencentWemeetPlatform] that uses method channels.
class MethodChannelTencentWemeet extends TencentWemeetPlatform {
  MethodChannelTencentWemeet({required super.binaryMessenger})
      : wemeetApi = WeMeetApi(binaryMessenger: binaryMessenger);

  late WeMeetApi wemeetApi;

  @override
  Future<void> registerNativeCallback(WeMeetHostApi api) async {
    return WeMeetHostApi.setup(api, binaryMessenger: binaryMessenger);
  }

  @override
  Future<void> registerGrantedNativeCallback(
      WeMeetAndroidGrantedHostApi api) async {
    return WeMeetAndroidGrantedHostApi.setup(api,
        binaryMessenger: binaryMessenger);
  }

  @override
  Future<void> initWeMeet(DartInitParams params) async {
    return wemeetApi.initWeMeet(params);
  }

  @override
  Future<void> notifyPrivacyGranted() async {
    return wemeetApi.notifyPrivacyGranted();
  }

  @override
  Future<void> jumpToHistory() async {
    wemeetApi.jumpToHistory();
  }

  @override
  Future<void> loginMeeting(String ssoUrl) {
    return wemeetApi.loginWeMeet(ssoUrl);
  }

  @override
  Future<void> joinMeeting(DartJoinParam param) {
    return wemeetApi.joinMeeting(param);
  }

  @override
  Future<bool> isInitialized() {
    return wemeetApi.isInitialized();
  }

  @override
  Future<bool> isLoggedIn() {
    return wemeetApi.isLoggedIn();
  }

  @override
  Future<void> leaveMeeting() {
    return wemeetApi.leaveMeeting();
  }

  @override
  Future<void> releaseWeMeet() {
    return wemeetApi.releaseWeMeet();
  }

  @override
  Future<void> logout() {
    return wemeetApi.logout();
  }

  @override
  Future<int> refreshSDKToken(String newSdkToken) {
    return wemeetApi.refreshSDKToken(newSdkToken);
  }

  @override
  Future<void> showMeetingDetailView(String meetingId,
      String currentSubMeetingId, String startTime, bool isHistory) {
    return wemeetApi.showMeetingDetailView(
        meetingId, currentSubMeetingId, startTime, isHistory);
  }

  @override
  Future<void> jumpUrlWithLoginStatus(String targetUrl) {
    return wemeetApi.jumpUrlWithLoginStatus(targetUrl);
  }

  @override
  Future<String> getUrlWithLoginStatus(String targetUrl) {
    return wemeetApi.getUrlWithLoginStatus(targetUrl);
  }

  @override
  Future<String> getCurrentSDKToken() {
    return wemeetApi.getCurrentSDKToken();
  }
}
