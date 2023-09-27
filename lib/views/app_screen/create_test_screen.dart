import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../controller/class_subject_controller.dart';
import '../../controller/class_test_controller.dart';
import '../../controller/grade_controller.dart';
import '../../helpers/app_manager.dart';
import '../../models/class_subject_response_model.dart';
import '../../models/grade_response_model.dart';
import '../../utils/app_button.dart';
import '../../utils/appcolors_theme.dart';
import '../../utils/appstrings.dart';
import '../../utils/apptext_field.dart';

class CreateTestScreen extends StatefulWidget {
   CreateTestScreen({Key? key}) : super(key: key);

  @override
  State<CreateTestScreen> createState() => _CreateTestScreenState();
}

class _CreateTestScreenState extends State<CreateTestScreen> {
  ClassTestController classTestController = Get.put(ClassTestController());

   DateTime date = DateTime.now();

   var formattedDate;

   @override
   void initState() {
     formattedDate = DateFormat('dd/MM/yyyy').format(date);
     print(formattedDate);
   }

  //GradeController gradeController = Get.find<GradeController>();
  ClassSubjectController classSubjectController = Get.find<ClassSubjectController>();

   //GradeData? dropdownvalue;
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
                            'Create Test',
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: AppColors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: Get.height * 0.08, left: Get.width * 0.03, right:Get.width * 0.03 ),
                  child: Container(
                    alignment: Alignment.center,
                    width: Get.width * 0.99,
                    height: Get.height * 0.83,
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
                          height: Get.height * 0.03,
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
                          height: Get.height * 0.02,
                        ),
                        AssignmentTextField(
                          hintText: AppStrings.testtitle,
                          controller: classTestController.titleController,
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
                                         classTestController.classsubjectidContoller.value = newVal.classSubjectId??"";
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
                        Container(
                            height: Get.height*0.07,
                            width: Get.width*0.8,
                            decoration: BoxDecoration(
                                border: Border.all(color: AppColors.backgroundpurple),
                                borderRadius: BorderRadius.circular(6)
                            ),
                            child: TextFormField(
                                textAlign: TextAlign.start,
                                controller: classTestController.dateController,
                                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700,
                                    color: AppColors.black), //editing controller of this TextField
                                decoration:  InputDecoration(
                                  hintText: formattedDate,
                                  hintStyle: TextStyle(fontSize: 15, fontWeight: FontWeight.w700,
                                      color: AppColors.black),
                                  contentPadding: EdgeInsets.only(bottom: Get.height*0.0, left: Get.width*0.038),
                                  border: InputBorder.none,
                                ),
                                readOnly: true,  // when true user cannot edit text
                                onTap: () async {
                                  DateTime? pickedDate = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(), //get today's date
                                    firstDate:DateTime(1988), //DateTime.now() - not to allow to choose before today.
                                    lastDate: DateTime(2500),
                                    helpText: 'Campaign Date Picker'.toUpperCase(),
                                  );
                                  if(pickedDate != null ){
                                    // print(pickedDate);  //get the picked date in the format => 2022-07-04 00:00:00.000
                                    String formattedDate = DateFormat('dd/MM/yyyy').format(pickedDate); // format date in required form here we use yyyy-MM-dd that means time is removed
                                    print(formattedDate); //formatted date output using intl package =>  2022-07-04
                                    //You can format date as per your need
                                    classTestController.dateController.text = formattedDate;
                                  }else{
                                    Text('Test Date');
                                  }
                                }
                            )
                          // Center(child: Text('24/08/2022',
                          //   style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700,
                          //       color: AppColors.black),)),
                        ),
                        SizedBox(
                          height: Get.height * 0.032,
                        ),
                        AssignmentTextField(
                          hintText: "Maximum Marks",
                          controller: classTestController.maxgradeController,
                          // validator: validateEmail,
                        ),
                        SizedBox(
                          height: Get.height * 0.032,
                        ),
                        SizedBox(
                          height: Get.height * 0.15,
                        ),
                        AppButton(
                            buttonName: "Create Test",
                            onTap: (){
                              classTestController.createclassTest(refresh: true,
                                classsectionid: AppManager.dashController.restoreInchargeListModel().classSectionId == null?
                                AppManager.dashController.restoreClassInchargeListModel().classSectionId??''
                                    : AppManager.dashController.restoreInchargeListModel().classSectionId??"",
                                classsubjectid: AppManager.dashController.restoreInchargeListModel().classSubjectId??""
                              );
                              classTestController.getclassTestData(refresh: true);
                            },
                            isIconShow: false,
                            height: Get.height*0.071,
                            fontSize: 18,
                            fontweight: FontWeight.w600,
                            width: Get.width* 0.8,
                            backgroundColor: AppColors.backgroundpurple,
                            //iconColor: AppColors.bluishBlack,
                            textColor: const Color(0xffFFFFFF)),
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
