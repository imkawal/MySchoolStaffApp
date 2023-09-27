import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../../controller/exam_result_controller.dart';
import '../../controller/exam_schedule_controller.dart';
import '../../controller/grade_controller.dart';
import '../../helpers/app_manager.dart';
import '../../models/exam_schedule_response_model.dart';
import '../../models/grade_response_model.dart';
import '../../utils/appcolors_theme.dart';

class ExamResultScreen extends StatefulWidget {
  String? examid;
  String? inputype;
  String? maxmarks;
  String? subject;
  String? name;
  String? maxgrade;
  ExamResultScreen({Key? key, this.examid, this.inputype, this.subject, this.maxmarks, this.name, this.maxgrade})
      : super(key: key);

  @override
  State<ExamResultScreen> createState() => _ExamResultScreenState();
}

class _ExamResultScreenState extends State<ExamResultScreen> {
  final attendancecolorList = <Color>[
    const Color(0xffF5CEAA),
    const Color(0xffF2ABFE),
    const Color(0xffBAECEC),
    const Color(0xff9C93FF),
    const Color(0xff9A9A9A),
    const Color(0xffF5CEAA),
  ];

  ExamResultController examresultController = Get.find<ExamResultController>();

  GradeController gradeController = Get.find<GradeController>();

  GradeData? dropdownvalue;
  String datavalue = "";
  List<String> alphabets = [  "A",  "B",  "C",  "D",  "E",  "F",  "G",  "H",  "I",  "J",  "K",  "L",  "M",  "N",  "O",  "P",  "Q",  "R",  "S",  "T",  "U",  "V",  "W",  "X",  "Y",  "Z"  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: AppColors.darkblue,
          centerTitle: true,
          leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: Icon(
                Icons.arrow_back,
                color: AppColors.white,
              )),
          title: Text(
            'Enter Exam Result',
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 22, color: AppColors.white),
          ),
        ),
        backgroundColor: AppColors.screencolor,
        body: SingleChildScrollView(
          child: Obx(
            () => Form(
              key: examresultController.examresultformKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 45,
                        width: Get.width * 0.5,
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(width: 1.0, color: AppColors.darkblue),
                          ),
                        ),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 10,
                            ),
                            Image.asset("assets/images/trending-up.png"),
                            SizedBox(
                              width: 8,
                            ),
                            if (widget.maxmarks == "0") ...{
                              Text(
                                "Max. Grade : A+",
                                style: TextStyle(
                                    fontWeight: FontWeight.w700, fontSize: Get.width * 0.04, color: AppColors.darkblue),
                              ),
                            } else ...{
                              Text(
                                "Max. Marks : ${widget.maxmarks ?? " "}",
                                style: TextStyle(
                                    fontWeight: FontWeight.w700, fontSize: Get.width * 0.04, color: AppColors.darkblue),
                              ),
                            }
                          ],
                        ),
                      ),
                      Container(
                        height: 45,
                        width: Get.width * 0.5,
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(width: 1.0, color: AppColors.darkblue),
                            left: BorderSide(width: 1.0, color: AppColors.darkblue),
                          ),
                        ),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 10,
                            ),
                            Image.asset("assets/images/bookmark-alt.png"),
                            SizedBox(
                              width: 8,
                            ),
                            SizedBox(
                              width: Get.width * 0.35,
                              child: Text(
                                widget.subject ?? "",
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontWeight: FontWeight.w700, fontSize: Get.width * 0.04, color: AppColors.darkblue),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  Container(
                    height: 45,
                    width: Get.width * 0.999,
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(width: 1.0, color: AppColors.darkblue),
                        left: BorderSide(width: 1.0, color: AppColors.darkblue),
                      ),
                    ),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 10,
                        ),
                        Image.asset("assets/images/pencil-alt.png"),
                        SizedBox(
                          width: 8,
                        ),
                        Text(
                          widget.name ?? "",
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: Get.width * 0.04, color: AppColors.darkblue),
                        ),
                      ],
                    ),
                  ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     Text('Class Sec.- ${AppManager.dashController.restoreInchargeListModel().classSection == null?
                  //     AppManager.dashController.restoreClassInchargeListModel().classSection??''
                  //         : AppManager.dashController.restoreInchargeListModel().classSection??""}',
                  //       style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),),
                  //     if(AppManager.dashController.restoreInchargeListModel().classSection != null)...{
                  //       Text("Subject- ${AppManager.dashController.restoreInchargeListModel().subjectName}",
                  //         style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),),
                  //     }else...{
                  //       Text('')
                  //     }
                  //
                  //   ],
                  // ),
                  SizedBox(
                    height: Get.height * 0.02,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: Get.width * 0.03, right: Get.width * 0.03),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(top: Get.height * 0.03),
                              child: Text(
                                'Total Students- ${examresultController.examresultData.value.data?.length ?? ""}',
                                style: TextStyle(
                                    fontWeight: FontWeight.w800,
                                    fontSize: Get.width * 0.04,
                                    color: AppColors.textcolor),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Loader.show(context, progressIndicator: const CircularProgressIndicator());
                                if (examresultController.examresultformKey.currentState!.validate()) {
                                  examresultController.UpdateExamResultData(refresh: true, examtype: widget.inputype)
                                      .whenComplete(() => examresultController.getExamResultData(
                                          refresh: true, examschid: widget.examid));
                                }
                                Future.delayed(const Duration(seconds: 3), () {
                                  Loader.hide();
                                  //Navigator.pop(context);
                                  print("Loader is being shown after hide ${Loader.isShown}");
                                });
                              },
                              child: Container(
                                  height: Get.height * 0.054,
                                  width: Get.width * 0.3,
                                  decoration:
                                      BoxDecoration(color: AppColors.darkblue, borderRadius: BorderRadius.circular(10)),
                                  child: Center(
                                    child: Text(
                                      'Save',
                                      style: TextStyle(
                                          fontSize: Get.width * 0.045,
                                          fontWeight: FontWeight.w700,
                                          color: AppColors.white),
                                    ),
                                  )),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: Get.height * 0.007,
                        ),
                        Container(
                          width: Get.width,
                          height: 20,
                          decoration: BoxDecoration(color: AppColors.darkblue, borderRadius: BorderRadius.circular(10)),
                          child: Row(
                            children: [
                              SizedBox(
                                width: Get.width * 0.595,
                                child: Padding(
                                  padding: EdgeInsets.only(left: 20),
                                  child: Text(
                                    "Student",
                                    style: TextStyle(
                                        color: AppColors.screencolor, fontWeight: FontWeight.w500, fontSize: 13),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: Get.width * 0.215,
                                child: Text(
                                  "Admin",
                                  style: TextStyle(
                                      color: AppColors.screencolor, fontWeight: FontWeight.w500, fontSize: 13),
                                ),
                              ),
                              SizedBox(
                                width: Get.width * 0.1,
                                child: Text(
                                  "Mark",
                                  style: TextStyle(
                                      color: AppColors.screencolor, fontWeight: FontWeight.w500, fontSize: 13),
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: Get.width * 0.012),
                          child: ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              //separatorBuilder: (BuildContext context, int index) => SizedBox(height: Get.height*0.03,),
                              itemCount: examresultController.examresultData.value.data?.length,
                              itemBuilder: (BuildContext context, int index) {
                                var resultdata = examresultController.examresultData.value.data;
                                String str = resultdata?[index].obtainedMarks ?? "";
                                //replace subString
                                String result = str.replaceAll('.00', '');
                                String strs = resultdata?[index].otainController?.text ?? "";
                                //replace subString
                                String conresult = strs.replaceAll('.00', '0');
                                return Padding(
                                  padding: EdgeInsets.only(top: Get.height * 0.011),
                                  child: Container(
                                    height: Get.height * 0.12,
                                    width: Get.width * 0.87,
                                    padding: EdgeInsets.only(left: Get.width * 0.025),
                                    decoration: BoxDecoration(
                                        border: Border.all(color: AppColors.darkblue),
                                        // color: attendancecolorList[index % attendancecolorList.length],
                                        borderRadius: BorderRadius.circular(10)),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          width: Get.width * 0.55,
                                          child: Row(
                                            children: [
                                              CircleAvatar(
                                                radius: 22,
                                                backgroundImage: NetworkImage(resultdata?[index].studentPhoto ?? ""),
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  SizedBox(
                                                    width: Get.width * 0.3,
                                                    child: Text(
                                                      '${resultdata?[index].student ?? ""}',
                                                      style: TextStyle(
                                                          fontWeight: FontWeight.w700,
                                                          color: AppColors.textcolor,
                                                          fontSize: Get.width * 0.037),
                                                      overflow: TextOverflow.ellipsis,
                                                      maxLines: 1,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: Get.height * 0.006,
                                                  ),
                                                  Row(
                                                    children: [
                                                      Text('Roll No. :  ',
                                                          style: TextStyle(
                                                              fontWeight: FontWeight.w800, color: AppColors.textcolor,fontSize: Get.width * 0.037)),
                                                      Text('${resultdata?[index].rollNo ?? ""}',
                                                          style: TextStyle(
                                                              fontWeight: FontWeight.w700, color: AppColors.textcolor,fontSize: Get.width * 0.037)),
                                                    ],
                                                  )
                                                ],
                                              ),
                                              SizedBox(
                                                width: 0,
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                            width: Get.width * 0.14,
                                            child: Text(
                                              "#${resultdata?[index].admissionNo ?? ""}",
                                              style: TextStyle(fontWeight: FontWeight.w500, color: AppColors.darkblue),
                                            )),
                                        // SizedBox(width: Get.width*0.18,),
                                        //Icon(Icons.call),
                                        if (widget.inputype == "Marks") ...{
                                          Column(
                                            children: [
                                              Padding(
                                                padding:
                                                    EdgeInsets.only(bottom: Get.height * 0.01, top: Get.height * 0.03),
                                                child: Container(
                                                  height: Get.height * 0.055,
                                                  width: Get.width * 0.115,
                                                  //padding: EdgeInsets.only( right: Get.width*0.01),
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    border: Border.all(
                                                        color: examresultController.examresultData.value.data?[index].validationdata ==
                                                                'Wrong Marks'
                                                            ? AppColors.redcolor
                                                            : AppColors.darkblue,
                                                        width: 1.3),
                                                    borderRadius: BorderRadius.circular(10),
                                                  ),
                                                  child: TextFormField(
                                                    //textAlign: TextAlign.center,
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        color: AppColors.textcolor,
                                                        fontSize: 16,
                                                        fontWeight: FontWeight.w600),
                                                    controller: examresultController.examresultData.value.data?[index].otainController,
                                                    decoration: InputDecoration(
                                                      contentPadding: EdgeInsets.only(bottom: 4),
                                                      border: InputBorder.none,
                                                      // hintText: conresult
                                                    ),
                                                    validator: (value) {
                                                      // if (int.parse(value??"") >= maxmark) {
                                                      if (value == null || value.isEmpty) {
                                                        examresultController.examresultData.value.data?[index].validationdata = '';
                                                        setState(() {});
                                                        return null;
                                                      } else if (value.toUpperCase() == "AB" || value.toUpperCase() == "LV" ) {
                                                        examresultController.examresultData.value.data?[index].validationdata = '';
                                                        setState(() {});
                                                        return null;
                                                      } else {
                                                       if(value.toUpperCase() != "AB" && value.toUpperCase() != "LV" &&  !value.isNum){
                                                         value = "0";
                                                       }
                                                        double tempVal = double.parse(value ?? "0");
                                                        double maxmark = double.parse(widget.maxmarks ?? "0");
                                                        if (tempVal <= maxmark) {
                                                          examresultController
                                                              .examresultData.value.data?[index].validationdata = '';
                                                          return null;
                                                        }else {
                                                          examresultController.examresultData.value.data?[index]
                                                              .validationdata = 'Wrong Marks';
                                                          setState(() {});
                                                          return '';
                                                        }
                                                        return null;
                                                      }
                                                    },
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(right: Get.width * 0.002),
                                                child: Container(
                                                    // height: Get.height*0.01,
                                                    width: Get.width * 0.115,
                                                    //padding: EdgeInsets.only( right: Get.width*0.01),
                                                    child: Text(
                                                      examresultController
                                                              .examresultData.value.data?[index].validationdata ??
                                                          "",
                                                      style: TextStyle(
                                                          color: AppColors.redcolor,
                                                          overflow: TextOverflow.ellipsis,
                                                          fontSize: 10),
                                                    )),
                                              ),
                                            ],
                                          )
                                        } else ...{
                                          Container(
                                              height: Get.height * 0.055,
                                              //width: Get.width*0.15,
                                              padding: EdgeInsets.only(left: Get.width * 0.01),
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                border: Border.all(color: AppColors.darkblue, width: 1.3),
                                                borderRadius: BorderRadius.circular(6.0),
                                              ),
                                              child: Obx(()=>
                                                 DropdownButton<GradeData>(
                                                     hint: Text(
                                                       "Grade",
                                                     ),
                                                    items: gradeController.graderesData.value.data?.map((item) {
                                                      return DropdownMenuItem<GradeData>(
                                                        child: SizedBox(
                                                            width: Get.width * 0.06,
                                                            child: Center(
                                                            child: Text(item.grade ?? "Grade",
                                                            textAlign: TextAlign.center,))),
                                                        value: item,
                                                      );
                                                    }).toList(),
                                                    onChanged: (newVal) {
                                                      setState(() {
                                                        examresultController
                                                            .examresultData.value.data?[index].obtainedGrade = newVal;
                                                        examresultController.examresultData.value.data?[index]
                                                            .gradeController?.text = newVal?.recordId ?? "";
                                                      });
                                                    },
                                                    underline: DropdownButtonHideUnderline(child: Container()),
                                                    value: examresultController.examresultData.value.data![index].obtainedGrade?.recordId !=
                                                            null
                                                        ? gradeController.graderesData.value.data?.where((element) =>
                                                                element.recordId ==
                                                                examresultController.examresultData.value.data![index]
                                                                    .obtainedGrade?.recordId).toList().first
                                                        : dropdownvalue
                                                   // gradeController.graderesData.value.data?.first
                                                    ),
                                              ))
                                        },

                                        SizedBox(
                                          width: Get.width * 0.01,
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
