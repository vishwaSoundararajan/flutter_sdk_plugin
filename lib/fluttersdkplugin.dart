import 'dart:async';
import 'dart:ffi';
import 'fluttersdkplugin_platform_interface.dart';

class Fluttersdkplugin {
  Future<String?> getPlatformVersion() {
    return FluttersdkpluginPlatform.instance.getPlatformVersion();
  }
  pushLocation(double lat, double lang) {
    FluttersdkpluginPlatform.instance.pushLocation(lat, lang);
  }

  addNewNotification(String notificationTitle, String notificationBody) {
    FluttersdkpluginPlatform.instance.addNewNotification(
        notificationTitle, notificationBody);
  }
  onTrackEvent(String content) {
    FluttersdkpluginPlatform.instance.onTrackEvent(content);
  }

  void deleteNotificationByCampaignId(String cid) {
    FluttersdkpluginPlatform.instance.deleteNotificationByCampaignId(cid);
  }
  void readNotification(String cid) {
    FluttersdkpluginPlatform.instance.readNotification(cid);
  }
  void appConversionTracking() {
    FluttersdkpluginPlatform.instance.appConversionTracking();
  }
  void formDataCapture(String formData) {
    FluttersdkpluginPlatform.instance.formDataCapture(formData);
  }
  Future<int?>  readNotificationCount() {
    return FluttersdkpluginPlatform.instance.readNotificationCount();
  }
  void updatePushToken(String token) {
    FluttersdkpluginPlatform.instance.updatePushToken(token);
  }
  void onDeviceUserRegister(String uid, String name, String age, String email, String phone, String gender, String token, String profileUrl, String dob, String education, bool employed, bool married,String adId) {
    FluttersdkpluginPlatform.instance.onDeviceUserRegister(uid,name,age,email,phone,gender,token,profileUrl,dob,education,employed,married,adId);
  }
  void deepLinkData () {
    FluttersdkpluginPlatform.instance.deepLinkData();
  }
  void unReadNotification(String cid) {
    FluttersdkpluginPlatform.instance.unReadNotification(cid);
  }
  onMessageReceived(String title) {
   FluttersdkpluginPlatform.instance.onMessageReceived(title);

  }

}
