import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/class_subject_controller.dart';
import '../../controller/live_classes_controller.dart';
import '../../helpers/app_manager.dart';
import '../../models/class_subject_response_model.dart';
import '../../utils/app_button.dart';
import '../../utils/appcolors_theme.dart';
import '../../utils/appstrings.dart';
import '../../utils/apptext_field.dart';

class CreateLiveClassScreen extends StatefulWidget {
   CreateLiveClassScreen({Key? key}) : super(key: key);

  @override
  State<CreateLiveClassScreen> createState() => _CreateLiveClassScreenState();
}

class _CreateLiveClassScreenState extends State<CreateLiveClassScreen> {
  LiveClassController liveClassController = Get.find<LiveClassController>();

   ClassSubjectController classSubjectController = Get.find<ClassSubjectController>();

   ClassSubjectData? dropdownvalue;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
                    padding: const EdgeInsets.only(top: 8),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(width: Get.width*0.01,),
                        IconButton(
                            onPressed: () {
                              Get.back();
                            },
                            icon: const Icon(
                              Icons.close,
                              color: AppColors.white,
                            )),
                        const Padding(
                          padding: EdgeInsets.only(top: 10),
                          child: Text(
                            'Create Live Class',
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: AppColors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                Padding(
                  padding: EdgeInsets.only(top: Get.height * 0.08, left: Get.width * 0.03, right:Get.width * 0.03, bottom: Get.height * 0.03 ),
                  child: Container(
                    alignment: Alignment.center,
                    width: Get.width * 0.99,
                    height: Get.height * 0.8,
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Class Sec.- ${AppManager.dashController.restoreInchargeListModel().classSection == null?
                            AppManager.dashController.restoreClassInchargeListModel().classSection??''
                                : AppManager.dashController.restoreInchargeListModel().classSection??""}',
                              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),),
                            if(AppManager.dashController.restoreInchargeListModel().classSection != null)...{
                              Text("Subject- ${AppManager.dashController.restoreInchargeListModel().subjectName}",
                                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),),
                            }else...{
                              Text('')
                            }

                          ],
                        ),
                        SizedBox(
                          height: Get.height * 0.03,
                        ),
                         AssignmentTextField(
                          hintText: " Title",
                          controller: liveClassController.headdingController,
                          // validator: validateEmail,
                        ),
                        if(AppManager.dashController.restoreInchargeListModel().classSection == null)...{
                          Obx(()=>
                              Padding(
                                padding:  EdgeInsets.only(top: Get.height*0.02),
                                child: Container(
                                  height: Get.height*0.065,
                                  width: Get.width*0.81,
                                  padding: EdgeInsets.only(left: Get.width*0.025),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: AppColors.backgroundpurple),
                                    borderRadius: BorderRadius.circular(6.0),
                                  ),
                                  child: DropdownButton(
                                    items: classSubjectController.classsuubjectresData.value.data?.map((item) {
                                      return  DropdownMenuItem<ClassSubjectData>(
                                        child:  SizedBox(
                                            width: Get.width*0.68,
                                            child: Text(item.subject??'Choose Subject')),
                                        value: item,
                                      );
                                    }).toList(),
                                    onChanged: ( newVal) {
                                      setState(() {
                                        // saveeventcon.currencyController.text = newVal.toString();
                                        //  print(saveeventcon.currencyController.text);
                                        dropdownvalue = newVal as ClassSubjectData;
                                        liveClassController.subectidd.value = newVal.classSubjectId??"";
                                      });
                                    },
                                    underline: DropdownButtonHideUnderline(child: Container()),
                                    value: dropdownvalue??classSubjectController.classsuubjectresData.value.data?.first,
                                  ),
                                ),
                              ),)
                        }else...{
                          SizedBox.shrink()
                        },
                        SizedBox(
                          height: Get.height * 0.028,
                        ),
                         AssignmentTextField(
                          hintText: "Start Date",
                          controller: liveClassController.startdateController,
                          // validator: validateEmail,
                        ),
                        SizedBox(
                          height: Get.height * 0.028,
                        ),
                         AssignmentTextField(
                          hintText: "Duration in minutes",
                          controller: liveClassController.durationController,
                          // validator: validateEmail,
                        ),
                        SizedBox(
                          height: Get.height * 0.032,
                        ),
                        const AssignmentTextField(
                          hintText: "Paste the link of live class",
                          //controller: con.userNameController,
                          // validator: validateEmail,
                        ),
                        SizedBox(
                          height: Get.height * 0.09,
                        ),

                        AppButton(
                            buttonName: "Create Live Class",
                            onTap: (){
                              liveClassController.addLiveClassData(refresh: true,
                                  classsectionid: AppManager.dashController.restoreInchargeListModel().classSectionId == null?
                                  AppManager.dashController.restoreClassInchargeListModel().classSectionId??''
                                      : AppManager.dashController.restoreInchargeListModel().classSectionId??"",
                                  classsubjectid: AppManager.dashController.restoreInchargeListModel().classSubjectId??""
                              );
                            },
                            isIconShow: false,
                            height: Get.height*0.071,
                            fontSize: 18,
                            fontweight: FontWeight.w600,
                            width: Get.width* 0.8,
                            backgroundColor: AppColors.backgroundpurple,
                            //iconColor: AppColors.bluishBlack,
                            textColor: const Color(0xffFFFFFF)),

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
