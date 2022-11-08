package com.example.tencent_wemeet


import androidx.lifecycle.DefaultLifecycleObserver
import com.tencent.wemeet.tmsdk.data.InitParams
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugins.DartInitParams
import io.flutter.plugins.WeMeetApi

/** TencentWemeetPlugin */
class TencentWemeetPlugin : FlutterPlugin, ActivityAware, WeMeetApi {


    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        WeMeetApi.setUp(flutterPluginBinding.binaryMessenger, this)
    }
    override fun initWeMeet(param: DartInitParams) {
        WeMeetController.init(param.toKotlin())
    }

    override fun releaseWeMeet() {
        WeMeetController.deAttach()
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
            releaseWeMeet()
    }

    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        WeMeetController.attach(binding.activity.application)
    }


    override fun onDetachedFromActivity() {
        WeMeetController.deAttach()
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

