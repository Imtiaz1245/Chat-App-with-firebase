import 'package:firebaseflutter/ApplicationModule/Utills/app_colors.dart';
import 'package:firebaseflutter/ApplicationModule/Utills/default_text_view.dart';
import 'package:firebaseflutter/ApplicationModule/Utills/height_width.dart';
import 'package:flutter/material.dart';

class SecondPageView extends StatefulWidget {
  final controller;

  const SecondPageView({Key? key, required this.controller}) : super(key: key);

  @override
  State<SecondPageView> createState() => _SecondPageViewState();
}

class _SecondPageViewState extends State<SecondPageView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: CustomHeight(context) / 2,
      width: CustomWidth(context),
      color: AppColor.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
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
          Image.asset(
            "assets/images/star.png",
            width: 93.1,
            height: 91.1,
            fit: BoxFit.fill,
          ),
          SizedBox(
            height: 50,
          ),
          SizedBox(
            child: Padding(
              padding:  EdgeInsets.all(8.0),
              child: DefaultTextView(
                  text:
                      "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry’s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic ",
              textcolor: AppColor.grey,
                textAlign: TextAlign.center,
                fontSize: 15.0,
              ),
            ),
          )
        ],
      ),
    );
  }
}
