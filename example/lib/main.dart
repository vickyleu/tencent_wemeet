import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tencent_wemeet/tencent_wemeet.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp>
    implements WeMeetHostApi, WeMeetAndroidGrantedHostApi {
  bool isPrivacyNeedGrant = false;

  TencentWemeet wemeet = TencentWemeet.instance();

  @override
  void initState() {
    super.initState();
    wemeet.registerCallback(this);
    Future.delayed(const Duration(seconds: 3)).then((value) {
      initPlatformState();
    });
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    try {
      final params = DartInitParams(
          sdkId: 'xxxxxxxxx',
          sdkToken: 'xxxxxxxxxxxxxxxxxxxxxxxxxxx',
          appName: '',
          preferLanguage: '中文');
      await wemeet.initWeMeet(params);

      // TencentWemeet.tokenInvalid();
    } on PlatformException catch (e) {
      print("e:$e result");
    }
  }

  @override
  void sdkInitSuccess() {
    print("initWeMeet result");
    Future.delayed(const Duration(seconds: 1)).then((value) async {
      const host =
          'https://meetingxxxxxx-idp.id.meeting.qq.com/cidp/custom/ai-xxxxxxxxx/ai-xxxxxxxxxxx?id_token=';
      const idToken = 'xxxxxxxxxxxxxxxxxx';
      await wemeet.loginMeeting('$host$idToken');
      print("loginMeeting result");
    });
  }

  @override
  void loginSuccess() {
    /*final joinParam = DartJoinParam(
        meetingCode: 'xxxxx',
        userDisplayName: '哎哟喂',
        password: '',
        // password: 'xxxx',
        inviteUrl: '',
        micOn: true,
        cameraOn: true,
        speakerOn: true,
        faceBeautyOn: true);
    Future.delayed(const Duration(seconds: 1)).then((value) async {
      await TencentWemeet.joinMeeting(joinParam);
      print("joinMeeting result");
    });*/

    Future.delayed(const Duration(seconds: 1)).then((value) async {
      await wemeet.jumpToHistory();
      print("jumpToHistory result");
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: const Center(
          child: Text('Running on: \n'),
        ),
      ),
    );
  }

  @override
  Future<void> sdkTokenInvalid() async {}

  @override
  void loginFailed(int code, String? msg) {}

  @override
  Future<bool?> initPrivacyNeedGrant() async {
    return isPrivacyNeedGrant;
  }

  @override
  void onLeaveMeeting(int type, int code, String msg, String meetingCode) {}

  @override
  void sdkInitFailed() {}
}
