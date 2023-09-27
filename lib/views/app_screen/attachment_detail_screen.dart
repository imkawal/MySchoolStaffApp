import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/appcolors_theme.dart';

class AttachmentDetailScreen extends StatelessWidget {
  String? name;
  String? exam;
  String? subject;
  String? classsection;
  String? description;
  String? maxmarks;
  String? date;
  String? imgelink;
  String? videolink;
  String? audiolink;
  String? pdflink;
  String? lastdate;
  AttachmentDetailScreen({Key? key, this.subject, this.audiolink, this.classsection, this.date, this.description,
  this.exam, this.imgelink, this.maxmarks, this.name, this.pdflink, this.videolink, this.lastdate}) : super(key: key);

  //name
  //exam
  //subject
  //class
  //descpription
  //attachment
  //max.marks
  //date

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

                  SizedBox(height: Get.height*0.015,),
                  if(imgelink == "" && imgelink!.isEmpty)...{
                    SizedBox.shrink()
                  } else if(videolink == "" && videolink!.isEmpty)...{
                    SizedBox.shrink()
                  }else if(audiolink == "" && audiolink!.isEmpty)...{
                    SizedBox.shrink()
                  }else if(pdflink == "" && pdflink!.isEmpty)...{
                    SizedBox.shrink()
                  }
                  else...{
                     Text("Attachment : ",
                      style: TextStyle(fontSize: 19, fontWeight: FontWeight.w800, color: AppColors.black),),
                  },

                  imgelink == ""  ? SizedBox.shrink():
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: Get.height*0.015,),
                      Row(
                        children: [
                          Text("Image : ",
                            style: TextStyle(fontSize: 19, fontWeight: FontWeight.w800, color: AppColors.black),),
                          Text(imgelink??"",
                            style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500, color: AppColors.darkblue),)
                        ],
                      ),
                    ],
                  ),

                  videolink == "" && videolink!.isEmpty ?SizedBox.shrink():
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: Get.height*0.015,),
                      Row(
                        children: [
                          Text("Video : ",
                            style: TextStyle(fontSize: 19, fontWeight: FontWeight.w800, color: AppColors.black),),
                          Text(videolink??"",
                            style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500, color: AppColors.darkblue),)
                        ],
                      ),
                    ],
                  ),

                 audiolink == "" && audiolink!.isEmpty ?SizedBox.shrink():
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: Get.height*0.015,),
                      Row(
                        children: [
                          Text("Audio : ",
                            style: TextStyle(fontSize: 19, fontWeight: FontWeight.w800, color: AppColors.black),),
                          Text(audiolink??"",
                            style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500, color: AppColors.darkblue),)
                        ],
                      ),
                    ],
                  ),

                  pdflink == "" && pdflink!.isEmpty ?SizedBox.shrink():
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: Get.height*0.015,),
                      Row(
                        children: [
                          Text("Pdf : ",
                            style: TextStyle(fontSize: 19, fontWeight: FontWeight.w800, color: AppColors.black),),
                          Text(pdflink??"",
                            style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500, color: AppColors.darkblue),)
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
    );
  }
}
