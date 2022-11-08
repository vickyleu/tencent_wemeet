#ifndef WEMEET_PRI_SDK_DEF_H_
#define WEMEET_PRI_SDK_DEF_H_

#if defined(WIN32) || defined(_WIN32)
#ifdef WEMEETSDK_EXPORTS
#  define WEMEET_SDK_API __declspec(dllexport)
#else
#  define WEMEET_SDK_API __declspec(dllimport)
#endif
#else
#define WEMEET_SDK_API __attribute__ ((visibility("default")))// NOLINT
#endif


enum WemeetSDKErrCode {
  kTMSDKErrorSuccess = 0,
  kTMSDKErrorServerConfigFail = -1001,                  // 私有云SDK设置服务地址或获取服务配置失败
  kTMSDKErrorInvalidAuthCode = -1002,                   // 获取AuthCode，登录时传入参数不正确可能会导致
  kTMSDKErrorLogoutInMeeting = -1003,                   // 正在会议中，无法退出，需先离会
  kTMSDKErrorUnknown = -1005,                           // 未知错误，出现该错误码，请官方联系
  kTMSDKErrorUserNotAuthorized = -1006,                 // 未登录，在入会、投屏、显示会前界面之前没有成功登录
  kTMSDKErrorUserInMeeting = -1007,                     // 已在会议中。在入会、投屏、显示会前界面的时候，用户在会议中，需先退出
  kTMSDKErrorInvalidParam = -1008,                      // 无效参数。在调用SDK接口时，包含无效参数
  kTMSDKErrorInvalidMeetingCode = -1009,                // 无效会议号
  kTMSDKErrorInvalidNickname = -1010,                   // 无效入会的用户名称，可能长度过长导致
  kTMSDKErrorDuplicateInitCall = -1011,                 // 重复调用初始化
  kTMSDKErrorAccountAlreadyLogin = -1012,               // 账号已登录
  kTMSDKErrorSdkNotInitialized = -1013,                 // SDK未初始化/未初始化完成
  kTMSDKErrorSyncCallTimeout = -1014,                   // SDK同步调用超时
  kTMSDKErrorNotInMeeting = -1015,                      // 非入会状态调用会议中接口
  kTMSDKErrorCancelJoin = -1016,                        // 用户手动取消入会
  kTMSDKErrorIsLogining = -1017,                        // 已经在登录状态中，重复登录
  kTMSDKErrorLoginNetError = -1018,                     // 登录过程出现网络错误
  kTMSDKErrorTokenVerifyFailed = -1019,                 // sdktoken校验失败，可能是登录时sdktoken过期或使用时sdktoken失效，需要refreshToken后再登录
  kTMSDKErrorChildProcessCrash = -1020,                 // 子进程退出
  kTMSDKErrorMultiAccountLoginConflict = -1021,         // 已登录状态下，未调用logout就切换账号登录
  kTMSDKErrorJoinMeetingServiceFailed = -1022,          // 服务端拒绝入会，请用返回错误码和错误描述联系官方
  kTMSDKErrorActionConflict = -1023,
  kTMSDKErrorInvalidJsonString = -1024,
  kTMSDKErrorProxySetFailed = -1025,
  kTMSDKErrorInvalidSchemaString = -1026,
};

enum WemeetSDKActionType {
  kTMSDKChooseInviteUser,   // 邀请选人
};

enum WemeetSDKLoginType {
  kTMSDKPrivateWework = 1,
};

enum WM_MEETING_TYPE {
  WM_MEETING_TYPE_NORMAL = 0,        // 普通会议
  WM_MEETING_TYPE_QUICK_MEETING = 1,        // 快速会议
};

enum WM_SCHEDULE_MEETING_TYPE {
  WM_SCHEDULE_MEETING_TYPE_NORMAL = 0,        // 普通周期会议
  WM_SCHEDULE_MEETING_TYPE_MULTIUSER = 1,        // 在线大会
};

enum PreMeetingActionType {
  kShowPreMeetingView = 0,
  kShowScreenCastView,
  kShowHistoricalMeetingView,
  kShowMeetingDetailView,
  kShowJoinMeetingView,
  kShowScheduleMeetingView,
  kShowMeetingSettingView,
  kQeuryMeetingInfo,
  kInviteUsers,
  kQuickMeeting,
};

// 初始化的参数
enum WM_PRE_MEETING_VIEW_STYLE {
  WM_PRE_MEETING_VIEW_STYLE_CLASSIC = 0,      //经典模块
  WM_PRE_MEETING_VIEW_STYLE_TABS = 1,        //多tab
};

typedef struct tagInitParams {
  const char* sdk_id;
  const char* sdk_token;
  const char* server_host;
  const char* org_domain;
  const char* language;           // zh-cn，en-us
  const char* data_path;          // 需要UTF-8编码
  const char* app_name;           // 所展示的app名称
  const char* app_icon;           // 任务栏图标
  const char* res_dir;
  tagInitParams() {
    sdk_id = "";
    sdk_token = "";
    server_host = "";
    org_domain = "";
    data_path = "";
    app_name = "";
    app_icon = "";
    res_dir = "";
    language = "";
  }
} InitParams;

typedef struct tagJoinMeetingParames {
  const char* meeting_code;
  const char* user_display_name;     // 需要UTF-8编码
  const char* password;
  const char* invite_url;
  bool mic_on;
  bool camera_on;
  bool speaker_on;
  bool face_beauty_on;
  tagJoinMeetingParames() {
    meeting_code = "";
    user_display_name = "";
    password = "";
    invite_url = "";
    mic_on = false;
    camera_on = true;
    speaker_on = false;
    face_beauty_on = true;
  }
} JoinMeetingParams;

typedef struct tagShowQuickMeetingNotifyParams {
  const char *meeting_code;
  const char *subject;
  const char *inviter;
  const char *invite_url;
  bool display_invite_url;
  tagShowQuickMeetingNotifyParams() {
    meeting_code = "";
    subject = "";
    inviter = "";
    invite_url = "";
    display_invite_url = true;
  }
} ShowQuickMeetingNotifyParams;

typedef struct tagWeMeetShareMeetingInfo {
  const char *meeting_code;  // 会议号
  const char *subject;       // 会议主题
  const char *meeting_url;   // 分享链接
  int start_time;    // 开始时间
  int end_time;       // 结束时间
  WM_MEETING_TYPE meeting_type;  // 会议类型
  tagWeMeetShareMeetingInfo() {
    meeting_code = "";
    subject = "";
    meeting_url = "";
    start_time = 0;
    end_time = 0;
    meeting_type = WM_MEETING_TYPE_NORMAL;
  }
} WeMeetShareMeetingInfo;

typedef struct tagWeMeetMeetingInfo {
  const char *meeting_code;  // 会议号
  const char *subject;       // 会议主题
  const char *meeting_url;   // 分享链接
  int start_time;    // 开始时间
  int end_time;       // 结束时间
  WM_MEETING_TYPE meeting_type;  // 会议类型
  const char *host_name;
  tagWeMeetMeetingInfo() {
    meeting_code = "";
    subject = "";
    meeting_url = "";
    start_time = 0;
    end_time = 0;
    meeting_type = WM_MEETING_TYPE_NORMAL;
    host_name = "";
  }
} WeMeetMeetingInfo;

#endif  /* ifndef WEMEET_SDK_DEF_H_ */
