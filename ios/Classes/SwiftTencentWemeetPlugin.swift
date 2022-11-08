import Flutter
import UIKit
import TencentMeetingSDK
public class SwiftTencentWemeetPlugin: NSObject, FlutterPlugin, WeMeetApi {
    
    func jumpToHistory() {
        
    }
    
    func notifyPrivacyGranted() {
     //only for android
    }
    
    static var hostApi: WeMeetHostApi?
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        print("SwiftTencentWemeetPlugin  register")
        let instance = SwiftTencentWemeetPlugin()
        WeMeetApiSetup.setUp(binaryMessenger: registrar.messenger(), api: instance)
        hostApi = WeMeetHostApi.init(binaryMessenger: registrar.messenger())
    }

    func initWeMeet(param: DartInitParams) {
        print("SwiftTencentWemeetPlugin  initWeMeet")
        WeMeetController.instance.attach( toSwift(param))
    }

    func loginWeMeet(ssoUrl: String) {
        print("SwiftTencentWemeetPlugin  loginWeMeet ssoUrl")
        WeMeetController.instance.login(ssoUrl)
    }

    func joinMeeting(joinParam: DartJoinParam) {
        WeMeetController.instance.join(toSwift(joinParam))
    }

    func leaveMeeting() {
        WeMeetController.instance.leave()
    }

    func releaseWeMeet() {
        WeMeetController.instance.deAttach()
    }

    func logout() {
        WeMeetController.instance.logout()
    }
    
    func isInitialized() -> Bool {
        WeMeetController.instance.isInitialized()
    }
    
    func refreshSDKToken(newSdkToken: String) -> Int32 {
        return Int32(WeMeetController.instance.refreshSDKToken(newSdkToken))
    }
    
    func isLoggedIn() -> Bool {
        return WeMeetController.instance.isLoggedIn()
    }
    
    func showMeetingDetailView(meetingId: String, currentSubMeetingId: String, startTime: String, isHistory: Bool) {
        WeMeetController.instance.showMeetingDetailView(meetingId: meetingId, currentSubMeetingId: currentSubMeetingId, startTime: startTime, isHistory: isHistory)
    }
    
    func jumpUrlWithLoginStatus(targetUrl: String) {
        WeMeetController.instance.jumpUrlWithLoginStatus(targetUrl: targetUrl)
    }
    
    func getUrlWithLoginStatus(targetUrl: String) -> String {
        WeMeetController.instance.getUrlWithLoginStatus(targetUrl: targetUrl)
    }
    
    func getCurrentSDKToken() -> String {
       return WeMeetController.instance.getCurrentSDKToken()
    }
}

func toSwift(_ p:DartInitParams)->TMInitParam {
    let param = TMInitParam()
    param.preferLanguage = p.preferLanguage ?? "zh-cn"
    param.sdkId = p.sdkId
    param.sdkToken = p.sdkToken
    param.serverAddress = p.serverAddress ?? ""
    param.orgDomain = p.serverDomain ?? ""

    return param
}
func toSwift(_ p:DartJoinParam)->TMJoinParam {
    let joinParam = TMJoinParam()
    joinParam.meetingCode = p.meetingCode
    joinParam.userDisplayName = p.userDisplayName
    joinParam.password = p.password
    joinParam.inviteUrl = p.inviteUrl
    joinParam.cameraOn = p.cameraOn
    joinParam.micOn = p.micOn
    joinParam.speakerOn = p.speakerOn
    joinParam.faceBeautyOn = p.faceBeautyOn
    return joinParam
}



