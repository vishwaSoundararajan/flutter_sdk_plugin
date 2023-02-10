package com.example.fluttersdkplugin_example
import android.content.Context
import android.content.ContextWrapper
import android.content.Intent
import android.os.*
import com.example.fluttersdkplugin.FluttersdkpluginPlugin
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodChannel
import kotlinx.coroutines.delay


class MainActivity: FlutterActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        FluttersdkpluginPlugin().initResdk(this)
    }

//    val channel = EventChannel(getFlutterView(), "your_channel_name")
//    private var BATTERY_CHANNEL= "fluttersdk/battery";
//    private lateinit var channel:MethodChannel
//    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
//        super.configureFlutterEngine(flutterEngine)
//
//        channel=MethodChannel(flutterEngine.dartExecutor.binaryMessenger,BATTERY_CHANNEL)
//    }
//
//    override fun onCreate(savedInstanceState: Bundle?, persistentState: PersistableBundle?) {
//        super.onCreate(savedInstanceState, persistentState)
//                val batteryLevel=getBatteryLevel()
//                channel.invokeMethod("reportBatteryLevel",batteryLevel)
//
//
//    }
//    private fun getBatteryLevel():Int{
//        val batteryLevel: Int
//        if(Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP){
//            val batteryManager=getSystemService(Context.BATTERY_SERVICE) as BatteryManager
//            batteryLevel=batteryManager.getIntProperty(BatteryManager.BATTERY_PROPERTY_CAPACITY)
//        }else
//        {
//            batteryLevel=intent!!.getIntExtra(BatteryManager.EXTRA_LEVEL,-1)*1
//        }
//        return batteryLevel
//    }

}
