//
//  TencentMeetingSDKDefine.h
//  TencentMeetingSDK
//
//  Created by zzjf on 2021/7/27.
//

#ifndef TencentMeetingSDKDefine_h
#define TencentMeetingSDKDefine_h


typedef NS_ENUM(NSInteger, TMSDKResult) {
    kTMSDKErrorSuccess = 0,
    kTMSDKErrorServerConfigFail = -1001,
    kTMSDKErrorInvalidAuthCode = -1002,
    kTMSDKErrorLogoutInMeeting = -1003,
    kTMSDKErrorLoginAborted = -1004,
    kTMSDKErrorUnknown = -1005,
    kTMSDKErrorUserNotAuthorized = -1006,
    kTMSDKErrorUserInMeeting = -1007,
    kTMSDKErrorInvalidParam = -1008,
    kTMSDKErrorInvalidMeetingCode = -1009,
    kTMSDKErrorInvalidNickname = -1010,
    kTMSDKErrorDuplicateInitCall = -1011,
    kTMSDKErrorAccountAlreadyLogin = -1012,
    kTMSDKErrorSdkNotInitialized = -1013,
    kTMSDKErrorSyncCallTimeout = -1014,
    kTMSDKErrorNotInMeeting = -1015,
    kTMSDKErrorCancelJoin = -1016,
    kTMSDKErrorIsLogining = -1017,
    kTMSDKErrorLoginNetError = -1018,
    kTMSDKErrorTokenVerifyFailed = -1019,
    kTMSDKErrorMultiAccountLoginConflict = -1021,
    kTMSDKErrorJoinMeetingServiceFailed = -1022,
    kTMSDKErrorActionConflict = -1023,
    kTMSDKErrorInvalidJsonString = -1024,
    kTMSDKErrorProxySetFailed  = -1025,
    kTMSDKErrorInvalidSchemaString = -1026
};

typedef NS_ENUM(NSInteger, TMSDKActionType) {
    kTMSDKActionTypeShowPreMeetingView,
    kTMSDKActionTypeShowScreenCastView,
    kTMSDKActionTypeShowHistoricalMeetingView,
    kTMSDKActionTypeShowMeetingDetailView,
    kTMSDKActionTypeShowJoinMeetingView,
    kTMSDKActionTypeShowScheduleMeetingView,
    kTMSDKActionTypeShowMeetingSettingView,
    kTMSDKActionTypeClosePreMeetingView = 100,
    kTMSDKActionTypeQueryMeetingInfo,
    kTMSDKActionTypeInviteUsers,
};

typedef NS_ENUM(NSInteger, TMSDKMeetingState) {
    kTMSDKMeetingStateUnknown = -1,  //begin_time-now > 1 hour
    kTMSDKMeetingStateNotStarted = 0,  // Before begin time
    kTMSDKMeetingStateCancel = 1,      // User canceled
    kTMSDKMeetingStateStarted = 2,     // Anyone in the meeting
    kTMSDKMeetingStateDeleted = 3,         // Meeting is deleted
    kTMSDKMeetingStateNone = 6, // // After end time and nobody in the meeting
    kTMSDKMeetingStateRecycled = 7, // Meeting expired
};

typedef NS_ENUM(NSInteger, TMSDKWemeetActionType) {
    kTMSDKWemeetActionTypeChooseInviteUser
};

typedef NS_ENUM (NSInteger, TMSDKMainUIStyle) {
  kTMSDKMainUIStyleClassic,
  kTMSDKMainUIStyleTabs
};


#endif /* TencentMeetingSDKDefine_h */
