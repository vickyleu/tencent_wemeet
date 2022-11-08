//
//  TMSDKErrors.h
//  TMSDK
//
//  Created by 余笃 on 2021/7/16.
//

#pragma once

typedef NS_ENUM(int64_t, TMSDKError) {
    TMSDKError_Success = 0,
    TMSDKError_ServerConfigFail = -1001,
    TMSDKError_InvalidAuthCode = -1002,
    TMSDKError_LogoutInMeeting = -1003,
    TMSDKError_LoginAborted = -1004,
    TMSDKError_Unknown = -1005,
    TMSDKError_UserNotAuthorized = -1006,
    TMSDKError_UserInMeeting = -1007,
    TMSDKError_InvalidParam = -1008,
    TMSDKError_InvalidMeetingCode = -1009,
    TMSDKError_InvalidNickname = -1010,
    TMSDKError_DuplicateInitCall = -1011,
    TMSDKError_AccountAlreadyLogin = -1012,
    TMSDKError_SdkNotInitialized = -1013,
    TMSDKError_SyncCallTimeout = -1014,
    TMSDKError_NotInMeeting = -1015,
    TMSDKError_CancelJoin = -1016,
    TMSDKError_IsLogining = -1017,
    TMSDKError_LoginNetError = -1018,
    TMSDKError_TokenVerifyFailed = -1019,
    TMSDKError_MultiAccountLoginConflict = -1021,
    TMSDKError_JoinMeetingServiceFailed = -1022,
    TMSDKError_ActionConflict = -1023,
    TMSDKError_InvalidJsonString = -1024,
    TMSDKError_ProxySetFailed = -1025,
};

typedef NS_ENUM(NSInteger, TMLoginType) {
    TMLoginTypeWeWork                     = 1,
};
