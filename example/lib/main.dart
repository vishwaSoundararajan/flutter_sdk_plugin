import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:fluttersdkplugin/fluttersdkplugin.dart';
import 'package:fluttersdkplugin/fluttersdkplugin_method_channel.dart';
import 'package:logger/logger.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  TextEditingController controller1 = TextEditingController();
  String _platformVersion = 'Unknown',token = "drqaIAt0TvW1x0zi7gOsLf:APA91bEKJFpCpld3QvWYxPSkzVzu3JH7wwrRhad8Pgqnr2TZ82NkxvK31VMiKpLCeloRC-SJImNaRrGFDCydSuCPlg5Ze2tL06-NntJbq-THcO2u-CQW1n5Nx_w1yw0dEYcRudDNIoxe";
  int notificationCount = 0,_counter=0;
  late String cid;
  String data="";

  var logger = Logger();
  late Timer _timer;
  final _fluttersdkpluginPlugin = Fluttersdkplugin();
  final _methodChannelflutterSdkPlugin= MethodChannelFluttersdkplugin();
  static const events = EventChannel('com.example.fluttersdkplugin_example/channell');
  static const methodChannel=MethodChannel("flutter/test/platformChannels");
// void onMethodCall(MethodCall call){
//   if (call.method=="callFromAndroid") {
//     print("method called from android");
//   }
// }

  @override
  void initState() {
    super.initState();
    initPlatformState();
    startTimer();
    //eventTriggered();
    //_fluttersdkpluginPlugin.setEventChannelID("example.com/channel");
    // handlePlatformChannelMethods();
    //onListenBattery();
  }

  void startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      listenForMsg();
    });
  }
  listenForMsg(){
    events.receiveBroadcastStream().listen((data) {
      if(data != ""){
        logger.i("EventChannel :: $data");
      }
    }, onError: (error) {
      print("Error: $error");
    });
  }

    passLocation() {
      double lat = 13.0827;
      double lang = 80.2707;
      _fluttersdkpluginPlugin.pushLocation(lat, lang);

    }
    newNotification() {
      var notificationTitle = "sample Title";
      var notificationBody = "sample Body";
      _fluttersdkpluginPlugin.addNewNotification(
          notificationTitle, notificationBody);
    }
    ontrackEvent() {
      var content = "On Track Event called!!!";
      _fluttersdkpluginPlugin.onTrackEvent(content);
    }
    deleteNotificationByCampaignid() {
      setCidState();
      _fluttersdkpluginPlugin.deleteNotificationByCampaignId(cid);
    }
    setCidState() {
      setState(() {
        cid = controller1.text;
      });
    }
    readnotification() {
      setCidState();
      _fluttersdkpluginPlugin.readNotification(cid);
    }
    unreadNotification() {
      setCidState();
      _fluttersdkpluginPlugin.unReadNotification(cid);
    }
    appconversionTracking() {
      _fluttersdkpluginPlugin.appConversionTracking();
    }
    formdataCapture() {
      Map param = {
        "Name": "vishwa",
        "EmailID": "abc@gmail.com",
        "MobileNo": 9329222922,
        "Gender": "Male",
        "formid": 101, // required
        "apikey": "e37315c0-8578-4bd2-a38a-cbba5dba8110",
        "City": "Chennai" // required
      };
      String formData = jsonEncode(param);
      _fluttersdkpluginPlugin.formDataCapture(formData);
    }
    updatepushToken() {
      _fluttersdkpluginPlugin.updatePushToken(token);
    }
    ondeviceRegister() {
      _fluttersdkpluginPlugin.onDeviceUserRegister(
          '123',
          'vishwa',
          '24',
          'abc@gmail.com',
          '9893839383',
          'Male',
          token,
          'www.google.com',
          '2/8/2005',
          'BE',
          true,
          false,
          "At_928jw8");
    }
    getdeepLinkData() {
      _fluttersdkpluginPlugin.deepLinkData();
    }
    Future<int?> readnotificationCount() async {
      var nCount = await _fluttersdkpluginPlugin.readNotificationCount()!;
      setState(() {
        notificationCount = nCount!;
      });
      if (kDebugMode) {
        print(notificationCount);
      }
      return null;
     }

   // callToAndroid(){
   //  _fluttersdkpluginPlugin.callFromAndroid();
   // }

  Future<dynamic> handlePlatformChannelMethods() async {
    methodChannel.setMethodCallHandler((methodCall) async {
      if (methodCall.method == "androidMethodName") {
        /// write the code here which you want to implement after  this method call
        print("method call from native code");
        if (methodCall.arguments != null) {
          print(methodCall.arguments);
        }
      }
      else if (methodCall.method == "iosMethodName") {
        /// ...... }
      }
    });
    }

    // eventTriggered(){
    //   events.receiveBroadcastStream().listen((datta) {
    //     if(datta is String){
    //       setState(() {
    //          data=datta;
    //       });
    //     //  print("received integer: $data");
    //     }
    //   }, onError: (error) {
    //     print("Error: $error");
    //   });
    // }
    // Platform messages are asynchronous, so we initialize in an async method.

    Future<void> initPlatformState() async {
      String platformVersion;
      // Platform messages may fail, so we use a try/catch PlatformException.
      // We also handle the message potentially returning null.
      try {
        platformVersion =
            await _fluttersdkpluginPlugin.getPlatformVersion() ??
                'Unknown platform version';
      } on PlatformException {
        platformVersion = 'Failed to get platform version.';
      }

      // If the widget was removed from the tree while the asynchronous platform
      // message was in flight, we want to discard the reply rather than calling
      // setState to update our non-existent appearance.
      if (!mounted) return;

      setState(() {
        _platformVersion = platformVersion;
      });
    }
    @override
    Widget build(BuildContext context) {

    return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: Scaffold(
            resizeToAvoidBottomInset: true,
            appBar: AppBar(
              title: const Text('Plugin example app'),
            ),
            body: SingleChildScrollView(
              child: ConstrainedBox(
                constraints: const BoxConstraints(),
                child:
                Container(
                  child: Column(
                    children: [
                      Center(
                        child: Text('Running on: $_platformVersion\n'),
                      ),
                      Center(
                        child: Text('Data Passed from NativeCode: $data!'),
                      ),
                      ElevatedButton(onPressed: () {
                        passLocation();
                      }, child: Text("Push Location"),),
                      ElevatedButton(onPressed: () {
                        newNotification();
                        //_fluttersdkpluginPlugin.onMessageReceived("Background Notification");

                      }, child: Text("Add New Notification"),),
                      ElevatedButton(onPressed: () {
                        ontrackEvent();

                      }, child: Text("On Track Event"),),
                      TextField(
                        controller: controller1,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            labelText: "Enter ID",

                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20))),),
                      ElevatedButton(onPressed: () {
                        deleteNotificationByCampaignid();
                      }, child: Text("delete Notification By Campaignid"),),
                      ElevatedButton(onPressed: () {
                        readnotification();
                      }, child: Text("read Notification"),),
                      ElevatedButton(onPressed: () {
                        appconversionTracking();
                      }, child: Text("app Conversion Tracking"),),
                      ElevatedButton(onPressed: () {
                        formdataCapture();
                      }, child: Text("form Data Capture"),),
                      ElevatedButton(onPressed: () {
                        readnotificationCount();
                      }, child: Text("read Notification Count"),),
                      ElevatedButton(onPressed: () {
                        updatepushToken();
                      }, child: Text("update Push Token"),),
                      ElevatedButton(onPressed: () { //
                        ondeviceRegister();
                      }, child: Text("On Device User Register"),),
                      ElevatedButton(onPressed: () {
                        getdeepLinkData();
                      }, child: Text("Get deepLinkData"),),
                      ElevatedButton(onPressed: () {
                        unreadNotification();
                      }, child: Text("un Read Notification"),),
                      // ElevatedButton(onPressed: () {
                      //   callToAndroid();
                      // }, child: Text("callToAndroid"),),
                    ],
                  ),
                ),
              ),
            ),)
      );
    }
}
