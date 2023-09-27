import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:get/get.dart';

import '../../controller/class_test_result_controller.dart';
import '../../helpers/app_manager.dart';
import '../../utils/appcolors_theme.dart';
import '../../utils/appstrings.dart';
import '../../utils/apptext_field.dart';
import '../../utils/drawer_widget.dart';

class ClassTestResultScreen extends StatefulWidget {
  String? classtestid;
  String? maxmarks;
  String? subject;
  String? name;
  ClassTestResultScreen({Key? key, this.classtestid, this.name, this.subject, this.maxmarks}) : super(key: key);

  @override
  State<ClassTestResultScreen> createState() => _ClassTestResultScreenState();
}

class _ClassTestResultScreenState extends State<ClassTestResultScreen> {
 // final GlobalKey<ScaffoldState> examEy = GlobalKey<ScaffoldState>();
  String? valueText = '';
  final attendancecolorList = <Color>[
    const Color(0xffF5CEAA),
    const Color(0xffF2ABFE),
    const Color(0xffBAECEC),
    const Color(0xff9C93FF),
    const Color(0xff9A9A9A),
    const Color(0xffF5CEAA),
  ];

  ClassTestResultController classTestResultController = Get.find<ClassTestResultController>();

  String datavalue ="";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: AppColors.darkblue,
          centerTitle: true,
          leading:  IconButton(
              onPressed: (){
                Get.back();
              },
              icon: Icon(Icons.arrow_back, color: AppColors.white,)
          ),
          title: Text( 'Enter Test Result',
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 22, color: AppColors.white),),
        ),
        backgroundColor: AppColors.screencolor,
        body: SingleChildScrollView(
          child: Obx(()=>
              Form(
                key: classTestResultController.classtestformKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: 45,
                          width: Get.width*0.5,
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(width: 1.0, color: AppColors.darkblue),
                            ),
                          ),
                          child: Row(
                            children: [
                              SizedBox(width: Get.width*0.01,),
                              Image.asset("assets/images/trending-up.png"),
                              SizedBox(width: 8,),
                              Text("Max. Marks : ${widget.maxmarks??" "}",
                                style: TextStyle(fontWeight: FontWeight.w700, fontSize: Get.width * 0.038,
                                    color: AppColors.darkblue),),
                            ],
                          ),
                        ),
                         Container(
                          height: 45,
                          width: Get.width*0.5,
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(width: 1.0, color: AppColors.darkblue),
                              left: BorderSide(width: 1.0, color: AppColors.darkblue),
                            ),
                          ),
                          child: Row(
                            children: [
                              SizedBox(width: Get.width*0.01,),
                              Image.asset("assets/images/bookmark-alt.png"),
                              SizedBox(width: 8,),
                              Text(widget.subject??"",
                                style: TextStyle(fontWeight: FontWeight.w700, fontSize: Get.width * 0.038,
                                    color: AppColors.darkblue),),
                            ],
                          ),
                        )
                      ],
                    ),
                    Container(
                      height: 45,
                      width: Get.width*0.999,
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(width: 1.0, color: AppColors.darkblue),
                          left: BorderSide(width: 1.0, color: AppColors.darkblue),
                        ),
                      ),
                      child: Row(
                        children: [
                          SizedBox(width: Get.width*0.01,),
                          Image.asset("assets/images/pencil-alt.png"),
                          SizedBox(width: 8,),
                          Text(widget.name??"",
                            style: TextStyle(fontWeight: FontWeight.w600, fontSize: Get.width * 0.038,
                                color: AppColors.darkblue),),
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
                      height: Get.height * 0.01,
                    ),


                    Padding(
                      padding: EdgeInsets.only(left: Get.width * 0.03, right:Get.width * 0.03 ),
                      child: Column(
                        children: [
                          Row(

                            children: [
                              Text("Absent : AB",
                                  style: TextStyle(fontWeight: FontWeight.w800, fontSize: Get.width * 0.04, color: AppColors.textcolor)),
                              SizedBox(width: Get.width*0.43,),
                              Text("Leave : LV",
                                  style: TextStyle(fontWeight: FontWeight.w800, fontSize: Get.width * 0.04, color: AppColors.textcolor))
                            ],
                          ),
                          SizedBox(
                            height: Get.height * 0.01,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding:  EdgeInsets.only(top: Get.height*0.03),
                                child: Text('Total Students- ${classTestResultController.classtestresultresData.value.studentCount}',
                                  style: TextStyle(fontWeight: FontWeight.w800, fontSize: Get.width * 0.04, color: AppColors.textcolor),),
                              ),
                              GestureDetector(
                                onTap: (){
                                  Loader.show(context,
                                      progressIndicator: const CircularProgressIndicator());
                                  if(classTestResultController.classtestformKey.currentState!.validate()){
                                    classTestResultController.getUpdateClassTestResultData(refresh: true).
                                    whenComplete(() => classTestResultController.getClassTestResultData(
                                        refresh: true,
                                        classtestid: widget.classtestid));
                                  }
                                  Future.delayed(const Duration(seconds: 3), () {
                                    Loader.hide();
                                    //Navigator.pop(context);
                                    print("Loader is being shown after hide ${Loader.isShown}");
                                  });
                                },
                                child: Container(
                                    height: Get.height*0.054,
                                    width: Get.width*0.3,
                                    decoration: BoxDecoration(
                                        color: AppColors.darkblue,
                                        borderRadius: BorderRadius.circular(10)
                                    ),
                                    child: Center(
                                      child: Text('Save',
                                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: AppColors.white),),
                                    )
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: Get.height*0.007,),
                          Container(
                            width: Get.width,
                            height: 20,
                            decoration: BoxDecoration(
                              color: AppColors.darkblue,
                              borderRadius: BorderRadius.circular(10)
                            ),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: Get.width*0.595,
                                  child: Padding(
                                    padding:  EdgeInsets.only(left: 20),
                                    child: Text("Student",
                                    style: TextStyle(color: AppColors.screencolor,fontWeight: FontWeight.w500,
                                    fontSize: 13),),
                                  ),
                                ),
                                SizedBox(
                                  width: Get.width*0.215,
                                  child: Text("Admin",
                                    style: TextStyle(color: AppColors.screencolor,fontWeight: FontWeight.w500,
                                        fontSize: 13),),
                                ),
                                SizedBox(
                                  width: Get.width*0.1,
                                  child: Text("Mark",
                                    style: TextStyle(color: AppColors.screencolor,fontWeight: FontWeight.w500,
                                        fontSize: 13),),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding:  EdgeInsets.only(left: Get.width*0.012),
                            child: ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              // separatorBuilder: (BuildContext context, int index) => SizedBox(height: Get.height*0.03,),
                                itemCount: classTestResultController.classtestresultresData.value.data?.length,
                                itemBuilder: (BuildContext context, int index) {
                                  var resultdata= classTestResultController.classtestresultresData.value.data;
                                  //_controllers.add(new TextEditingController());
                                  String str = resultdata?[index].obtainedMarks??"";
                                  //replace subString
                                  String result = str.replaceAll('.00', '');
                                  String obtain = resultdata?[index].otainController?.text??"";
                                  String obtainresult = obtain.replaceAll('.00', '');
                                  return Padding(
                                    padding:  EdgeInsets.only(top: Get.height*0.011),
                                    child: Container(
                                      height: Get.height*0.12,
                                      width: Get.width*0.87,
                                      padding: EdgeInsets.only(left: Get.width*0.025),
                                      decoration: BoxDecoration(
                                        border: Border.all(color: AppColors.darkblue),
                                          //color: attendancecolorList[index % attendancecolorList.length],
                                          borderRadius: BorderRadius.circular(10)
                                      ),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          SizedBox(
                                            width: Get.width*0.55,
                                            child: Row(
                                              children: [
                                                CircleAvatar(
                                                  radius: 22,
                                                  backgroundImage: NetworkImage(resultdata?[index].studentPhoto??""),
                                                ),
                                                SizedBox(width: 20,),
                                                Column(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    SizedBox(
                                                      width: Get.width*0.3,
                                                      child: Text('${resultdata?[index].name}',
                                                        style: TextStyle(fontWeight: FontWeight.w700,color: AppColors.textcolor, fontSize: 15),
                                                        overflow: TextOverflow.ellipsis,
                                                        maxLines: 1,),),
                                                    SizedBox(height: Get.height*0.006,),
                                                    Row(
                                                      children: [
                                                        Text('Roll no. : ',
                                                          style: TextStyle(fontWeight: FontWeight.w800, color: AppColors.textcolor),),
                                                        Text('${resultdata?[index].rollNo}',
                                                          style: TextStyle(fontWeight: FontWeight.w700, color: AppColors.textcolor),),
                                                      ],
                                                    )

                                                  ],
                                                ),
                                                SizedBox(width: 10,),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            width: Get.width*0.2,
                                              child: Text("#${resultdata?[index].admissionNo??""}",
                                                style: TextStyle(fontWeight: FontWeight.w500, color: AppColors.darkblue),)),

                                          // SizedBox(width: Get.width*0.18,),
                                          //Icon(Icons.call),
                                          Column(
                                            children: [
                                              SizedBox(height: Get.height*0.025,),
                                              Container(
                                                height: Get.height*0.06,
                                                width: Get.width*0.12,
                                                padding: EdgeInsets.only(bottom: Get.height*0.00),
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  border: Border.all(color: classTestResultController.classtestresultresData.value.data?[index].validationdata == "Wrong Marks"?AppColors.redcolor:AppColors.darkblue,width: 1.3),
                                                  borderRadius: BorderRadius.circular(10),
                                                ),
                                                child: TextFormField(
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(color: AppColors.textcolor,
                                                      fontSize: 16, fontWeight: FontWeight.w600),
                                                  controller: classTestResultController.classtestresultresData.value.data?[index].otainController,
                                                  decoration: InputDecoration(
                                                      border: InputBorder.none,
                                                      contentPadding: EdgeInsets.only(bottom: 6),
                                                    //hintText: valueText
                                                  //     errorBorder:
                                                  // OutlineInputBorder(borderSide: BorderSide(color: Colors.red))
                                                  ),
                                                  // onChanged: (value) {
                                                  //   setState(() {
                                                  //     valueText = classTestResultController.classtestresultresData.value.data?[index].otainController!.text.replaceAll(".00", "");
                                                  //   });
                                                  //   print(valueText);
                                                  // },
                                                  validator: (value) {
                                                    // if (int.parse(value??"") >= maxmark) {
                                                    if(value == null || value.isEmpty){
                                                      classTestResultController.classtestresultresData.value.data?[index].validationdata ="";
                                                      setState(() {});
                                                      return null;
                                                    }
                                                    // else if(value.toUpperCase() != "AB" || value.toUpperCase() != "LV" ){
                                                    //   classTestResultController.classtestresultresData.value.data?[index].validationdata = '';
                                                    //   setState(() {});
                                                    //   return null;
                                                    // }
                                                    else if(value.toUpperCase() == "AB" || value.toUpperCase() == "LV" ){
                                                      classTestResultController.classtestresultresData.value.data?[index].validationdata = '';
                                                      setState(() {});
                                                      return null;
                                                    }else {
                                                      if(value.toUpperCase() != "AB" && value.toUpperCase() != "LV" &&  !value.isNum){
                                                        value = "0";
                                                      }
                                                      double tempVal = double.parse(value);
                                                      double maxmark = double.parse(widget.maxmarks??"0");
                                                      if(tempVal <= maxmark ){
                                                        classTestResultController.classtestresultresData.value.data?[index].validationdata = '';
                                                        return null;
                                                      }else if (value.contains == null){
                                                        classTestResultController.classtestresultresData.value.data?[index].validationdata = '';
                                                        setState(() {});
                                                        return null;
                                                      } else{
                                                        classTestResultController.classtestresultresData.value.data?[index].validationdata = 'Wrong Marks';
                                                        setState(() {});
                                                        return '';
                                                      }
                                                      return null;
                                                    }
                                                  },
                                                ),
                                              ),
                                              SizedBox(height: Get.height*0.005,),
                                              Padding(
                                                padding:  EdgeInsets.only(right: Get.width*0.002),
                                                child: Container(
                                                  // height: Get.height*0.01,
                                                    width: Get.width*0.115,
                                                    //padding: EdgeInsets.only( right: Get.width*0.01),
                                                    child:Text(classTestResultController.classtestresultresData.value.data?[index].validationdata??"",
                                                      style: const TextStyle(color: AppColors.redcolor,
                                                          overflow: TextOverflow.ellipsis,
                                                          fontSize: 10),)
                                                ),
                                              ),
                                            ],
                                          ),


                                          SizedBox(width: Get.width*0.01,),
                                        ],
                                      ),
                                    ),
                                  );
                                }),
                          ),
                        ],
                      ),
                    ),


                  ],
                ),
              ),
          ),
        ),
      ),
    );
  }
}
