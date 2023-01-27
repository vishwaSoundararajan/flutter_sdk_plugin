package com.example.fluttersdkplugin_example
import android.app.Application
import io.mob.resu.reandroidsdk.ReAndroidSDK
import io.mob.resu.reandroidsdk.AppConstants
class ProjectApplication:Application() {
    override fun onCreate() {
        super.onCreate()
        ReAndroidSDK.getInstance(this);
        AppConstants.LogFlag=true;
    }
}
