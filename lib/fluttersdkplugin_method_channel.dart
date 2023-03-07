import 'dart:async';
import 'dart:ffi';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';
import 'fluttersdkplugin_platform_interface.dart';

/// An implementation of [FluttersdkpluginPlatform] that uses method channels.
class MethodChannelFluttersdkplugin extends FluttersdkpluginPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('fluttersdkplugin');
  static const eventChannel = EventChannel('example.com/channel');

  eventTriggered(){
    Timer(const Duration(seconds: 2),(){
      eventChannel.receiveBroadcastStream().listen((datta) {
        if(datta is String){
          if (kDebugMode) {
            print(datta);
          }
        }
      }, onError: (error) {
        if (kDebugMode) {
          print("Error: $error");
        }
      });
    });

  }

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
  @override
  pushLocation(double lat, double lang) {
    methodChannel.invokeMapMethod('pushLocation', {'lat': lat, 'lang': lang});
  }

  @override
  addNewNotification(String notificationTitle, String notificationBody) {
    methodChannel.invokeMapMethod('addNewNotification',{'title': notificationTitle,'body':notificationBody});
  }
  @override
  onTrackEvent(String content) {
    methodChannel.invokeMapMethod('onTrackEvent',{'string': content});
  }
  @override
  deleteNotificationByCampaignId(content) {
    methodChannel.invokeMapMethod('deleteNotificationByCampaignId',{'cid':content});
  }
  @override
  readNotification(content) {
    methodChannel.invokeMapMethod('readNotification',{'cid':content});
  }
  @override
  appConversionTracking() {
    methodChannel.invokeMapMethod('appConversionTracking');
  }

  @override
  formDataCapture(String formData) {
    methodChannel.invokeMapMethod('formDataCapture',{'formData':formData});
  }
  @override
  Future<int?> readNotificationCount() async {
    final notifyCount=await methodChannel.invokeMethod<int>('readNotificationCount');
    return notifyCount;
  }
  @override
  updatePushToken(String regToken) {
    methodChannel.invokeMapMethod('updatePushToken',{'regToken':regToken});
  }
  @override
  onDeviceUserRegister(String uid, String name, String age, String email, String phone, String gender, String token, String profileUrl, String dob, String education, bool employed, bool married,String adId) {
    methodChannel.invokeMapMethod('onDeviceUserRegister',{'uid':uid,'name':name,'age':age,'email':email,'phone':phone,'gender':gender,'token':token,'profileUrl':profileUrl,'dob':dob,'education':education,'employed':employed,'married':married,'adId':adId});
  }
  @override
  deepLinkData() {
    methodChannel.invokeMapMethod('deepLinkData');
  }
  @override
  unReadNotification(String cid) {
    methodChannel.invokeMapMethod('unReadNotification',{'cid':cid});
  }
  @override
  onMessageReceived(RemoteMessage msg){
    methodChannel.invokeMethod('onMessageReceived',{'msg':msg});

  }
  @override
  getNotification(){
    methodChannel.invokeMethod('getNotifications');
  }
  @override
  customevent(String eventData,String event){
    methodChannel.invokeMapMethod('customevent',{"eventData":eventData,"event":event});
  }

}
