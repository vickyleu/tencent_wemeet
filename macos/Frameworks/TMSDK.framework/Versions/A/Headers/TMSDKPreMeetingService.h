//
//  TMSDKPreMeetingService.h
//  TMSDK
//
//  Created by Tencent on 2021/7/16.
//

#import <Foundation/Foundation.h>
#import "TMSDKErrors.h"

typedef NS_ENUM(NSUInteger, ActionType) {
  ShowPreMeetingView,
  ShowScreenCastView,
  ShowHistoricalMeetingView,
  ShowMeetingDetailView,
  ShowJoinMeetingView,
  ShowScheduleMeetingView,
  ShowMeetingSettingView,
  ClosePreMeetingView = 100,//sdk doc define
  QeuryMeetingInfo,
  InviteUsers,
  QuickMeeting,
};

typedef NS_ENUM(NSUInteger, TMSDKMainUIStyle) {
  kTMSDKMainUIStyleClassic,
  kTMSDKMainUIStyleTabs
};

NS_ASSUME_NONNULL_BEGIN

@interface TMSDKJoinParams : NSObject
/// 会议号
@property (nonatomic, copy) NSString *meetingCode;
/// 会议中显示的名称
@property (nonatomic, copy) NSString *userDisplayName;
/// 会议密码
@property (nonatomic, copy) NSString *password;
/// 自定义邀请链接
@property (nonatomic, copy) NSString *inviteUrl;
/// 是否开启麦克风
@property (nonatomic, assign) BOOL micOn;
/// 是否开启摄像头
@property (nonatomic, assign) BOOL cameraOn;
/// 是否开启美颜
@property (nonatomic, assign) BOOL faceBeautyOn;

@end

@protocol TMSDKPreMeetingDelegate <NSObject>

@optional

/**
 * @brief 进入会议事件的结果回调
 *
 * @param code 错误码
 * @param msg 描述信息
 * @param meetingCode 会议号
*/
- (void)onJoinMeeting:(TMSDKError)code msg:(NSString *)msg meetingCode:(NSString *)meetingCode;

/**
 * @brief 打开无线投屏的回调
 *
 * @param code 错误码
 * @param msg 描述信息
*/
- (void)onShowScreenCastViewResult:(TMSDKError)code msg:(NSString *)msg;

/**
 * @brief 用户操作的回调
 *
 * @param actionType 用户行为操作
 * @param code 错误码
 * @param msg 描述信息
*/
- (void)onActionResult:(int)actionType code:(TMSDKError)code msg:(NSString *)msg;
@end

@interface TMSDKPreMeetingService : NSObject

@property (weak, nonatomic) id<TMSDKPreMeetingDelegate> delegate;

/**
 * @brief 加入会议
 * @param joinParams 入会参数.
 */
- (void)joinMeeting:(TMSDKJoinParams *)joinParams;

/**
 * @brief 通过Json串加入会议
 * @param joinMeetingJson 入会的Json参数.
 */
- (void)joinMeetingByJSON:(NSString *)joinMeetingJSON;

/**
 * @brief 加入会议
 * @param params 入会参数.
 */
- (void)quickMeeting;
/**
 * @brief 展示会前主界面
 */
- (void)showPremeetingView;

- (void)showPremeetingView:(TMSDKMainUIStyle)stype;

/**
 * @brief 无线投屏
 */
- (void)showScreenCastView;

/**
 * @brief 查询历史会议
 */
- (void)showHistoricalMeetingView;

/**
 *@brief查询某一具体会议
 */
- (void)showMeetingDetailView:(NSString *)meetingId currentSubMeetingId:(NSString *)currentSubMeetingId;

- (void)showMeetingDetailView:(NSString *)meetingId currentSubMeetingId:(NSString *)currentSubMeetingId startTime:(NSString *)startTime isHistory:(BOOL)isHistory;

/**
 *@brief展示加入会议界面
 */
- (void)showJoinMeetingView;

/**
 *@brief展示预定会议界面
 */
- (void)showScheduleMeetingView:(int)meetingType;

/**
 *@brief展示设置管理界面
 */
- (void)showMeetingSettingView;

/**
 *@brief邀请人之后，将结果传给SDK
 */
- (void)inviteUsers:(NSString *)meetingId data:(NSString *)data;

/**
 *@brief查询会议信息，结果通过onActionResult获取
 */
- (void)queryMeetingInfo:(NSString *)param;

@end

NS_ASSUME_NONNULL_END
