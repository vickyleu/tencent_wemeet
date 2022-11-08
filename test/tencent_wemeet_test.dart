import 'package:flutter/cupertino.dart';
import 'package:flutter/src/services/binary_messenger.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'package:tencent_wemeet/api_generated.dart';
import 'package:tencent_wemeet/tencent_wemeet.dart';
import 'package:tencent_wemeet/tencent_wemeet_method_channel.dart';
import 'package:tencent_wemeet/tencent_wemeet_platform_interface.dart';

class MockTencentWemeetPlatform
    with MockPlatformInterfaceMixin
    implements TencentWemeetPlatform {
  @override
  Future<void> initWeMeet(DartInitParams params) =>
      Future.sync(() => null);

  @override
  BinaryMessenger? get binaryMessenger =>
      WidgetsBinding.instance.defaultBinaryMessenger;

  @override
  Future<void> registerNativeCallback(WeMeetHostApi api) async {}

  @override
  Future<void> registerGrantedNativeCallback(WeMeetAndroidGrantedHostApi api) async {}

  @override
  Future<void> joinMeeting(DartJoinParam param) async {}

  @override
  Future<void> jumpToHistory() async {}

  @override
  Future<void> notifyPrivacyGranted() {
    // TODO: implement notifyPrivacyGranted
    throw UnimplementedError();
  }

  @override
  Future<void> loginMeeting(String ssoUrl) async {}

  @override
  Future<bool> isInitialized() {
    // TODO: implement isInitialized
    throw UnimplementedError();
  }

  @override
  Future<bool> isLoggedIn() {
    // TODO: implement isLoggedIn
    throw UnimplementedError();
  }

  @override
  Future<void> leaveMeeting() {
    // TODO: implement leaveMeeting
    throw UnimplementedError();
  }

  @override
  Future<void> logout() {
    // TODO: implement logout
    throw UnimplementedError();
  }

  @override
  Future<int> refreshSDKToken(String newSdkToken) {
    // TODO: implement refreshSDKToken
    throw UnimplementedError();
  }

  @override
  Future<void> releaseWeMeet() {
    // TODO: implement releaseWeMeet
    throw UnimplementedError();
  }

  @override
  Future<String> getUrlWithLoginStatus(String targetUrl) async{
    return '';
  }

  @override
  Future<void> jumpUrlWithLoginStatus(String targetUrl) async{

  }

  @override
  Future<void> showMeetingDetailView(String meetingId, String currentSubMeetingId, String startTime, bool isHistory) async{

  }

  @override
  Future<String> getCurrentSDKToken() async{
    return '';
  }
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  final TencentWemeetPlatform initialPlatform = TencentWemeetPlatform.instance;

  TencentWemeet wemeet = TencentWemeet.instance();
  test('$MethodChannelTencentWemeet is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelTencentWemeet>());
  });

  test('initWeMeet', () async {
    final params = DartInitParams(
        sdkId: '',
        sdkToken: '',
        serverAddress: ''
        //
        ,
        appName: '',
        serverDomain: '',
        preferLanguage: '');
    MockTencentWemeetPlatform fakePlatform = MockTencentWemeetPlatform();
    TencentWemeetPlatform.instance = fakePlatform;
    (await wemeet.initWeMeet(params));
    expect(Null, Null);
  });
}
