//package com.example.tencent_wemeet
//
//import android.app.Notification
//import android.app.NotificationChannel
//import android.app.NotificationManager
//import android.app.Service
//import android.content.Context
//import android.content.Intent
//import android.os.Build
//import android.os.IBinder
//import com.tencent.wemeet.tmsdk.TMSDK
//
//class WeMeetAidlListenWebService:Service() {
//    private var impl:IWeMeetAidlToMainInterface?=null
//
//    private var isPrivacyNeedGrant = true
//    private val mBinder = object :IWeMeetAidlToServiceInterface.Stub(){
//        override fun launchService(impl: IWeMeetAidlToMainInterface?,isPrivacyNeedGrant: Boolean) {
//            this@WeMeetAidlListenWebService.impl=impl
//            this@WeMeetAidlListenWebService.isPrivacyNeedGrant=isPrivacyNeedGrant
//        }
//
//        override fun notifyPrivacyGranted() {
//            TMSDK.notifyPrivacyGranted(this@WeMeetAidlListenWebService)
//        }
//
//        override fun destory() {
//            this@WeMeetAidlListenWebService.impl=null
//        }
//    }
//    override fun onBind(intent: Intent?): IBinder {
//        return mBinder
//    }
//
//
//
//    override fun onCreate() {
//        super.onCreate()
//        TMSDK.initOnApplicationCreate(application,isPrivacyNeedGrant)
//        impl?.loaded()
//        if (Build.VERSION.SDK_INT >= 26) {
//            val CHANNEL_ID = "my_channel_02"
//            val channel = NotificationChannel(
//                CHANNEL_ID,
//                "Channel human readable title",
//                NotificationManager.IMPORTANCE_DEFAULT
//            )
//            (getSystemService(Context.NOTIFICATION_SERVICE) as NotificationManager).createNotificationChannel(
//                channel
//            )
//            val notification: Notification = Notification.Builder(this, CHANNEL_ID)
//                .setContentTitle("")
//                .setContentText("").build()
//            startForeground(1, notification)
//        }
//    }
//}