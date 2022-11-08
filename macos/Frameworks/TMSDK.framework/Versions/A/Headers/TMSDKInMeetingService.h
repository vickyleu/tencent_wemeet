
//
//  TMSDKInMeetingService.h
//  TMSDK
//
//  Created by Tencent on 2021/7/16.
//

#import <Foundation/Foundation.h>
#import "TMSDKErrors.h"

typedef NS_ENUM(NSUInteger, TMSDKMeetingType) {
    TMSDKMeetingTypeNormal = 0,              // 普通会议,
    TMSDKMeetingTypeQuickMeeting = 1,        // 快速会议,
};

typedef NS_ENUM(NSUInteger, TMSDKMeetingConfigType) {
    TMSDKMeetingConfigTypeShareCallback  = 1,             // 分享回调,
    TMSDKMeetingConfigTypeMeetingInfoCallback  = 2,       // 会议信息回调,
};

//分享回调内容
//会议信息回调内容
@interface TencentMeetingInfo : NSObject
/// 会议号
@property (nonatomic, copy) NSString *meetingCode;
/// 会议主题
@property (nonatomic, copy) NSString *subject;
/// 分享链接
@property (nonatomic, copy) NSString *meetingUrl;
/// 开始时间
@property (nonatomic, copy) NSString *startTime;
/// 结束时间
@property (nonatomic, copy) NSString *endTime;
/// 会议类型
@property (nonatomic, assign) TMSDKMeetingType meetingType;
/// 会议密码
@property (nonatomic, copy) NSString *password;
/// 主持人名字
@property (nonatomic, copy) NSString *hostName;
@end

@protocol TMSDKInMeetingDelegate <NSObject>

@optional

/**
 * @brief 退出会议事件结果回调
 * @param type 离会类型
 * @param code 错误码 0 表示成功, 其他表示失败
 * @param meetingCode 会议号
 * @param msg 描述信息
*/
- (void)onLeaveMeeting:(int)type code:(TMSDKError)code msg:(NSString *)msg meetingCode:(NSString *)meetingCode;

/**
 * @brief 用户在会议中点击邀请的回调
 * @param inviteInfo 分享内容
 */
- (void)onInviteMeeting:(NSString *)inviteInfo;

/**
 * @brief 会议信息展示回调
 * @param meetingInfo 展示会议信息
 */
- (void)onShowMeetingInfo:(NSString *)meetingInfo;

@end

@interface TMSDKInMeetingService : NSObject

@property (nonatomic, weak) id <TMSDKInMeetingDelegate> delegate;

/**
 * @brief 离开会议
 * @param isEnd 是否结束会议，仅当前账户是会议主持人时，该参数才有效
 */
- (void)leaveMeeting:(BOOL)isEnd;

/**
 * @brief 会议中点击邀请的回调设置
 * @param enable 是否回调
 * @param show 是否显示信息页面
 */
- (void)enableInviteCallback:(BOOL)enable show:(BOOL)show;

/**
 * @brief 会议中点击邀请的回调设置
 * @param enable 是否回调
 * @param show 是否显示信息页面
 */
- (void)enableMeetingInfoCallback:(BOOL)enable show:(BOOL)show;

/**
 * @brief 将会议中界面置顶
 */
- (void)bringInMeetingViewTop;

@end
