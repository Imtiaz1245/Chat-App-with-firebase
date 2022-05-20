import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebaseflutter/ApplicationModule/ChatModule/ViewController/chat_view_controller.dart';
import 'package:firebaseflutter/ApplicationModule/ChatModule/Model/usermodel.dart';
import 'package:firebaseflutter/ApplicationModule/Utills/app_colors.dart';
import 'package:firebaseflutter/ApplicationModule/Utills/custom_navigator.dart';
import 'package:firebaseflutter/ApplicationModule/Utills/default_text_view.dart';
import 'package:firebaseflutter/ApplicationModule/Utills/height_width.dart';
import 'package:flutter/material.dart';

class AllUsersView extends StatefulWidget {
  const AllUsersView({Key? key}) : super(key: key);

  @override
  State<AllUsersView> createState() => _AllUsersViewState();
}

class _AllUsersViewState extends State<AllUsersView> {
  var usersdata = FirebaseFirestore.instance
      .collection("Users")
      .doc("${FirebaseAuth.instance.currentUser!.email.toString().trim()}")
      .collection("MyUser")
      .snapshots();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: usersdata,
        builder: (BuildContext context, snapshot) {
          List<UserModel> allUserList = <UserModel>[];
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(
                color: Colors.red,
                backgroundColor: Colors.blue,
              ),
            );
          }
          allUserList = UserModel.JsonToListView(snapshot.data!.docs);

          return ListView.builder(
            itemCount: allUserList.length,
            itemBuilder: (context, index) {
              return Container(
                height: 80,
                width: CustomWidth(context),
                color: AppColor.white,
                child: InkWell(
                  onTap: () {
                    CustomNavigator(
                        context,
                        ChatViewController(
                          useremail: allUserList[index].email,
                          userName: allUserList[index].name,
                          FCMToken: allUserList[index].FCMToken,
                          photourl: allUserList[index].photoUrl,
                        ));

                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 5),
                    child: Row(
                      children: [
                        SizedBox(
                          height: 70,
                          width: 70,
                          child: CircleAvatar(
                              backgroundImage: NetworkImage(
                            "${allUserList[index].photoUrl}",
                          )),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 5),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: CustomWidth(context) - 95,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    DefaultTextView(
                                      text: "${allUserList[index].name}",
                                      textcolor: AppColor.grey,
                                      fontweight: FontWeight.bold,
                                      fontSize: 17.0,
                                    ),
                                    DefaultTextView(
                                      text: "2:20:pm",
                                      textcolor: AppColor.grey,
                                      fontSize: 15.0,
                                    ),
                                  ],
                                ),
                              ),
                              DefaultTextView(
                                text: "How Are You?",
                                textcolor: AppColor.grey,
                                fontSize: 15.0,
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        });
  }
}
