#ifndef WEMEET_SDK_H_
#define WEMEET_SDK_H_

#include "wemeet_sdk_def.h"
#include "wemeet_sdk_interface.h"

class IWemeetSDK;

#ifdef __cplusplus
extern "C" {
#endif

// 创建 IWemeetSDK 全局单例
WEMEET_SDK_API IWemeetSDK* GetWemeetSDKInstance();

// 释放 IWemeetSDK 全局单例
WEMEET_SDK_API void ReleaseWemeetSDKInstance();

// 获取版本号
WEMEET_SDK_API void GetWemeetSDKVersion(char* buf, int len);

#ifdef __cplusplus
}  /* end of the 'extern "C"' block */
#endif

class IAccountService {
public:
  virtual void SetCallback(IAuthenticationCallback* callback) = 0;

  virtual void Login(const char* sso_url) = 0;
    
  virtual void LoginByAccountPassword(const char* login_url, const char* user_name, const char* passwd) = 0;

  virtual void LoginByCode(const char* auth_code, const char* user_id, int login_type) = 0;

  virtual void Logout() = 0;

  virtual bool IsLoggedIn() = 0;

  virtual void JumpUrlWithLoginStatus(const char* target_url) = 0;

  virtual void GetUrlWithLoginStatus(const char* target_url, char* buf, int buf_len) = 0;

  virtual void GetUserInfo(char* buf, int buf_len) = 0;
};

class IPreMeetingService {
public:
  virtual void SetCallback(IPreMeetingCallback* callback) = 0;

  /**
  * 加入会议
  *
  * @params params 入会参数
  *
  * @note 加入指定会议
  */
  virtual void JoinMeeting(const JoinMeetingParams& params) = 0;

  /**
  * 加入会议
  *
  * @params join_param 入会参数
  *
  * @note 加入指定会议
  */
  virtual void JoinMeetingByJSON(const char* join_param) = 0;
  /**
  *
  * @note 快速会议
  */
  virtual void QuickMeeting() = 0;

  /**
  *
  * @note 显示home界面
  */
  virtual void ShowPreMeetingView(WM_PRE_MEETING_VIEW_STYLE style = WM_PRE_MEETING_VIEW_STYLE_CLASSIC) = 0;

  /**
  *
  * @note 无线投屏
  */
  virtual void ShowScreenCastView() = 0;

  /**
  *
  * @note 历史会议
  */
  virtual void ShowHistoricalMeetingView() = 0;
    
  /**
  *
  * @note 会议详情
  */
  virtual void ShowMeetingDetailView(const char* meeting_id, const char* current_sub_meeting_id) = 0;
  virtual void ShowMeetingDetailView(const char* meeting_id, const char* current_sub_meeting_id, const char* start_time, bool is_history = true) = 0;
  /**
  *
  * @note 显示设置界面
  */
  virtual void ShowMeetingSettingView() = 0;

  /**
  *
  * @note 加入会议
  */
  virtual void ShowJoinMeetingView() = 0;

  /**
  *
  * @note 预定会议
  */
  virtual void ShowScheduleMeetingView(int meeting_type) = 0;

  /**
  *
  * @note 预定会议时邀请用户
  */
  virtual void InviteUsers(const char* meeting_id, const char* data) = 0;

  /**
  *
  * @note 查询会议信息
  */
  virtual void QueryMeetingInfo(const char* data) = 0;
};

class IInMeetingService {
public:
  virtual void SetCallback(IInMeetingCallback* callback) = 0;

  virtual void LeaveMeeting(bool end_meeting) = 0;

  virtual void EnableInviteCallback(bool enable, bool show) = 0;

  virtual void EnableMeetingInfoCallback(bool enable, bool show) = 0;

  /**
  * 将会中窗口置顶
  *
  * @note 如果没有会中窗口，则不做任何操作
  */
  virtual void BringInMeetingViewTop() = 0;
};

class WEMEET_SDK_API IWemeetSDK {
public:
  virtual ~IWemeetSDK() { }

  /**
  * 初始化
  *
  * @param params 初始化参数，详情见InitParams的定义
  *
  * @note 使用WemeetSDK之前必须先初始化SDK
  */
  virtual void Initialize(const InitParams& params, ISDKCallback* sdk_callback) = 0;

  /*
  * SDK 是否已经初始化
  *
  * @note 使用WemeetSDK之前必须先初始化SDK
  */  
  virtual bool IsInitialized() = 0;

  /**
  * 反初始化
  *
  * @note 退出应用前调用
  */
  virtual void Uninitialize() = 0;

  /**
  * 更新SDK token
  *
  * @param new_sdk_token 新的sdk token
  *
  * @note 更新SDK Token，替换掉过期或快过期的SDK Token
  */
  virtual int RefreshSDKToken(const char* new_sdk_token) = 0;

  /*
  * 获取当前 sdk_token
  *
  * @param buf 输出缓冲区
  *
  * @note 获取SDK token
  */
  virtual void GetCurrentSDKToken(char* buf, int buf_len) {}

  /**
  * 打开日志目录
  *
  * @note 打开日志目录，方便获取错误日志
  */
  virtual void ShowLogs() = 0;
/**
  * 显示SDK界面
  *
  * @param params json字符串
  *
  * @note 显示SDK界面
  */
  virtual void ShowSDKView(const char* params) = 0;
  /**
  * 将SDK窗口置顶
  *
  * @note SDK如果没有窗口，则不做任何操作
  */
  virtual void BringViewTop() = 0;

  /**
  /**
  * 设置代理服务器
  *
  * @note 初始化后设置服务代理
  */
  virtual void SetProxyInfo(const char* proxy_info) = 0;

  /**
  /**

  * 一键跳转
  *
  * @note 符合跳转链接跳转，否则不做任何操作
  */
  virtual void HandleSchema(const char* schema_url) = 0;

  /**

  * @note 获取SDKAccountService的对象实例
  */
  virtual IAccountService* GetAccountService() = 0;
  
  /**
  * @note 获取IPremeetingService的对象实例
  */
  virtual IPreMeetingService* GetPreMeetingService() = 0;

  /**
  * @note 获取IInmeetingService的对象实例
  */
  virtual IInMeetingService* GetInMeetingService() = 0;
};

#endif  /* ifndef WEMEET_SDK_H_ */
