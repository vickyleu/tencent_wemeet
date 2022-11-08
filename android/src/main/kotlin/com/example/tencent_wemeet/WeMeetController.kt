package com.example.tencent_wemeet

import android.app.Application
import com.tencent.wemeet.sdk.app.AppGlobals
import com.tencent.wemeet.tmsdk.TMSDK
import com.tencent.wemeet.tmsdk.callback.SDKCallback
import com.tencent.wemeet.tmsdk.data.InitParams

object WeMeetController {

    fun init(param: InitParams) {
        TMSDK.initialize(param, object : SDKCallback {
            override fun onHandleSchemaResult(code: Int, msg: String) {

            }

            override fun onHandleWemeetAction(actionType: Int, param: String) {

            }

            override fun onResetSDKState(code: Int, msg: String) {

            }

            override fun onSDKError(code: Int, msg: String) {
            }

            override fun onSDKInitializeResult(code: Int, msg: String) {
            }

            override fun onShowLogsResult(code: Int, msg: String) {
            }
        })
    }

    fun uninit() {
        TMSDK.removeListener()
        TMSDK.uninitialize()
    }


    fun attach(application: Application) {
        TMSDK.initOnApplicationCreate(application)
    }

    fun deAttach() {
        try {
            uninit()
        } catch (ignore: Exception) {
        }
        try {
            val app = AppGlobals.application
            val callback = AppGlobals::class.java.getDeclaredField("mActivityLifecycleCallbacks")
                .get(null) as Application.ActivityLifecycleCallbacks
            app.unregisterActivityLifecycleCallbacks(callback)
        } catch (ignore: Exception) {
        }
    }


}