//
//  WeMeetController.swift
//  tencent_wemeet
//
//  Created by vicky Leu on 2022/11/8.
//

import Foundation
import TencentMeetingSDK
class WeMeetController{
    private static var uniqueInstance: WeMeetController?

    public static var instance: WeMeetController {
        if WeMeetController.uniqueInstance == nil {
            WeMeetController.uniqueInstance = self.init()
        }
        return WeMeetController.uniqueInstance!
    }

    required init() {}


    func attach(_ param:TMInitParam){
        TencentMeetingSDK.instance().initialize(param, delegate: TencentMeetingSDK.TMSDKProtocol{

        })
    }
    func deAttach(){
        uninit()
    }
    func uninit() {
//        TencentMeetingSDK.instance().deinit()
    }
}
