package com.example.tencent_wemeet

import android.annotation.SuppressLint
import android.app.Application
import android.content.ComponentName
import android.content.Context
import android.content.Context.BIND_AUTO_CREATE
import android.content.Context.POWER_SERVICE
import android.content.Intent
import android.content.ServiceConnection
import android.os.Build
import android.os.IBinder
import android.os.PowerManager
import android.util.Log
import com.tencent.wemeet.sdk.app.AppGlobals
import com.tencent.wemeet.tmsdk.TMErrorCode
import com.tencent.wemeet.tmsdk.TMSDK
import com.tencent.wemeet.tmsdk.callback.AuthenticationCallback
import com.tencent.wemeet.tmsdk.callback.InMeetingCallback
import com.tencent.wemeet.tmsdk.callback.PreMeetingCallback
import com.tencent.wemeet.tmsdk.callback.SDKCallback
import com.tencent.wemeet.tmsdk.data.InitParams
import com.tencent.wemeet.tmsdk.data.JoinParams
import io.flutter.plugins.DartErrorCode


class WeMeetController : SDKCallback, InMeetingCallback, PreMeetingCallback,AuthenticationCallback{
    //IWeMeetAidlToMainInterface.Stub(), ServiceConnection


    internal var isPrivacyNeedGrant: Boolean = true

    private var isLoginWeMeet = false
        set(value) {
            if (value && !field) {
                TencentWemeetPlugin.hostApi?.loginSuccess { }
            }
            field = value
        }
    private var isEnterMeeting = false

    private lateinit var mFlutterBindingContext: Context


    fun init(param: InitParams) {
        android.util.Log.e("onAttachedToActivity", "initWeMeet init::$isPrivacyNeedGrant")
        if (!isPrivacyNeedGrant) {
            TMSDK.initialize(param, this)
            android.util.Log.e("${this.javaClass}","TMSDK.initialize(param, this)")
        }
    }

    fun jumpToHistory() {
        TMSDK.getPreMeetingService().showHistoricalMeetingView()
    }


    fun uninit() {
        TMSDK.removeListener()
        TMSDK.uninitialize()
    }


    fun notifyPrivacyGranted() {
        isPrivacyNeedGrant = false
        if (::mFlutterBindingContext.isInitialized) {
            TMSDK.notifyPrivacyGranted(mFlutterBindingContext)
           /* mBinderMap.values.forEach {
                it.notifyPrivacyGranted()
            }*/
        }
//        loaded()
    }

    fun attach(application: Application) {
        mFlutterBindingContext = application
        /*TMSDK.initOnApplicationCreate(application, isPrivacyNeedGrant)
//        ignoreBatteryOptimization(application)

        val listenService = Intent(application, WeMeetAidlListenService::class.java)
        val listenWebService = Intent(application, WeMeetAidlListenWebService::class.java)
        application.bindService(
            listenService,
            this,
            BIND_AUTO_CREATE
        )
        application.bindService(
            listenWebService,
            this,
            BIND_AUTO_CREATE
        )
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            application.startForegroundService(listenService )
            application.startForegroundService(listenWebService )
        } else {
            application.startService(listenService)
            application.startService(listenWebService)
        }*/
//        application.startService(listenService)
//        application.startService(listenWebService)
    }

    /**
     * ??????????????????
     */

    public fun ignoreBatteryOptimization(context: Context) {
        val powerManager = context.getSystemService(POWER_SERVICE) as PowerManager
        val hasIgnored: Boolean
        if (android.os.Build.VERSION.SDK_INT >= android.os.Build.VERSION_CODES.M) {
            hasIgnored = powerManager.isIgnoringBatteryOptimizations(context.packageName)
            //  ????????????APP??????????????????????????????????????????????????????????????????????????????????????????????????????????????????
            if (!hasIgnored) {
               /* try {//????????????????????? ??????????????????
                    val intent = Intent(Settings.ACTION_REQUEST_IGNORE_BATTERY_OPTIMIZATIONS)
                    intent.data = Uri.parse("package:${context.packageName}")
                    context.startActivity(intent)
                } catch (e: Exception) {//???????????????????????????????????????????????????
                    e.printStackTrace()*/
                    try {
                        val intent = Intent(Intent.ACTION_MAIN)
                        intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
                        intent.addCategory(Intent.CATEGORY_LAUNCHER)
                        val cn =
                            ComponentName.unflattenFromString("com.android.settings/.Settings\$HighPowerApplicationsActivity");
                        intent.component = cn
                        context.startActivity(intent)
                    } catch (ex: Exception) {//???????????????????????????????????????????????????
                        ex.printStackTrace()
                    }
               /* }*/

            }
        }
    }


//    private val mBinderMap = hashMapOf<String, IWeMeetAidlToServiceInterface>()

//    override fun onServiceConnected(name: ComponentName?, service: IBinder?) {
//        val cName = name ?: return
//        val binder = IWeMeetAidlToServiceInterface.Stub.asInterface(service ?: return)
//        binder.launchService(this@WeMeetController, isPrivacyNeedGrant)
//        mBinderMap[cName.shortClassName] = binder
//    }
//
//    override fun onServiceDisconnected(name: ComponentName?) {
//        val cName = name ?: return
//        mBinderMap.remove(cName.shortClassName)
//    }
//
//    override fun loaded() {
//
//    }

