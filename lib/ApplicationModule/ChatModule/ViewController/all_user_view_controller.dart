import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebaseflutter/ApplicationModule/ChatModule/View/all_users_view.dart';
import 'package:firebaseflutter/ApplicationModule/ChatModule/ViewController/search_view_controller.dart';
import 'package:firebaseflutter/ApplicationModule/ChatModule/Model/usermodel.dart';
import 'package:firebaseflutter/ApplicationModule/Utills/app_colors.dart';
import 'package:firebaseflutter/ApplicationModule/Utills/custom_navigator.dart';
import 'package:firebaseflutter/ApplicationModule/Utills/default_text_form_field.dart';
import 'package:firebaseflutter/ApplicationModule/Utills/default_text_view.dart';
import 'package:firebaseflutter/ApplicationModule/Utills/height_width.dart';
import 'package:flutter/material.dart';

class AllUserViewController extends StatefulWidget {
  const AllUserViewController({Key? key}) : super(key: key);

  @override
  State<AllUserViewController> createState() => _AllUserViewControllerState();
}

class _AllUserViewControllerState extends State<AllUserViewController> {
  String firebaseToken = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.defaultcolor,
        title: DefaultTextView(
          text: "Unique Chat",
          textcolor: AppColor.white,
          fontSize: 20.0,
          fontweight: FontWeight.bold,
        ),
        actions: [
          SizedBox(
            width: 10,
          ),
          IconButton(
            onPressed: () {
              CustomNavigator(context, SearchViewController());
            },
            icon: Icon(
              Icons.search,
              size: 25,
            ),
          ),
          SizedBox(
            width: 5,
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.more_vert),
          ),
        ],
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
          child: SizedBox(
        height: CustomHeight(context),
        width: CustomWidth(context),
        child: AllUsersView(),
      )),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    gettoken();
  }

  void gettoken() {
    FirebaseMessaging.instance.getToken().then((value) {
      setState(() {
        firebaseToken = value!;
      });
      savetoken(value);
    });
  }

  void savetoken(token) async {
    var currentUser = FirebaseAuth.instance.currentUser!;
    await FirebaseFirestore.instance
        .collection("Users")
        .doc(await FirebaseAuth.instance.currentUser!.email)
        .set({
      "FCMToken": token,
      "Name": currentUser.displayName,
      "Email": currentUser.email,
      "PhotoUrl":currentUser.photoURL
    });
  }
}
