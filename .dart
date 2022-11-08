import 'package:pigeon/pigeon.dart';

class DartInitParams {
  final String sdkId;
  final String sdkToken;
  final String appName;
  final String serverAddress;
  final String serverDomain;
  final String envName;
  final String envId;
  final String envDomain;
  final bool envDebugMode;
  final String preferLanguage;

  DartInitParams(
      this.sdkId,
      this.sdkToken,
      this.appName,
      this.serverAddress,
      this.serverDomain,
      this.envName,
      this.envId,
      this.envDomain,
      this.envDebugMode,
      this.preferLanguage);
}

class DartTMJoinParam {
  /// 会议号
  final String meetingCode;

  /// 用户名
  final String userDisplayName;

  /// 会议密码
  final String password;

  /// 邀请链接
  final String inviteUrl;

  /// 是否开启麦克风
  final bool micOn;

  /// 是否开启摄像头
  final bool cameraOn;

  /// 是否开启扬声器
  final bool speakerOn;
  final bool faceBeautyOn;

  DartTMJoinParam(
      this.meetingCode,
      this.userDisplayName,
      this.password,
      this.inviteUrl,
      this.micOn,
      this.cameraOn,
      this.speakerOn,
      this.faceBeautyOn);
}

@HostApi()
abstract class WeMeetApi {
  void initWeMeet(DartInitParams param);

  void loginWeMeet(String ssoUrl);

  void joinMeeting(DartTMJoinParam joinParam);

  void leaveMeeting();

  void releaseWeMeet();
}