    fun deAttach() {
        try {
            uninit()
        } catch (ignore: Exception) {
        }
        try {
            val app = AppGlobals.application
           /* app.unbindService(this)
            app.stopService(Intent(app, WeMeetAidlListenService::class.java))
            app.stopService(Intent(app, WeMeetAidlListenWebService::class.java))*/
            val callback = AppGlobals::class.java.getDeclaredField("mActivityLifecycleCallbacks")
                .get(null) as Application.ActivityLifecycleCallbacks
            app.unregisterActivityLifecycleCallbacks(callback)
        } catch (ignore: Exception) {
        }
    }

    fun login(ssoUrl: String) {
        Log.e("????????????", "$$:::$ssoUrl")
        if (!TMSDK.getAccountService().isLoggedIn()) {
            TMSDK.getAccountService().login(ssoUrl)
        } else {
            TencentWemeetPlugin.hostApi?.loginSuccess { }
        }
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

    fun showMeetingDetailView(
        meetingId: String,
        currentSubMeetingId: String,
        startTime: String,
        isHistory: Boolean
    ) {
        TMSDK.getPreMeetingService().showMeetingDetailView(meetingId, currentSubMeetingId, startTime, isHistory)
    }

    fun jumpUrlWithLoginStatus(targetUrl: String) {
        TMSDK.getAccountService().jumpUrlWithLoginStatus(targetUrl)
    }

    fun getUrlWithLoginStatus(targetUrl: String): String {
       return TMSDK.getAccountService().getUrlWithLoginStatus(targetUrl)
    }

    companion object {
        @SuppressLint("StaticFieldLeak")
        private var instance: WeMeetController? = null
            get() {
                if (field == null) {
                    field = WeMeetController()
                }
                return field
            }

        fun get(): WeMeetController {
            return instance!!
        }
    }

    // MARK: - SDKCallback
    override fun onHandleSchemaResult(code: Int, msg: String) {
    }

    override fun onHandleWemeetAction(actionType: Int, param: String) {
    }

    override fun onResetSDKState(code: Int, msg: String) {
        when (code) {
            -1019 -> {
                TencentWemeetPlugin.hostApi?.sdkTokenInvalid { }
            }
            else -> {}
        }
    }

    override fun onSDKError(code: Int, msg: String) {
        Log.wtf("????????????", "onSDKError res:${DartErrorCode.ofRaw(code)!!.name} msg:$msg")
    }

    override fun onSDKInitializeResult(code: Int, msg: String) {
        Log.wtf("????????????", "onSDKInitializeResult res:${DartErrorCode.ofRaw(code)!!.name} msg:$msg")
        if (code == TMErrorCode.SUCCESS || code == TMErrorCode.DUPLICATE_INIT_CALL) {
            Log.wtf("????????????", "onSDKInitializeResult res:${DartErrorCode.ofRaw(code)!!.name} ??????")
            TMSDK.getInMeetingService().setCallback(this)
            TMSDK.getPreMeetingService().setCallback(this)
            TMSDK.getAccountService().setCallback(this)
            TencentWemeetPlugin.hostApi?.sdkInitSuccess { }
        }
    }

    override fun onShowLogsResult(code: Int, msg: String) {
    }

    // MARK: - InMeetingCallback
    override fun onInviteMeeting(inviteInfo: String, retInfo: String) {
    }

    override fun onLeaveMeeting(type: Int, code: Int, msg: String, meetingCode: String) {
        isEnterMeeting = false
        TencentWemeetPlugin.hostApi?.onLeaveMeeting(type.toLong(), code.toLong(), msg, meetingCode, {})
    }

    override fun onShowMeetingInfo(meetingInfo: String, retInfo: String) {
    }

    override fun onSwitchPiPResult(code: Int, msg: String) {
    }

    // MARK: - PreMeetingCallback
    override fun onActionResult(actionType: Int, code: Int, msg: String) {
    }

    override fun onJoinMeeting(resultCode: Int, msg: String, meetingCode: String) {
        isEnterMeeting = true
        Log.wtf(
            "????????????",
            "onJoinMeeting res:$${DartErrorCode.ofRaw(resultCode)!!.name} mecode:$meetingCode msg:$msg"
        )
    }

    override fun onShowScreenCastResult(code: Int, msg: String) {
    }

    // MARK: - AuthenticationCallback
    override fun onJumpUrlWithLoginStatus(code: Int, msg: String?) {
    }

    override fun onLogin(code: Int, msg: String?) {
        Log.wtf("????????????", "onLogin res:${DartErrorCode.ofRaw(code)!!.name} msg:$msg")
        when (code) {
            TMErrorCode.SUCCESS -> {
                isLoginWeMeet = true
            }
            -1019 -> {
                TencentWemeetPlugin.hostApi?.sdkTokenInvalid { }
            }
            else -> {}
        }
    }

    override fun onLogout(type: Int, code: Int, msg: String?) {
        isLoginWeMeet = false
    }

    fun setPrivacyNeedGrant(isPrivacyNeedGrant: Boolean) {
        this.isPrivacyNeedGrant = isPrivacyNeedGrant
    }


}