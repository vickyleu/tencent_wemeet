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
    func releaseWeMeet() {
        WeMeetController.instance.deAttach()
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



