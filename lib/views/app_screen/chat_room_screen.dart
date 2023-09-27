import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/appcolors_theme.dart';
import '../../utils/drawer_widget.dart';

class ChatRoomScreen extends StatelessWidget {
  ChatRoomScreen({Key? key}) : super(key: key);
  final GlobalKey<ScaffoldState> chatroomscaffoldEy = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: chatroomscaffoldEy,
        drawer: DrawerElement(),
        body: SizedBox(
          height: Get.height*0.9999,
          child: SingleChildScrollView(
            child: Stack(
              children: [
                Container(
                  height: Get.height * 0.34,
                  decoration: const BoxDecoration(
                    color: AppColors.backgroundpurple,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(width: Get.width*0.01,),
                      IconButton(
                          onPressed: (){
                            chatroomscaffoldEy.currentState!.openDrawer();
                          },
                          icon: Icon(Icons.menu, color: AppColors.white,)
                      ),
                        const Padding(
                          padding: EdgeInsets.only(top: 10),
                          child: Text(
                            'Chat Room',
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: AppColors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                Padding(
                  padding: EdgeInsets.only(top: Get.height * 0.09, left: Get.width * 0.045, right:Get.width * 0.045 ),
                  child: Container(
                    alignment: Alignment.center,
                    width: Get.width * 0.99,
                    height: Get.height * 0.82,
                    padding: EdgeInsets.only(left: Get.width*0.05, right: Get.width*0.065, top: Get.height*0.03),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.grey,
                          offset: Offset(
                            1.0,
                            1.0,
                          ),
                          blurRadius: 3.0,
                          spreadRadius: 1.0,
                        ), //BoxShadow
                        BoxShadow(
                          color: Colors.white,
                          offset: Offset(0.0, 0.0),
                          blurRadius: 0.0,
                          spreadRadius: 0.0,
                        ), //BoxShadow
                      ],
                      // color: Colors.pink.shade200,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: Get.height * 0.01,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
