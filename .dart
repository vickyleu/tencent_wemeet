import 'package:pigeon/pigeon.dart';

class DartInitParams {
  /// sdk的id
  final String sdkId;

  /// sdk的token,不是登录的idToken
  final String sdkToken;

  /// 应用名称
  final String appName;
  // 私有化部署才会用到的参数
  final String? serverAddress;
  final String? serverDomain;
  // 设置语言,只有"中文"和"English"
  final String? preferLanguage;

  DartInitParams(this.sdkId, this.sdkToken, this.appName,
      {this.serverAddress = '',
      this.serverDomain = '',
      this.preferLanguage = ''});
}

class DartJoinParam {
  /// 会议号
  final String meetingCode;

  /// 用户名
  final String userDisplayName;

  /// 会议密码
  final String password;

  /// 邀请链接
  String inviteUrl;

  /// 是否开启麦克风
  bool micOn;

  /// 是否开启摄像头
  bool cameraOn;

  /// 是否开启扬声器
  bool speakerOn;

  /// 是否开启美颜
  bool faceBeautyOn;

  DartJoinParam(this.meetingCode, this.userDisplayName, this.password,
      {this.inviteUrl = '',
      this.micOn = true,
      this.cameraOn = true,
      this.speakerOn = true,
      this.faceBeautyOn = true});
}

/// 错误码
enum DartErrorCode {
  // 成功
  success(0),
  // 私有云SDK设置服务地址错误或获取服务配置失败
  serverConfigFail(-1001),
  // 无效AuthCode，登录参数不正确或IDaaS登录跳转存在问题
  invalidAuthCode(-1002),
  // 正在会议中，无法退出，需先离会
  logoutInMeeting(-1003),
  // 未知错误，出现该错误码，请与官方联系
  unknown(-1005),
  // 未登录。在入会、投屏、显示会前界面之前没有成功登录。
  userNotAuthorized(-1006),
  // 已在会议中。在入会、投屏、显示会前界面的时候，用户在会议中，需先退出。
  userInMeeting(-1007),
  // 无效参数。在调用SDK接口时，包含无效参数。
  invalidParam(-1008),
  // 无效会议号
  invalidMeetingCode(-1009),
  // 无效入会的用户名称，可能长度过长导致
  invalidNickname(-1010),
  // 重复调用初始化
  duplicateInitCall(-1011),
  // 账号已登录，重复登录调用
  accountAlreadyLogin(-1012),
  // SDK未初始化
  sdkNotInitialized(-1013),
  // SDK同步调用超时
  syncCallTimeout(-1014),
  // 非入会状态调用会议中接口
  notInMeeting(-1015),
  // 用户手动取消入会
  cancelJoin(-1016),
  // 正在登录过程中的重复登录调用
  isLogining(-1017),
  // 登录过程出现网络错误
  loginNetError(-1018),
  // sdktoken校验失败，可能是登录时sdktoken过期或使用时sdktoken失效，需要refreshSDKToken后再登录
  tokenVerifyFailed(-1019),
  // 子进程退出
  childProcessCrash(-1020),
  // A账户已登录，此时未调用logout()就登录B账户导致，如需切换账户，请先调用logout()
  multiAccountLoginConflict(-1021),
  // 服务端拒绝入会，可能是频繁入会请求、输入无效会议号、会议已结束等情况，请用返回错误码和错误描述联系官方
  joinMeetingServiceFailed(-1022),
  // 无效json串，请用返回错误码和错误描述联系官方
  invalidJsonString(-1024),
  // 设置代理失败，请用返回错误码和错误描述联系官方
  proxySetFailed(-1025);
}

@HostApi()
abstract class WeMeetApi {
  /// 初始化SDK并设置回调代理，通过SDKCallback.onSDKInitializeResult回调来返回初始化结果。
  /// 初始化成功后，重复调用无效。
  /// 除getSDKVersion之外，在调用的所有接口函数之前，必须第一个先调用该函数。
  /// 按照个保法要求，App需要在用户同意了隐私协议之后才可以调用该初始化函数。
  void initWeMeet(DartInitParams param);

  /// 跳转历史会议界面
  void jumpToHistory();

  /// 通知android隐私协议已授权
  void notifyPrivacyGranted();

  /// 判断是否已初始化SDK成功
  bool isInitialized();

  /// 发起登录请求，登录结果会在回调AuthenticationCallback.onLogin返回。
  void loginWeMeet(String ssoUrl);

  /// 判断是否已登录
  bool isLoggedIn();

  /// 发起入会请求，结果会在回调PreMeetingCallback.onJoinMeeting返回。登录完成后，才可调用。
  /// 如果想使用JoinParam参数中缺省的默认值，请使用joinMeetingByJSON函数
  void joinMeeting(DartJoinParam joinParam);

  /// 发起离会请求，结果会在回调InMeetingCallback.onLeaveMeeting返回
  void leaveMeeting();

  /// 释放资源
  void releaseWeMeet();

  /// 发起登出请求，登出结果会在回调AuthenticationCallback.onLogout返回。
  void logout();

  /// 更新SDK Token，替换掉过期或快过期的SDK Token。
  int refreshSDKToken(String newSdkToken);

  /// 显示某一个具体会议的界面。
  /// 登陆完成后，才可调用。
  /// 如果输入错误的meeting_id或者current_sub_meeting_id，会议页面中有的字段则会显示’-‘；
  /// 如果输入错误的start_time可能导致页面加载失败，设置准确的start_time参数接口执行效率更高；
  void showMeetingDetailView(
    String meetingId,
    String currentSubMeetingId,
    String startTime,
    bool isHistory,
  );

  /// 带登录态去打开目标地址，该地址必须是会议相关的、并支持登录态方式的页面，必须登录成功才可调用。
  void jumpUrlWithLoginStatus(String targetUrl);

  /// 获取一个带登录态的URL链接，该地址必须是会议相关的、并支持登录态方式的页面，必须登录成功才可调用。
  String getUrlWithLoginStatus(String targetUrl);

  /// 获取当前SDK Token的值。
  String getCurrentSDKToken();
}

@FlutterApi()
abstract class WeMeetHostApi {
  /// 当前登录失效了
  @async
  void sdkTokenInvalid();

  /// 非阻塞通知sdk初始化成功
  void sdkInitSuccess();

  ///登录失败了
  void loginFailed(int code,String? msg);

  /// 非住宿通知登录成功
  void loginSuccess();

  /// 离开会议： 离会类型，1：用户自身操作离会；2：被踢出会议；3：会议结束
  /// 结果码：0表示成功；其他值表示失败
  void onLeaveMeeting(int type, int code, String msg, String meetingCode);

  /// 非阻塞通知sdk初始化失败
  void sdkInitFailed();
}

@FlutterApi()
abstract class WeMeetAndroidGrantedHostApi {
  /// 读取隐私协议是否授权,由于插件采用自动配置,初始化速度快于dart端,需要提前准备好
  @async
  bool? initPrivacyNeedGrant();
}
