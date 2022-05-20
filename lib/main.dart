import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebaseflutter/ApplicationModule/AuthenticationModule/ViewController/signup_view_controller.dart';
import 'package:firebaseflutter/ApplicationModule/ChatModule/ViewController/all_user_view_controller.dart';
import 'package:firebaseflutter/ApplicationModule/OnBordingModule/ViewController/onboarding_view_controller.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'ApplicationModule/AuthenticationModule/Services/local_notifications_services.dart';
Future<void>backgroundHandler(RemoteMessage  message)async{
  print(message.data.toString());
  print(message.notification!.title);
await LocalNotifications().init();
  LocalNotifications().notification('${message.notification!.title}',
      '${message.notification!.body}', message.data.toString());
}
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  MobileAds.instance.initialize();
  await LocalNotifications().init();
  await FirebaseMessaging.instance.getInitialMessage();

  //foreground working
  FirebaseMessaging.onMessage.listen((message) async{

    if(message.notification!=null){
      print(message.notification!.body);
      print(message.notification!.title);

      LocalNotifications().notification('${message.notification!.title}',
          '${message.notification!.body}', message.data.toString());

      }
  });
  //background working
  FirebaseMessaging.onMessageOpenedApp.listen((message) async{

    LocalNotifications().notification('${message.notification!.title}',
        '${message.notification!.body}', message.data.toString());
  });
  runApp(Splash());
}

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  int? checkvalue;
  var curent;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: checkvalue != 0
            ? (curent!=null?AllUserViewController():SignUpViewController())
            : OnBoardingViewController());
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    check();
    //work in foreground

  }

  void check() async {
    final sharedpref = await SharedPreferences.getInstance();
    int val = await sharedpref.getInt("check") ?? 0;
    final currentuser=await FirebaseAuth.instance.currentUser!;
    setState(() {
      checkvalue = val;
      setState(() {
        curent=currentuser;
      });
    });
  }
}
