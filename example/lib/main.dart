import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:fluttersdkplugin/fluttersdkplugin.dart';
import 'package:fluttersdkplugin/fluttersdkplugin_method_channel.dart';
import 'package:logger/logger.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_core/firebase_core.dart';


//
// @pragma('vm:entry-point')
// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   // If you're going to use other Firebase services in the background, such as Firestore,
//   // make sure you call `initializeApp` before using other Firebase services.
//   await Firebase.initializeApp();
//
//   _fluttersdkpluginPlugin.onMessageReceived(message);
// }


final _fluttersdkpluginPlugin = Fluttersdkplugin();
main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  TextEditingController controller1 = TextEditingController();
  String _platformVersion = 'Unknown',token = "ezyY7vF9TSqiwA3wxwJmYC:APA91bENxHnr2Z2XFHRpbu7GVJklVnDjs7phmEh2M4YNcxxxrPNRw1wtlvwAkGES_uEH8-wRAck30oBkvOwlZ0fJOyVYbcuOAaiOlHGwA9LTLxFnT5iAPAQEGN2LIgfyh6Ax9Iw5Kcf7";
  int notificationCount = 0,_counter=0;
  late String cid;
  String data="";

  var logger = Logger();
  late Timer _timer;

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
    // Firebase.initializeApp();
    // FirebaseMessaging.instance.getToken().then((newToken) {
    //   print("FCM token: ");
    //   print(newToken);
    //   FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    //     print('Got a message whilst in the foreground!');
    //     print('Message data: ${message.notification} ');
    //   });
    // });


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
    events.receiveBroadcastStream().listen((dataa) {
      setState(() {
        data=dataa;
      });
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
        "apikey": "api_key_b78db6b3-9462-4132-a4d3-894db10b3782",
        "City": "Chennai" // required
      };
      String formData = jsonEncode(param);
      _fluttersdkpluginPlugin.formDataCapture(formData);
    }
  customevent(){
      var data = {
        "name": "payment",
        "data": {"id": "2d43", "price": "477"}
      };
      String eventData = jsonEncode(data);
      _fluttersdkpluginPlugin.customevent(eventData,"Custom Event");
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
                      // Center(
                      //   child: Text('Data Passed from NativeCode: $data!'),
                      // ),
                      SizedBox(
                          width:double.infinity,
                          child:  ElevatedButton(onPressed: () { //
                            ondeviceRegister();
                          }, child: Text("On Device User Register"),),
                      ),
                      SizedBox(
                          width:double.infinity,
                          child:ElevatedButton(onPressed: () {
                            updatepushToken();
                          }, child: Text("update Push Token"),), 
                      ),
                      SizedBox(
                          width:double.infinity,
                          child:  ElevatedButton(onPressed: () {
                            passLocation();
                          }, child: Text("Update Location"),),
                      ),
                      SizedBox(
                          width:double.infinity,
                          child:ElevatedButton(

                            onPressed: () {
                              newNotification();
                            },child: Text("Add New Notification"),),
                      ),
                      TextField(
                        controller: controller1,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            labelText: "Enter ID",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20))),),
                      SizedBox(
                          width:double.infinity,
                          child:ElevatedButton(onPressed: () {
                            readnotification();
                          }, child: Text("Read Notification By Id"),),
                      ),
                      SizedBox(
                        width:double.infinity,
                        child:    ElevatedButton(onPressed: () {
                          _fluttersdkpluginPlugin.getNotification();
                        }, child: Text("Get Notifications"),),
                      ),
                      SizedBox(
                          width:double.infinity,
                          child:    ElevatedButton(onPressed: () {
                            unreadNotification();
                          }, child: Text("Un Read Notification"),),
                      ),
                      SizedBox(
                        width:double.infinity,
                        child: ElevatedButton(onPressed: () {
                          readnotificationCount();
                        }, child: const Text("Read Notification Count"),),
                      ),
                      SizedBox(
                          width:double.infinity,
                          child:  ElevatedButton(onPressed: () {
                            deleteNotificationByCampaignid();
                            setState(() {
                              controller1.clear();
                            });
                          }, child: Text("Delete Notification By CampaignId"),),
                      ),

                      SizedBox(
                          width:double.infinity,
                          child: ElevatedButton(onPressed: () {
                            formdataCapture();
                          }, child: Text("form Data Capture"),),
                      ),
                      SizedBox(
                          width:double.infinity,
                          child:ElevatedButton(onPressed: () {
                            ontrackEvent();
                          }, child: Text("On Track Event"),),
                      ),
                      SizedBox(
                      width:double.infinity,
                      child:ElevatedButton(onPressed: () {
                        appconversionTracking();
                      }, child: Text("app Conversion Tracking"),),
                    ),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(onPressed: () {
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size.fromHeight(40),);
                          getdeepLinkData();
                        }, child: Text("Get deepLinkData"),),
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(onPressed: () {
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size.fromHeight(40),);
                          customevent();
                        }, child: Text("CustomEvent"),),
                      ),


                    ],
                  ),
                ),
              ),
            ),
          )
       );
    }
}
