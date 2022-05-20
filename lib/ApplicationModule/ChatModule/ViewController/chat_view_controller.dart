import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebaseflutter/ApplicationModule/ChatModule/View/chat_list_view.dart';
import 'package:firebaseflutter/ApplicationModule/Utills/app_colors.dart';
import 'package:firebaseflutter/ApplicationModule/Utills/default_text_form_field.dart';
import 'package:firebaseflutter/ApplicationModule/Utills/height_width.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;

class ChatViewController extends StatefulWidget {
  final useremail,userName,FCMToken,photourl;

  const ChatViewController({Key? key, this.useremail, this.userName, this.FCMToken, this.photourl}) : super(key: key);

  @override
  State<ChatViewController> createState() => _ChatViewControllerState();
}

class _ChatViewControllerState extends State<ChatViewController> {
  TextEditingController chatController = TextEditingController();
  bool onchange = false;
  String? useremail;
  late AndroidNotificationChannel channel;
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColor.defaultcolor,
        title: Row(
          children: [
            InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(
                Icons.arrow_back_sharp,
                color: AppColor.white,
              ),
            ),
            SizedBox(
              width: 5,
            ),
            SizedBox(
              height: 40,
              width: 40,
              child: CircleAvatar(
                backgroundImage: NetworkImage("${widget.photourl}"),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            SizedBox(
              width: 140.0,
              child: Text(
                "${widget.userName}",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                softWrap: false,
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16.0),
              ),
            ),
          ],
        ),
        actions: [

              InkWell(
                onTap: (){},
                child: Icon(
                  Icons.videocam_rounded,
                  color: AppColor.white,),
              ),
SizedBox(width: 10,),
          InkWell(
            onTap: (){},
            child: Icon(
              Icons.call,
              color: AppColor.white,),
          ),
          SizedBox(width: 10,),
          InkWell(
            onTap: (){},
            child: Icon(
              Icons.more_vert,
              color: AppColor.white,),
          ),
          SizedBox(width: 10,),
        ],
      ),
      body: SafeArea(
          child: SizedBox(
        height: CustomHeight(context),
        width: CustomWidth(context),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
                child: ChatListView(
              useremail: widget.useremail,
            )),
            Padding(
              padding: EdgeInsets.only(top: 2.0),
              child: SizedBox(
                height: 50.0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    DefaultTextFormFieldView(
                      height: 50.0,
                      hint: "Message",
                      controller: chatController,
                      onchange: (value) {
                        String chat = value;
                        setState(() {
                          if (chat.trim().isNotEmpty) {
                            onchange = true;
                          } else {
                            onchange = false;
                          }
                        });
                      },
                      width: CustomWidth(context) * 0.8,
                    ),
                    InkWell(
                        onTap: () async {
                          if (onchange == true) {
String message=chatController.text.toString();
setState(() {
  chatController.text="";
});
                            await FirebaseFirestore.instance
                                .collection("Users")
                                .doc(
                                "${FirebaseAuth.instance.currentUser!.email.toString().trim()}")
                                .collection("MyUser")
                                .doc("${widget.useremail}").set({
                              "Email":widget.useremail,
                              "Name":widget.userName,
                              "FCMToken":widget.FCMToken,
                              "PhotoUrl":widget.photourl.toString()
                            });
                            await FirebaseFirestore.instance
                                .collection("Users")
                                .doc(
                                    "${FirebaseAuth.instance.currentUser!.email.toString().trim()}")
                                .collection("MyUser")
                                .doc("${widget.useremail}")
                                .collection("Messages")
                                .doc()
                                .set({
                              "Message": message,
                              "DateTime":DateTime.now().microsecondsSinceEpoch,

                              "IsMe": true
                            });
DocumentSnapshot snapsht=await FirebaseFirestore.instance.collection("Users").doc("${await FirebaseAuth.instance.currentUser!.email}").get();
String Token=(snapsht.data()as dynamic)["FCMToken"];
                            await FirebaseFirestore.instance
                                .collection("Users")
                                .doc("${widget.useremail}")
                                .collection("MyUser")
                                .doc(
                                "${FirebaseAuth.instance.currentUser!.email.toString().trim()}").set(
                                {
                                  "Name":FirebaseAuth.instance.currentUser!.displayName,
                                  "Email":FirebaseAuth.instance.currentUser!.email,
                                  "FCMToken":Token,
                                  "PhotoUrl": FirebaseAuth.instance.currentUser!.photoURL.toString()


                                });
                            await FirebaseFirestore.instance
                                .collection("Users")
                                .doc("${widget.useremail}")
                                .collection("MyUser")
                                .doc(
                                    "${FirebaseAuth.instance.currentUser!.email.toString().trim()}")
                                .collection("Messages")
                                .doc()
                                .set({
                              "Message": message,
                              "DateTime":DateTime.now().microsecondsSinceEpoch,
                              "IsMe": false
                            });
                            _sendAndRetrieveMessage(chatController.text,widget.FCMToken,FirebaseAuth.instance.currentUser!.displayName.toString());
                            setState(() {
                              onchange = false;
                            });
                          }
                       print("${widget.FCMToken}");
                        },
                        child: CircleAvatar(
                          backgroundColor: AppColor.defaultcolor,
                          child: Icon(
                            onchange == false
                                ? Icons.keyboard_voice_rounded
                                : Icons.send,
                            color: AppColor.white,
                          ),
                        )),
                  ],
                ),
              ),
            )
          ],
        ),
      )),
    );
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();


    FirebaseMessaging.instance.subscribeToTopic("Animal");
  }
  Future<void> _sendAndRetrieveMessage(String message, String tokin,String username) async {
    // Go to Firebase console -> Project settings -> Cloud Messaging -> copy Server key
    // the Server key will start "AAAAMEjC64Y..."

    final yourServerKey =
"AAAAKAs0liU:APA91bHIJXlbQEYLjyxg8LHYayM4EDJ-FMGhhA_Vx4HOZCCj71j7lQpeuQOeoB40lcxQnKpcH8h2TFJEiJCGaLckgpSYSvMT3wMdD-o-oacKnaTR-96oQzOyItFeh6TjEdJpnMgt9h6E";    await http.post(
      Uri.parse('https://fcm.googleapis.com/fcm/send'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'key=$yourServerKey',
      },
      body: jsonEncode(
        <String, dynamic>{
          'notification': <String, dynamic>{
            'body': "${message}",
            'title': "${username}",
          },
          'priority': 'high',
          'data': <String, dynamic>{
            'click_action': 'FLUTTER_NOTIFICATION_CLICK',
            'id': '1',
            'status': 'done'
          },
          // FCM Token lists.
          // 'registration_ids': ["Your_FCM_Token_One", "Your_FCM_Token_Two"],
          'to': tokin
        },
      ),
    );
  }
  void requestPermission() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
    } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
      print('User granted provisional permission');
    } else {
      print('User declined or has not accepted permission');
    }
  }

  void listenFCM() async {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null && !kIsWeb) {
        flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              // TODO add a proper drawable resource to android, for now using
              //      one that already exists in example app.
              icon: 'launch_background',
            ),
          ),
        );
      }
    });
  }

  void loadFCM() async {
    if (!kIsWeb) {
      channel = const AndroidNotificationChannel(
        'high_importance_channel', // id
        'High Importance Notifications', // title
        importance: Importance.high,
        enableVibration: true,
      );

      flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

      /// Create an Android Notification Channel.
      ///
      /// We use this channel in the `AndroidManifest.xml` file to override the
      /// default FCM channel to enable heads up notifications.
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(channel);

      /// Update the iOS foreground notification presentation options to allow
      /// heads up notifications.
      await FirebaseMessaging.instance
          .setForegroundNotificationPresentationOptions(
        alert: true,
        badge: true,
        sound: true,
      );
    }
  }
}
