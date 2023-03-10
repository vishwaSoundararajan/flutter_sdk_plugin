package com.example.fluttersdkplugin
//import io.flutter.plugin.common.EventChannel.StreamHandler
import android.R.id.message
import android.app.Activity
import android.content.Context
import android.os.*
import androidx.annotation.NonNull
import com.google.firebase.messaging.RemoteMessage
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.mob.resu.reandroidsdk.AppConstants
import io.mob.resu.reandroidsdk.MRegisterUser
import io.mob.resu.reandroidsdk.ReAndroidSDK
import org.json.JSONObject
import android.os.Bundle
import android.util.Log


//import kotlin.random.Random


/** FluttersdkpluginPlugin */
class FluttersdkpluginPlugin: FlutterPlugin,MethodCallHandler {


  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private lateinit var channel : MethodChannel
  private lateinit var context: Context
  private lateinit var activity: Activity
 private lateinit var eventChannel: EventChannel
 private lateinit var mycontext:Context

  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "fluttersdkplugin")
    channel.setMethodCallHandler(this)
    context = flutterPluginBinding.getApplicationContext()

    //eventChannel= EventChannel(flutterPluginBinding.binaryMessenger,"example.com/channel")

//    val handler = Handler(Looper.getMainLooper())
//    handler.post {
//      MethodChannel(
//        flutterPluginBinding.binaryMessenger,
//        "flutter/test/platformchannels"
//      ).invokeMethod("androidMethodName", "hello all")
//    }
  }

    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: MethodChannel.Result) {
    if (call.method == "getPlatformVersion") {
      result.success("Android ${android.os.Build.VERSION.RELEASE}")
    }

    else if(call.method == "pushLocation") {
      var lat:Double? = call.argument("lat")
      var lang:Double? = call.argument("lang")
      if (lat != null) {
        if (lang != null) {
          ReAndroidSDK.getInstance(context).onLocationUpdate(lat,lang)
          }
       }
    }
    else if(call.method == "addNewNotification") {
      var title:String? = call.argument("title")
      var body:String? = call.argument("body")
      if (title != null) {
        if (body != null) {
          ReAndroidSDK.getInstance(context).addNewNotification(title,body,"MainActivity")

        }
      }
    }
    else if(call.method == "onTrackEvent") {
      var content:String? = call.argument("string")
      if (content != null) {
        ReAndroidSDK.getInstance(context).onTrackEvent(content)
      }
    }
    else if(call.method == "deleteNotificationByCampaignId") {
      var cid:String? = call.argument("cid")
      if (cid != null) {
        ReAndroidSDK.getInstance(context).deleteNotificationByCampaignId(cid)
      }
    }
    else if(call.method == "readNotification") {
      var cid:String? = call.argument("cid")
      if (cid != null) {
        ReAndroidSDK.getInstance(context).readNotification(cid)
      }
    }
    else if(call.method == "appConversionTracking") {
//      val jsonString = "{\"name\":\"John\",\"age\":30,\"city\":\"New York\"}"
//      val jsonObject: org.json.JSONObject = JSONObject(jsonString)
//      ReAndroidSDK.getInstance(context).appConversionTracking(jsonObject)
      ReAndroidSDK.getInstance(context).appConversionTracking()
    }
    else if(call.method == "formDataCapture") {
      var formData:String? = call.argument("formData")
      val jobj=JSONObject(formData)
      if (formData != null) {
        ReAndroidSDK.getInstance(context).formDataCapture(jobj)
      }
    }
    else if(call.method == "readNotificationCount") {

      result.success(ReAndroidSDK.getInstance(context).readNotificationCount)

    }
    else if(call.method == "updatePushToken") {
      var token: String?=call.argument("regToken")
      ReAndroidSDK.getInstance(context).updatePushToken(token)
    }

    else if(call.method == "onDeviceUserRegister") {
      val uid:String?=call.argument("uid")
      val name:String?=call.argument("name")
      val age:String?=call.argument("age")
      val email:String?=call.argument("email")
      val phone:String?=call.argument("phone")
      val gender:String?=call.argument("gender")
      val token:String?=call.argument("token")
      val profileUrl:String?=call.argument("profileUrl")
      val dob:String?=call.argument("dob")
      val education:String?=call.argument("education")
      val employed:Boolean?=call.argument("employed")
      val married:Boolean?=call.argument("employed")
      val adId:String?=call.argument("adId")
      val obj = MRegisterUser()
      obj.userUniqueId=uid
      obj.name=name
      obj.age=age
      obj.email=email
      obj.phone=phone
      obj.gender=gender
      obj.deviceToken=token
      obj.profileUrl=profileUrl
      obj.dob=dob
      obj.education=education
      obj.adId=adId
      if (employed != null) {
        obj.isEmployed=employed
      }
      if (married != null) {
        obj.isMarried=married
      }
      ReAndroidSDK.getInstance(context).onDeviceUserRegister(obj)
    }
    else if(call.method == "deepLinkData") {
      ReAndroidSDK.getInstance(context).deepLinkData
    }
    else if(call.method == "unReadNotification") {
      var cid:String? = call.argument("cid")
      if (cid != null) {
        ReAndroidSDK.getInstance(context).unReadNotification(cid)
        override@
        channel.invokeMethod("callFromAndroid", "call from android")

      }
    }
    else if(call.method == "onMessageReceived") {
      var remoteMessage:RemoteMessage?=call.argument("msg")
     if(remoteMessage!=null){
         ReAndroidSDK.getInstance(context).onReceivedCampaign(remoteMessage.data)
      }

    }
    else if(call.method == "getNotifications") {
        var nTable=ReAndroidSDK.getInstance(context).notifications
      Log.d("getNoti", "Notification : $nTable")
    }
    else if(call.method == "customevent") {
      val event: String?=call.argument("event")
      val eventData:String? = call.argument("eventData")
      val jobj= eventData?.let { JSONObject(it) }
      if (eventData != null) {
        ReAndroidSDK.getInstance(context).onTrackEvent(jobj,event)
      }

    }
    else {
      result.notImplemented()
    }
  }
  fun initResdk(flutterContext:Context){
    ReAndroidSDK.getInstance(flutterContext)
    AppConstants.LogFlag=true
  }
  fun clientMessageReceiver(remoteMessage:RemoteMessage,flutterContext: Context){
    io.flutter.Log.d("msgTrace", "From native code!!!!")
    ReAndroidSDK.getInstance(flutterContext).onReceivedCampaign(remoteMessage.data)
  }


  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }
//  fun callEventChannel(){
//    eventChannel.setStreamHandler(MessageNotifier())
//  }

}


//class MessageNotifier : EventChannel.StreamHandler {
//
//  override fun onListen(arguments: Any?,events: EventChannel.EventSink) {
//    events.success("Event Channel  :: Received a Notification")
//  }
//  override fun onCancel(arguments: Any?) {
//
//  }
//
//}
//class RandomNumberStreamHandler: EventChannel.StreamHandler {
//  var sink: EventChannel.EventSink? = null
//  var handler: Handler? = null
//
//  private val runnable = Runnable {
//    sendNewRandomNumber()
//  }
//
//  fun sendNewRandomNumber() {
//    val randomNumber = Random().nextInt(9)
//    sink?.success(randomNumber)
//    handler?.postDelayed(runnable, 1000)
//  }
//
//  override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
//    sink = events
//    handler = Handler()
//    handler?.post(runnable)
//  }
//
//  override fun onCancel(arguments: Any?) {
//    sink = null
//    handler?.removeCallbacks(runnable)
//  }
//}