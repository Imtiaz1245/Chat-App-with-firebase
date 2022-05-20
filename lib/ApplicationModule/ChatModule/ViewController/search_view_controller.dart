import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebaseflutter/ApplicationModule/ChatModule/ViewController/chat_view_controller.dart';
import 'package:firebaseflutter/ApplicationModule/ChatModule/Model/usermodel.dart';
import 'package:firebaseflutter/ApplicationModule/Utills/app_colors.dart';
import 'package:firebaseflutter/ApplicationModule/Utills/custom_navigator.dart';
import 'package:firebaseflutter/ApplicationModule/Utills/default_text_form_field.dart';
import 'package:firebaseflutter/ApplicationModule/Utills/default_text_view.dart';
import 'package:firebaseflutter/ApplicationModule/Utills/height_width.dart';
import 'package:flutter/material.dart';
class SearchViewController extends StatefulWidget {
  const SearchViewController({Key? key}) : super(key: key);

  @override
  State<SearchViewController> createState() => _SearchViewControllerState();
}

class _SearchViewControllerState extends State<SearchViewController> {

  String name = "", email = "imtaiz@gmail.com",FCMToken="",PhotoUrl="";
  TextEditingController searchcontroller = TextEditingController();
  var usersdata = FirebaseFirestore.instance.collection("Users").snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          height: CustomHeight(context),
          width: CustomWidth(context),
          child: Column(

            children: [
              SizedBox(height: 20,),
            Row(
              children: [
                DefaultTextFormFieldView(height: 50.0, width: CustomWidth(context)-100,hint: "Search",controller: searchcontroller,),
                IconButton(onPressed: (){

                  setState(() {
                    email=searchcontroller.text.trim();
                  });
                }, icon: Icon(Icons.search)),
              ],
            ),

              SizedBox(
                height: 200,
                child: StreamBuilder<QuerySnapshot>(
                    stream: usersdata,
                    builder: (BuildContext context, snapshot) {
                      List<UserModel> allUserList = <UserModel>[];
                      if (!snapshot.hasData) {
                        return Center(
                          child: CircularProgressIndicator(
                            color: Colors.red, backgroundColor: Colors.blue,),
                        );
                      }
                      allUserList=UserModel.JsonToListView(snapshot.data!.docs);
                      allUserList=allUserList.where((element) => element.email.toLowerCase()==email.toString().toLowerCase()).toList();

                      return ListView.builder(
                        itemCount: allUserList.length,
                        itemBuilder: (context, index) {
                          return Container(
                            height: 80,
                            width: CustomWidth(context),
                            color: AppColor.white,
                            child: InkWell(
                              onTap: () {
                                CustomNavigator(context, ChatViewController(useremail: allUserList[index].email,userName: allUserList[index].name,FCMToken: allUserList[index].FCMToken,photourl: allUserList[index].photoUrl,));
                              },
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 5),
                                child: Row(
                                  children: [
                                    SizedBox(
                                      height: 70,
                                      width: 70,
                                      child: CircleAvatar(
                                          backgroundImage: AssetImage(
                                            "assets/images/imtiaz.jpg",
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
                                            text: "${allUserList[index].email}",
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
                    }),
              )
            ]
      )
    )
    )
    );
  }
}
