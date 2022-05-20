import 'package:firebaseflutter/ApplicationModule/ChatModule/ViewController/all_user_view_controller.dart';
import 'package:firebaseflutter/ApplicationModule/Utills/app_colors.dart';
import 'package:firebaseflutter/ApplicationModule/Utills/custom_navigator.dart';
import 'package:firebaseflutter/ApplicationModule/Utills/default_button.dart';
import 'package:firebaseflutter/ApplicationModule/Utills/default_text_form_field.dart';
import 'package:firebaseflutter/ApplicationModule/Utills/default_text_view.dart';
import 'package:firebaseflutter/ApplicationModule/Utills/height_width.dart';
import 'package:flutter/material.dart';

class VerifyPasswordViewController extends StatefulWidget {
  const VerifyPasswordViewController({Key? key}) : super(key: key);

  @override
  State<VerifyPasswordViewController> createState() =>
      _VerifyPasswordViewControllerState();
}

class _VerifyPasswordViewControllerState
    extends State<VerifyPasswordViewController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
          child: SizedBox(
        height: CustomHeight(context),
        width: CustomWidth(context),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: CustomHeight(context) * 0.25,
            ),
            Image.asset("assets/images/pincode.png"),
            SizedBox(
              height: 30,
            ),
            DefaultTextView(
                text:
                    "We sendet to your phone message to confirm your phone number.",
                textAlign: TextAlign.center,
                textcolor: AppColor.grey),
            SizedBox(
              height: 30,
            ),
            DefaultTextFormFieldView(width: MediaQuery.of(context).size.width,
              height: 50.0,
              labelText: Text("OTP"),
            ),

            Expanded(

              child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding:  EdgeInsets.only(bottom: 30.0),
                  child: DefaultButtonView(
                    onpress: (){
CustomNavigator(context,AllUserViewController());
                    },
                    width: MediaQuery.of(context).size.width,
                    height: 50.0,
                    btnColor: AppColor.defaultcolor,
                    borderRadius: 30.0,
                    child: DefaultTextView(text: "Confirm",textcolor: AppColor.white,),
                  ),
                ),
              ),
            )
          ],
        ),
      )),
    );
  }
}
