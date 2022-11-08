import 'package:flutter/cupertino.dart';
import 'package:flutter/src/services/binary_messenger.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'package:tencent_wemeet/api_generated.dart';

import 'tencent_wemeet_method_channel.dart';

abstract class TencentWemeetPlatform extends PlatformInterface {
  /// Constructs a TencentWemeetPlatform.
  final BinaryMessenger? binaryMessenger;

  TencentWemeetPlatform({required this.binaryMessenger}) : super(token: _token);

  static final Object _token = Object();

  static TencentWemeetPlatform _instance = MethodChannelTencentWemeet(
      binaryMessenger: WidgetsBinding.instance.defaultBinaryMessenger);

  /// The default instance of [TencentWemeetPlatform] to use.
  ///
  /// Defaults to [MethodChannelTencentWemeet].
  static TencentWemeetPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [TencentWemeetPlatform] when
  /// they register themselves.
  static set instance(TencentWemeetPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<void> registerNativeCallback(WeMeetHostApi api) {
    throw UnimplementedError(
        'registerNativeCallback(api) has not been implemented.');
  }

  Future<void> registerGrantedNativeCallback(WeMeetAndroidGrantedHostApi api) {
    throw UnimplementedError(
        'registerGrantedNativeCallback(api) has not been implemented.');
  }

  Future<void> initWeMeet(DartInitParams params) {
    throw UnimplementedError('initWeMeet(params) has not been implemented.');
  }

  Future<void> loginMeeting(String ssoUrl) {
    throw UnimplementedError('loginMeeting(ssoUrl) has not been implemented.');
  }

  Future<void> joinMeeting(DartJoinParam param) {
    throw UnimplementedError('joinMeeting(param) has not been implemented.');
  }

  Future<void> notifyPrivacyGranted() {
    throw UnimplementedError('notifyPrivacyGranted has not been implemented.');
  }

  Future<bool> isInitialized() {
    throw UnimplementedError('isInitialized has not been implemented.');
  }

  Future<bool> isLoggedIn() {
    throw UnimplementedError('isLoggedIn has not been implemented.');
  }

  Future<void> jumpToHistory() {
    throw UnimplementedError('jumpToHistory has not been implemented.');
  }

  Future<void> leaveMeeting() {
    throw UnimplementedError('leaveMeeting has not been implemented.');
  }

  Future<void> releaseWeMeet() {
    throw UnimplementedError('releaseWeMeet has not been implemented.');
  }

  Future<void> logout() {
    throw UnimplementedError('logout has not been implemented.');
  }

  Future<int> refreshSDKToken(String newSdkToken) {
    throw UnimplementedError(
        'refreshSDKToken(String newSdkToken) has not been implemented.');
  }

  Future<void> showMeetingDetailView(String meetingId,
      String currentSubMeetingId, String startTime, bool isHistory) {
    throw UnimplementedError(
        'showMeetingDetailView() has not been implemented.');
  }

  Future<void> jumpUrlWithLoginStatus(String targetUrl) {
    throw UnimplementedError(
        'jumpUrlWithLoginStatus() has not been implemented.');
  }

  Future<String> getUrlWithLoginStatus(String targetUrl) {
    throw UnimplementedError(
        'getUrlWithLoginStatus() has not been implemented.');
  }

  Future<String> getCurrentSDKToken() {
    throw UnimplementedError('getCurrentSDKToken() has not been implemented.');
  }
}
