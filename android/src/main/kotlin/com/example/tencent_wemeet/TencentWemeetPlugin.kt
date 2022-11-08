package com.example.tencent_wemeet


import androidx.lifecycle.DefaultLifecycleObserver
import com.tencent.wemeet.tmsdk.data.InitParams
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugins.DartInitParams
import io.flutter.plugins.WeMeetApi

/** TencentWemeetPlugin */
class TencentWemeetPlugin : FlutterPlugin, ActivityAware, DefaultLifecycleObserver {

    private lateinit var flutterApi: MyApi

    private class MyApi : WeMeetApi {
        override fun init(param: DartInitParams) {

            WeMeetController.init(param)
        }

        override fun release() {

        }
    }

    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        flutterApi = MyApi()
        WeMeetApi.setUp(flutterPluginBinding.binaryMessenger, flutterApi)
    }


    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        if (::flutterApi.isInitialized) {
            flutterApi.release()
        }
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
        .setPrivateParams(serverDomain)
        .setSaasParams(sdkId, sdkToken)
        .build()
}

