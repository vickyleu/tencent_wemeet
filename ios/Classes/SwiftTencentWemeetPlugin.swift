import Flutter
import UIKit
import TencentMeetingSDK
public class SwiftTencentWemeetPlugin: NSObject, FlutterPlugin, WeMeetApi {
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        let instance = SwiftTencentWemeetPlugin()
        WeMeetApiSetup.setUp(binaryMessenger: registrar.messenger(), api: instance)
    }

    func initWeMeet(param: DartInitParams) {
        WeMeetController.instance.attach( toSwift(param))
    }

    func loginWeMeet(ssoUrl: String) {
        WeMeetController.instance.login(ssoUrl)
    }

    func joinMeeting(joinParam: DartTMJoinParam) {
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

}

func toSwift(_ p:DartInitParams)->TMInitParam {
    let param = TMInitParam()
    param.preferLanguage = p.preferLanguage
    param.sdkId = p.sdkId
    param.sdkToken = p.sdkToken
    param.serverAddress = p.serverAddress
    param.orgDomain = p.serverDomain

    return param
}
func toSwift(_ p:DartTMJoinParam)->TMJoinParam {
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



