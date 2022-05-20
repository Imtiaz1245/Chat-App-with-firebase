import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
void CustomNavigator(context,screenName){
  Navigator.push(context, PageTransition(child: screenName, type: PageTransitionType.rightToLeft,duration: Duration(milliseconds: 200)));
}