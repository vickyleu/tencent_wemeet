package com.example.tencent_wemeet


import androidx.lifecycle.DefaultLifecycleObserver
import com.tencent.wemeet.tmsdk.data.InitParams
import com.tencent.wemeet.tmsdk.data.JoinParams
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugins.DartInitParams
import io.flutter.plugins.DartTMJoinParam
import io.flutter.plugins.WeMeetApi

/** TencentWemeetPlugin */
class TencentWemeetPlugin : FlutterPlugin, ActivityAware, WeMeetApi {


    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        WeMeetApi.setUp(flutterPluginBinding.binaryMessenger, this)
    }
    override fun initWeMeet(param: DartInitParams) {
        WeMeetController.get().init(param.toKotlin())
    }

    override fun isInitialized(): Boolean {
        return  WeMeetController.get().isInitialized()
    }

    override fun loginWeMeet(ssoUrl: String) {
        WeMeetController.get().login(ssoUrl)
    }

    override fun isLoggedIn(): Boolean {
        return WeMeetController.get().isLoggedIn()
    }

    override fun joinMeeting(joinParam: DartTMJoinParam) {
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

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
            releaseWeMeet()
    }

    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        WeMeetController.get().attach(binding.activity.application)
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
    return InitParams.Builder()
        .setPreferLanguage(preferLanguage)
        .setPrivateParams(serverAddress,serverDomain)
        .setSaasParams(sdkId, sdkToken)
        .build()
}


private fun DartTMJoinParam.toKotlin(): JoinParams {
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

