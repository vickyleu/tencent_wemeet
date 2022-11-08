//
//  WeMeetController.swift
//  tencent_wemeet
//
//  Created by vicky Leu on 2022/11/8.
//

import Foundation
import TencentMeetingSDK
class WeMeetController: NSObject,TMSDKProtocol, TMPreMeetingProtocol,TMInMeetingProtocol,TMAuthenticationProtocol{
    func onAddUsersResult(_ userType: TMSDKInviteType, code: TMSDKResult, msg: String) {

    }

    func onParseMeetingInfoUrlCode(_ code: Int, param: String) {

    }

    func onShowAddressBook(_ userType: TMSDKInviteType, users: String) {

    }

    func onSetProxyInfoResult(_ code: TMSDKResult, msg: String) {

    }
    
    
    private var isLoginWeMeet = false
    
    func attach(_ param:TMInitParam){
//        if #available(iOS 13.0, *) {
//            param.keyWindow = UIApplication.shared.connectedScenes
//                .filter { $0.activationState == .foregroundActive }
//                .compactMap { $0 as? UIWindowScene }.first?.windows
//                .filter { $0.isKeyWindow }.first
//        } else {
//            param.keyWindow = UIApplication.shared.keyWindow
//        }
        TencentMeetingSDK.instance().initialize(param, delegate: self)
        TencentMeetingSDK.instance().getInMeetingService().enableInviteCallback(true, show: true)
        TencentMeetingSDK.instance().getInMeetingService().enableMeetingInfoCallback(true, show: true)
//        TencentMeetingSDK.instance().showLogs()
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

    func getCurrentSDKToken() -> String {
        TencentMeetingSDK.instance().getCurrentSDKToken()
    }


    // MARK: - TMAuthenticationProtocol
    func onLogin(_ code: TMSDKResult, msg: String) {
        switch code {
        case .errorSuccess:
            isLoginWeMeet=true
            debugPrint("登录成功!")
            SwiftTencentWemeetPlugin.hostApi?.loginSuccess {

            }
        case .errorTokenVerifyFailed:
            SwiftTencentWemeetPlugin.hostApi?.sdkTokenInvalid(completion: {

            })
        case .errorIsLogining:
            debugPrint("正在登录，重复登录")
        default:
            SwiftTencentWemeetPlugin.hostApi?.loginFailed(code: Int32(code.rawValue), msg: msg, completion: {

            })
            return
        }
    }

    func onLogout(_ type: TMLogoutType, code: TMSDKResult, msg: String) {
        isLoginWeMeet=false
        debugPrint("腾讯会议退出登录成功!")
    }

    func onJumpUrl(withLoginStatus code: TMSDKResult, msg: String) {

    }


    // MARK: - TMPreMeetingProtocol
    func onJoinMeeting(_ code: TMSDKResult, msg: String, meetingCode: String) {
        debugPrint("入会回调：code = \(code), msg = \(msg), meetingCode = \(meetingCode)")
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
            SwiftTencentWemeetPlugin.hostApi?.sdkInitSuccess {

            }
        } else {
            SwiftTencentWemeetPlugin.hostApi?.sdkInitFailed {

            }
        }
    }

    func onSDKError(_ code: TMSDKResult, msg: String) {
        debugPrint("onSDKError: code = \(code), msg = \(msg)")
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
