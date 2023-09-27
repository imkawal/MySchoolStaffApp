import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/appcolors_theme.dart';

class DeatailScreen extends StatelessWidget {
  String? name;
  String? exam;
  String? subject;
  String? classsection;
  String? description;
  String? maxmarks;
  String? date;
  String? lastdate;
   DeatailScreen({Key? key, this.date, this.exam, this.description, this.name, this.lastdate, this.maxmarks,
  this.subject, this.classsection}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.screencolor,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: AppColors.darkblue,
          centerTitle: true,
          leading:  IconButton(
              onPressed: (){
                Get.back();
              },
              icon: const Icon(Icons.arrow_back_ios, color: AppColors.white,)
          ),
          title: const Text('Detail Screen',
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 22, color: AppColors.white),),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding:  EdgeInsets.only(left: Get.width*0.05, right: Get.width*0.05),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: Get.height*0.03,),
                Row(
                  children: [
                    Text("Name : ",
                      style: TextStyle(fontSize: 19, fontWeight: FontWeight.w800, color: AppColors.black),),
                    Text(name??"",
                      style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500, color: AppColors.darkblue),)
                  ],
                ),

                SizedBox(height: Get.height*0.015,),
                Row(
                  children: [
                    Text("Class Section : ",
                      style: TextStyle(fontSize: 19, fontWeight: FontWeight.w800, color: AppColors.black),),
                    Text(classsection??"",
                      style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500, color: AppColors.darkblue),)
                  ],
                ),
                SizedBox(height: Get.height*0.015,),
                Row(
                  children: [
                    Text("Subject : ",
                      style: TextStyle(fontSize: 19, fontWeight: FontWeight.w800, color: AppColors.black),),
                    Text(subject??"",
                      style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500, color: AppColors.darkblue),)
                  ],
                ),

                date == null?SizedBox.shrink():
                Column(
                  children: [
                    SizedBox(height: Get.height*0.015,),
                    Row(
                      children: [
                        Text("Date : ",
                          style: TextStyle(fontSize: 19, fontWeight: FontWeight.w800, color: AppColors.black),),
                        Text(date??"",
                          style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500, color: AppColors.darkblue),)
                      ],
                    ),
                  ],
                ),
                lastdate == null?SizedBox.shrink():
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: Get.height*0.015,),
                    Row(
                      children: [
                        Text("Last Date of Submission : ",
                          style: TextStyle(fontSize: 19, fontWeight: FontWeight.w800, color: AppColors.black),),
                        Text(lastdate??"",
                          style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500, color: AppColors.darkblue),)
                      ],
                    ),
                  ],
                ),

                maxmarks == null?SizedBox.shrink():
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: Get.height*0.015,),
                    Row(
                      children: [
                        Text("Max. Marks : ",
                          style: TextStyle(fontSize: 19, fontWeight: FontWeight.w800, color: AppColors.black),),
                        Text(maxmarks??"",
                          style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500, color: AppColors.darkblue),)
                      ],
                    ),
                  ],
                ),

                description == null ?SizedBox.shrink()
                    : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: Get.height*0.015,),
                    Text("Description : ",
                      style: TextStyle(fontSize: 19, fontWeight: FontWeight.w800, color: AppColors.black),),
                    SizedBox(height: Get.height*0.01,),
                    Padding(
                      padding:  EdgeInsets.only(left: Get.width*0.25),
                      child: Text(description??"",
                        maxLines: 4,
                        style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500, color: AppColors.darkblue),),
                    ),
                  ],
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
