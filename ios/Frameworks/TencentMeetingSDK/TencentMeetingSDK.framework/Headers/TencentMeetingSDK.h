//
//  TencentWeMeetSDK.m
//  TencentWeMeetSDK
//
//  Created by zzjf on 2021/7/12.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "TMAccountService.h"
#import "TMPreMeetingService.h"
#import "TMInMeetingService.h"
#import "TencentMeetingSDKDefine.h"
NS_ASSUME_NONNULL_BEGIN

@interface TMInitParam : NSObject
@property (nonatomic, copy) NSString *sdkId;
@property (nonatomic, copy) NSString *sdkToken;
/// 私有化服务器地址，格式为：{protocol}://{domain}:{port}，protocol默认为http；port默认为29666
@property (nonatomic, copy) NSString *serverAddress;
/// 组织机构域，如填写，SDK则会通过org_domain从公有云服务上获取私有化服务器地址，并覆盖server_host的值
@property (nonatomic, copy) NSString *orgDomain;
@property (nonatomic, copy) NSString *appName;
@property (nonatomic, weak) UIWindow *keyWindow;
@property (nonatomic, strong) NSDictionary *ext;
@property (nonatomic, copy) NSString *preferLanguage;
@end

@protocol TMSDKProtocol <NSObject>
- (void)onSDKInitializeResult:(TMSDKResult)code msg:(NSString *)msg;
- (void)onSDKError:(TMSDKResult)code msg:(NSString *)msg;
- (void)onResetSDKState:(TMSDKResult)code msg:(NSString *)msg;
- (void)onShowLogsResult:(TMSDKResult)code msg:(NSString *)msg;
- (void)onHandleWemeetAction:(TMSDKWemeetActionType)actionType param:(NSString *)param;
- (void)onHandleSchemaResult:(TMSDKResult)code msg:(NSString *)msg;
@end

@interface TencentMeetingSDK : NSObject
+ (instancetype)instance;

- (void)initialize:(TMInitParam *)params
          delegate:(id<TMSDKProtocol>)delegate;

- (BOOL)isInitialized;

- (TMSDKResult)refreshSDKToken:(NSString *)newSDKToken;

- (NSString *)getCurrentSDKToken;

- (NSString *)getSDKVersion;

- (void)showLogs;

/**
 * 带登陆态链接入会
 */
- (void)handleSchema:(NSString *)schemaUrl;

- (TMAccountService *)getAccountService;
- (TMPreMeetingService *)getPreMeetingService;
- (TMInMeetingService *)getInMeetingService;
@end

NS_ASSUME_NONNULL_END
