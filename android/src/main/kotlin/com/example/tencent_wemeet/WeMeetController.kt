package com.example.tencent_wemeet

import android.app.Application
import com.tencent.wemeet.sdk.app.AppGlobals
import com.tencent.wemeet.tmsdk.TMErrorCode
import com.tencent.wemeet.tmsdk.TMSDK
import com.tencent.wemeet.tmsdk.callback.InMeetingCallback
import com.tencent.wemeet.tmsdk.callback.PreMeetingCallback
import com.tencent.wemeet.tmsdk.callback.SDKCallback
import com.tencent.wemeet.tmsdk.data.InitParams
import com.tencent.wemeet.tmsdk.data.JoinParams

class WeMeetController : SDKCallback, InMeetingCallback, PreMeetingCallback {

    private var isLoginWeMeet = false
    private var isEnterMeeting = false


    fun init(param: InitParams) {
        TMSDK.initialize(param, this)
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

    fun login(ssoUrl: String) {
        TMSDK.getAccountService().login(ssoUrl)
    }

    fun join(joinParam: JoinParams) {
        TMSDK.getPreMeetingService().joinMeeting(joinParam)
    }

    fun leave() {
        TMSDK.getInMeetingService().leaveMeeting(true)
    }

    fun logout() {
        TMSDK.getAccountService().logout()
    }

    fun isInitialized(): Boolean {
        return TMSDK.isInitialized()
    }

    fun isLoggedIn(): Boolean {
        return TMSDK.getAccountService().isLoggedIn()
    }

    fun refreshSDKToken(newSdkToken: String): Long {
        return TMSDK.refreshSDKToken(newSdkToken).toLong()
    }

    companion object {
        private var instance: WeMeetController? = null
            get() {
                if (field == null) {
                    field = WeMeetController()
                }
                return field
            }
        fun get(): WeMeetController{
            //细心的小伙伴肯定发现了，这里不用getInstance作为为方法名，是因为在伴生对象声明时，内部已有getInstance方法，所以只能取其他名字
            return instance!!
        }
    }

    override fun onHandleSchemaResult(code: Int, msg: String) {

    }

    override fun onHandleWemeetAction(actionType: Int, param: String) {

    }

    override fun onResetSDKState(code: Int, msg: String) {

    }

    override fun onSDKError(code: Int, msg: String) {

    }

    override fun onSDKInitializeResult(code: Int, msg: String) {
        if(code== TMErrorCode.SUCCESS){
            TMSDK.getInMeetingService().setCallback(this)
            TMSDK.getPreMeetingService().setCallback(this)
        }
    }

    override fun onShowLogsResult(code: Int, msg: String) {

    }

    override fun onInviteMeeting(inviteInfo: String, retInfo: String) {
        TODO("Not yet implemented")
    }

    override fun onLeaveMeeting(type: Int, code: Int, msg: String, meetingCode: String) {
        TODO("Not yet implemented")
    }

    override fun onShowMeetingInfo(meetingInfo: String, retInfo: String) {
        TODO("Not yet implemented")
    }

    override fun onSwitchPiPResult(code: Int, msg: String) {
        TODO("Not yet implemented")
    }

    override fun onActionResult(actionType: Int, code: Int, msg: String) {
        TODO("Not yet implemented")
    }

    override fun onJoinMeeting(resultCode: Int, msg: String, meetingCode: String) {
        TODO("Not yet implemented")
    }

    override fun onShowScreenCastResult(code: Int, msg: String) {
        TODO("Not yet implemented")
    }

}