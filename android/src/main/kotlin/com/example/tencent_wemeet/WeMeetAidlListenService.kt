package com.example.tencent_wemeet

import android.app.Service
import android.content.Intent
import android.os.IBinder
import com.tencent.wemeet.tmsdk.TMSDK


class WeMeetAidlListenService : Service() {
    private var impl: IWeMeetAidlToMainInterface? = null

    private var isPrivacyNeedGrant = true
    private val mBinder = object : IWeMeetAidlToServiceInterface.Stub() {
        override fun launchService(impl: IWeMeetAidlToMainInterface?, isPrivacyNeedGrant: Boolean) {
            this@WeMeetAidlListenService.impl = impl
            this@WeMeetAidlListenService.isPrivacyNeedGrant = isPrivacyNeedGrant
        }

        override fun notifyPrivacyGranted() {
            TMSDK.notifyPrivacyGranted(this@WeMeetAidlListenService)
        }

        override fun destory() {
            this@WeMeetAidlListenService.impl = null
        }
    }

    override fun onBind(intent: Intent?): IBinder {
        return mBinder
    }


    override fun onCreate() {
        super.onCreate()
        TMSDK.initOnApplicationCreate(application, isPrivacyNeedGrant)
        impl?.loaded()
    }
}