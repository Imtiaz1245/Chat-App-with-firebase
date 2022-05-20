import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebaseflutter/ApplicationModule/Utills/app_colors.dart';
import 'package:firebaseflutter/ApplicationModule/Utills/default_button.dart';
import 'package:firebaseflutter/ApplicationModule/Utills/default_text_view.dart';
import 'package:firebaseflutter/ApplicationModule/Utills/height_width.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
class PutImgetofirestore extends StatefulWidget {
  const PutImgetofirestore({Key? key}) : super(key: key);

  @override
  State<PutImgetofirestore> createState() => _PutImgetofirestoreState();
}

class _PutImgetofirestoreState extends State<PutImgetofirestore> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: CustomHeight(context),
        width: CustomWidth(context),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DefaultButtonView(
              child: DefaultTextView(text: "Set Image",textcolor: Colors.white,),
              onpress: ()async{

                final ImagePicker _picker = ImagePicker();
                // Pick an image
                final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

               var pickedimage=File(image!.path);
if(await FirebaseAuth.instance.currentUser==null)
  {
   await FirebaseAuth.instance.signInAnonymously();

    final reference = await FirebaseStorage.instance
        .ref()
        .child('Upload/'
        ' ').child("google");
    UploadTask uploadTask = reference.putFile(pickedimage);
    TaskSnapshot snapshot = await uploadTask;
  }
else{
  final reference = await FirebaseStorage.instance
      .ref()
      .child('Upload');
  UploadTask uploadTask = reference.putFile(pickedimage);
  TaskSnapshot snapshot = await uploadTask;

}






              },
              height: 50.0,
              width: CustomWidth(context)-100,
              btnColor: AppColor.defaultcolor,

            )
          ],
        ),
      ),
    );
  }
}
