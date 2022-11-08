package com.example.tencent_wemeet


import android.app.Application
import com.tencent.wemeet.tmsdk.data.InitParams
import com.tencent.wemeet.tmsdk.data.JoinParams
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugins.DartInitParams
import io.flutter.plugins.DartJoinParam
import io.flutter.plugins.WeMeetAndroidGrantedHostApi
import io.flutter.plugins.WeMeetApi
import io.flutter.plugins.WeMeetHostApi

/** TencentWemeetPlugin */
class TencentWemeetPlugin : FlutterPlugin, ActivityAware, WeMeetApi { //,IWeMeetAidlToMainInterface

    companion object {
        var hostApi: WeMeetHostApi? = null
    }


    lateinit var grantedHostApi: WeMeetAndroidGrantedHostApi


    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        val app = flutterPluginBinding.applicationContext as Application
        val pName = app.getProcessName()
        if (pName == app.packageName) {
            android.util.Log.e(
                "onAttachedToActivity",
                "onAttachedToEngine attach:${app.getProcessName()}"
            )
            grantedHostApi = WeMeetAndroidGrantedHostApi(flutterPluginBinding.binaryMessenger)
            WeMeetApi.setUp(flutterPluginBinding.binaryMessenger, this)
            hostApi = WeMeetHostApi(flutterPluginBinding.binaryMessenger)
        }
    }

    override fun initWeMeet(param: DartInitParams) {
        android.util.Log.e("onAttachedToActivity", " attach:initWeMeet")
        if (::grantedHostApi.isInitialized) {
            grantedHostApi.initPrivacyNeedGrant {
                val newV = it ?: false
                val old = WeMeetController.get().isPrivacyNeedGrant
                WeMeetController.get().setPrivacyNeedGrant(newV)
                if (!newV && old) {
                    // 变更隐私合规参数了
                    android.util.Log.e("onAttachedToActivity", " attach:notifyPrivacyGranted")
                    notifyPrivacyGranted()
                }
                android.util.Log.e("onAttachedToActivity", "setPrivacyNeedGrant attach:")
                WeMeetController.get().init(param.toKotlin())
            }
        }
    }

    override fun jumpToHistory() {
        WeMeetController.get().jumpToHistory()
    }

    override fun isInitialized(): Boolean {
        return WeMeetController.get().isInitialized()
    }

    override fun loginWeMeet(ssoUrl: String) {
        WeMeetController.get().login(ssoUrl)
    }

    override fun isLoggedIn(): Boolean {
        return WeMeetController.get().isLoggedIn()
    }

    override fun joinMeeting(joinParam: DartJoinParam) {
        WeMeetController.get().join(joinParam.toKotlin())
    }

    override fun leaveMeeting() {
        WeMeetController.get().leave()
    }

    override fun releaseWeMeet() {
        WeMeetController.get().deAttach()
    }

    override fun logout() {
        WeMeetController.get().logout()
    }

    override fun refreshSDKToken(newSdkToken: String): Long {
        return WeMeetController.get().refreshSDKToken(newSdkToken)
    }

    override fun showMeetingDetailView(
        meetingId: String,
        currentSubMeetingId: String,
        startTime: String,
        isHistory: Boolean
    ) {
        WeMeetController.get()
            .showMeetingDetailView(meetingId, currentSubMeetingId, startTime, isHistory)
    }

    override fun jumpUrlWithLoginStatus(targetUrl: String) {
        WeMeetController.get().jumpUrlWithLoginStatus(targetUrl)
    }

    override fun getUrlWithLoginStatus(targetUrl: String): String {
        return WeMeetController.get().getUrlWithLoginStatus(targetUrl)
    }

    override fun getCurrentSDKToken(): String {
        return WeMeetController.get().getCurrentSDKToken()
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        releaseWeMeet()
    }

    override fun notifyPrivacyGranted() {
        WeMeetController.get().notifyPrivacyGranted()
    }

    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        val pName = binding.activity.application.getProcessName()
        if (pName == binding.activity.application.packageName) {
            android.util.Log.e(
                "onAttachedToActivity",
                "onAttachedToActivity attach:${binding.activity.application.getProcessName()}"
            )
            WeMeetController.get().attach(binding.activity.application)
        }
    }


    override fun onDetachedFromActivity() {
        WeMeetController.get().deAttach()
    }

    override fun onDetachedFromActivityForConfigChanges() {
        onDetachedFromActivity()
    }

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
        onAttachedToActivity(binding)
    }


}

private fun DartInitParams.toKotlin(): InitParams {
    val builder = InitParams.Builder()
    if (preferLanguage != null) {
        builder.setPreferLanguage(preferLanguage)
    }
    if (serverAddress != null && serverDomain != null) {
        builder.setPrivateParams(serverAddress, serverDomain)
    }
    return builder.setSaasParams(sdkId, sdkToken).build()
}


private fun DartJoinParam.toKotlin(): JoinParams {
    return JoinParams.Builder(meetingCode)
        .setCameraOn(cameraOn)
        .setInviteUrl(inviteUrl)
        .setUserDisplayName(userDisplayName)
        .setPassword(password)
        .setMicOn(micOn)
        .setFaceBeautyOn(faceBeautyOn)
        .setSpeakerOn(speakerOn)
        .build()
}

