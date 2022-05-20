import 'package:firebaseflutter/ApplicationModule/AuthenticationModule/ViewController/signup_view_controller.dart';
import 'package:firebaseflutter/ApplicationModule/OnBordingModule/View/page1View.dart';
import 'package:firebaseflutter/ApplicationModule/OnBordingModule/View/second_page_view.dart';
import 'package:firebaseflutter/ApplicationModule/OnBordingModule/View/third_page_view.dart';
import 'package:firebaseflutter/ApplicationModule/Utills/app_colors.dart';
import 'package:firebaseflutter/ApplicationModule/Utills/custom_navigator.dart';
import 'package:firebaseflutter/ApplicationModule/Utills/default_button.dart';
import 'package:firebaseflutter/ApplicationModule/Utills/default_text_view.dart';
import 'package:firebaseflutter/ApplicationModule/Utills/height_width.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnBoardingViewController extends StatefulWidget {
  const OnBoardingViewController({Key? key}) : super(key: key);

  @override
  State<OnBoardingViewController> createState() =>
      _OnBoardingViewControllerState();
}

class _OnBoardingViewControllerState extends State<OnBoardingViewController> {
  PageController controller = PageController();
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    var defaultc = currentIndex == 0 ? AppColor.white : AppColor.defaultcolor;

    return Scaffold(
      body: SafeArea(
          child: Container(
        height: CustomHeight(context),
        child: Stack(
          children: [
            SizedBox(
              height: CustomHeight(context),
              child: PageView(
                onPageChanged: (value) {
                  setState(() {
                    currentIndex = value;
                  });
                },
                controller: controller,
                children: [
                  FirstPageView(
                    controller: controller,
                  ),
                  SecondPageView(
                    controller: controller,
                  ),
                  ThirdPageView(controller: controller),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    height: 30,
                    child: Center(
                      child: ListView.builder(
                        itemCount: 3,
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: 20,
                              width: 20,
                              decoration: currentIndex == index
                                  ? BoxDecoration(
                                      color: currentIndex == 0
                                          ? AppColor.white
                                          : AppColor.defaultcolor,
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                          width: 1,
                                          color: currentIndex == 0
                                              ? AppColor.white
                                              : AppColor.defaultcolor))
                                  : BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                          width: 1,
                                          color: currentIndex == 0
                                              ? AppColor.white
                                              : AppColor.defaultcolor)),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 70,
                  ),
                  DefaultButtonView(
                    height: 50.0,
                    width: CustomWidth(context) * 0.8,

                      onpress: () {
                        currentIndex == 2 ? setvalue() : 0;
                        currentIndex != 2
                            ? controller.nextPage(
                                duration: Duration(milliseconds: 500),
                                curve: Curves.easeIn,
                              )
                            : Navigator.pushReplacement(
                                context,
                                PageTransition(
                                    child: SignUpViewController(),
                                    type: PageTransitionType.rightToLeft));
                      },
                      child: DefaultTextView(
                        text: currentIndex == 2 ? "Finish" : "Next",
                        fontSize: 23.0,
                        textcolor: AppColor.grey,
                      ),
                      btnColor: defaultc,
                    borderRadius: 30.0,
                    ),

                ],
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
  }

  void setvalue() async {
    final sharedpref = await SharedPreferences.getInstance();
    await sharedpref.setInt("check", 1);
  }
}
