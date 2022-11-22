package com.example.tencent_wemeet

import android.app.ActivityManager
import android.app.Application
import android.content.Context

internal fun Application.getProcessName(): String? {
    val am = getSystemService(Context.ACTIVITY_SERVICE) as ActivityManager
    return am.runningAppProcesses
        ?.find { it.pid == android.os.Process.myPid() }
        ?.processName
}