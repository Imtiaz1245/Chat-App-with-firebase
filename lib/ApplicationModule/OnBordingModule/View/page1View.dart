import 'package:firebaseflutter/ApplicationModule/Utills/app_colors.dart';
import 'package:firebaseflutter/ApplicationModule/Utills/default_text_view.dart';
import 'package:firebaseflutter/ApplicationModule/Utills/height_width.dart';
import 'package:flutter/material.dart';
class FirstPageView extends StatefulWidget {
  final controller;

  const FirstPageView({Key? key, required this.controller}) : super(key: key);
  @override
  State<FirstPageView> createState() => _FirstPageViewState();
}

class _FirstPageViewState extends State<FirstPageView> {
  @override
  Widget build(BuildContext context) {
    return
      Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                stops: [0.45, 1],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFFFDA085),
                  Color(0xFFF6D365),
                ])),
        child: Column(
          children: [
            SizedBox(
              height: 100,
            ),
            Image.asset(
              "assets/images/Logo.png",
              width: CustomWidth(context) * 0.8,
              height: CustomHeight(context) * 0.1,
              fit: BoxFit.fill,
            ),
            SizedBox(
              height: 70,
            ),
            Image.asset(
              "assets/images/Decoration.png",
              width: CustomWidth(context) * 0.8,
              height: CustomHeight(context) * 0.30,
              fit: BoxFit.fill,
            ),



          ],
        ),
      );
  }
}
