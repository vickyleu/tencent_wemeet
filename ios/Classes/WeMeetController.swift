//
//  WeMeetController.swift
//  tencent_wemeet
//
//  Created by vicky Leu on 2022/11/8.
//

import Foundation
import TencentMeetingSDK
class WeMeetController: NSObject,TMSDKProtocol, TMPreMeetingProtocol,TMInMeetingProtocol,TMAuthenticationProtocol{
    
    private var isLoginWeMeet = false
    
    func attach(_ param:TMInitParam){
        TencentMeetingSDK.instance().initialize(param, delegate: self)
        TencentMeetingSDK.instance().getInMeetingService().enableInviteCallback(true, show: true)
        TencentMeetingSDK.instance().getInMeetingService().enableMeetingInfoCallback(true, show: true)
    }
    
    
    func deAttach(){
        uninit()
    }
    func uninit() {
        //        TencentMeetingSDK.instance().deinit()
    }
    
    
    func login(_ ssoUrl:String) {
        TencentMeetingSDK.instance().getAccountService().setDelegate(self)
        TencentMeetingSDK.instance().getAccountService().login(ssoUrl, forceKickOtherDevice: true)
    }
    
    func join(_ joinParam: TMJoinParam) {
        TencentMeetingSDK.instance().getPreMeetingService().joinMeeting(joinParam)
    }
    
    func leave() {
        TencentMeetingSDK.instance().getInMeetingService().leaveMeeting(true)
    }
    
    func logout() {
        TencentMeetingSDK.instance().getAccountService().logout()
    }
    
    func isInitialized() -> Bool {
        TencentMeetingSDK.instance().isInitialized()
    }
    
    func refreshSDKToken(_ newSdkToken: String) -> Int {
        return TencentMeetingSDK.instance().refreshSDKToken(newSdkToken).rawValue
    }
    
    func isLoggedIn() -> Bool {
        return TencentMeetingSDK.instance().getAccountService().isLoggedIn()
    }

    func showMeetingDetailView(meetingId: String, currentSubMeetingId: String, startTime: String, isHistory: Bool) {
        TencentMeetingSDK.instance().getPreMeetingService().showMeetingDetailView(meetingId, currentSubMeetingId: currentSubMeetingId, beginTime: startTime, isHistory: isHistory)
    }

    func jumpUrlWithLoginStatus(targetUrl: String) {
        TencentMeetingSDK.instance().getAccountService().jumpUrl(withLoginStatus: targetUrl)
    }

    func getUrlWithLoginStatus(targetUrl: String) -> String {
        TencentMeetingSDK.instance().getAccountService().getUrlWithLoginStatus(targetUrl)
    }

    // MARK: - TMAuthenticationProtocol
    func onLogin(_ code: TMSDKResult, msg: String) {
        switch code {
        case .errorSuccess:
            isLoginWeMeet=true
            debugPrint("登录成功!")
        case .errorTokenVerifyFailed:
            SwiftTencentWemeetPlugin.hostApi?.sdkTokenInvalid(completion: {
                
            })
        default:
            return
        }
    }

    func onLogout(_ type: TMLogoutType, code: TMSDKResult, msg: String) {
        isLoginWeMeet=false
        debugPrint("退出登录成功!")
    }

    func onJumpUrl(withLoginStatus code: TMSDKResult, msg: String) {

    }


    // MARK: - TMPreMeetingProtocol
    func onJoinMeeting(_ code: TMSDKResult, msg: String, meetingCode: String) {
    }
    
    func onShowScreenCastViewResult(_ code: TMSDKResult, msg: String) {
       
    }
    
    func onActionResult(_ actionType: TMSDKActionType, code: TMSDKResult, msg: String) {
      
    }
    // MARK: - TMInMeetingProtocol
    func onLeaveMeeting(_ type: TMLeaveType, code: TMSDKResult, msg: String, meetingCode: String) {
        SwiftTencentWemeetPlugin.hostApi?.onLeaveMeeting(type: Int32(type.rawValue), code: Int32(code.rawValue), msg: msg, meetingCode: meetingCode, completion: {
            
        })
    }
    
    func onInviteMeeting(_ invite_info: String) {
       
    }
    
    func onShowMeetingInfo(_ meeting_info: String) {
       
    }
    
    func onSwitchPiPResult(_ code: TMSDKResult, msg: String) {
       
    }


    // MARK: - TMSDKProtocol
    func onSDKInitializeResult(_ code: TMSDKResult, msg: String) {
        if code == .errorSuccess{
            TencentMeetingSDK.instance().getInMeetingService().setDelegate(self)
            TencentMeetingSDK.instance().getPreMeetingService().setDelegate(self)
        }
    }

    func onSDKError(_ code: TMSDKResult, msg: String) {
    }

    func onResetSDKState(_ code: TMSDKResult, msg: String) {
        switch code {
        case .errorTokenVerifyFailed:
            SwiftTencentWemeetPlugin.hostApi?.sdkTokenInvalid(completion: {
                
            })
        default:
            return
        }
    }

    func onShowLogsResult(_ code: TMSDKResult, msg: String) {
    }

    func onHandle(_ actionType: TMSDKWemeetActionType, param: String) {
    }

    func onHandleSchemaResult(_ code: TMSDKResult, msg: String) {
    }





    private static var uniqueInstance: WeMeetController?

    public static var instance: WeMeetController {
        if WeMeetController.uniqueInstance == nil {
            WeMeetController.uniqueInstance = self.init()
        }
        return WeMeetController.uniqueInstance!
    }

    required override init() {}

}
