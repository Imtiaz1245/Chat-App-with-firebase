import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:country_list_pick/country_list_pick.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebaseflutter/ApplicationModule/AuthenticationModule/Services/googleauth.dart';
import 'package:firebaseflutter/ApplicationModule/AuthenticationModule/ViewController/verify_password_view_controller.dart';
import 'package:firebaseflutter/ApplicationModule/ChatModule/ViewController/all_user_view_controller.dart';
import 'package:firebaseflutter/ApplicationModule/Utills/app_colors.dart';
import 'package:firebaseflutter/ApplicationModule/Utills/custom_navigator.dart';
import 'package:firebaseflutter/ApplicationModule/Utills/default_button.dart';
import 'package:firebaseflutter/ApplicationModule/Utills/default_text_form_field.dart';
import 'package:firebaseflutter/ApplicationModule/Utills/default_text_view.dart';
import 'package:firebaseflutter/ApplicationModule/Utills/height_width.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class SignUpViewController extends StatefulWidget {
  const SignUpViewController({Key? key}) : super(key: key);

  @override
  State<SignUpViewController> createState() => _SignUpViewControllerState();
}

class _SignUpViewControllerState extends State<SignUpViewController> {
  late BannerAd myBanner;
  bool isAdLoaded = false;
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: CustomHeight(context),
          width: CustomWidth(context),
          color: AppColor.white,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 100,
                ),
                Image.asset(
                  "assets/images/Logo2.png",
                  width: CustomWidth(context) * 0.8,
                  height: CustomHeight(context) * 0.1,
                  fit: BoxFit.fill,
                ),
                SizedBox(
                  height: 50,
                ),
                DefaultTextView(
                  text: "Please register with your own \n number",
                  textcolor: AppColor.grey,
                  textAlign: TextAlign.center,
                  fontSize: 23.0,
                ),
                SizedBox(
                  height: 100,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.0),
                  child: DefaultButtonView(
                    height: 50.0,
                    width: CustomWidth(context),
                    onpress: () async {
                      await GoogleLoginService().onGoogleSignIn();

                      nextscreen();
                    },
                    child: DefaultTextView(
                        text: "Google Login",
                        fontSize: 23.0,
                        textcolor: AppColor.white),
                    btnColor: AppColor.defaultcolor,
                    borderRadius: 30.0,
                  ),
                ),
            isAdLoaded==true?Container(
                  alignment: Alignment.center,
                  child: AdWidget(
                    ad: myBanner,
                  ),
                  width: myBanner.size.width.toDouble(),
                  height: myBanner.size.height.toDouble(),
                ):SizedBox(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  void nextscreen(){
    CustomNavigator(context,AllUserViewController());
  }
}
