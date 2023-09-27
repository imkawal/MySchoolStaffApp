import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:staffapp/helpers/app_manager.dart';
import 'package:staffapp/utils/appcolors_theme.dart';
import '../../controller/dashboard_controller.dart';
import '../../controller/student_attendance_controller.dart';
import '../../controller/student_monthly_att_controller.dart';
import '../../controller/update_student_image_controller.dart';
import '../../utils/drawer_widget.dart';
import 'view_attendance_screen.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class AttendanceScreen extends StatefulWidget {
   AttendanceScreen({Key? key}) : super(key: key);

  @override
  State<AttendanceScreen> createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  DateTime date = DateTime.now();
  var formattedDate;
  @override
  void initState() {
    formattedDate = DateFormat('dd-MM-yyyy').format(date);
    print(formattedDate);
  }


  final attendancecolorList = <Color>[
    const Color(0xffF5CEAA),
    const Color(0xffF2ABFE),
    const Color(0xffBAECEC),
    const Color(0xff9C93FF),
    const Color(0xff9A9A9A),
    const Color(0xffF5CEAA),
  ];

   final GlobalKey<ScaffoldState> attendancescaffoldEy = GlobalKey<ScaffoldState>();

   DashBoardController dashBoardController = Get.put(DashBoardController());
   String attendncedata = "A";
   String bulbattendncedata = "A";
  UpdateStudentImageController updateStudentImageController = Get.put(UpdateStudentImageController());
  StudentAttendanceController studentAttendanceController = Get.find<StudentAttendanceController>();

  File? imageDatas;
  void getGalleryImage({File? imageData, String? studentddd}) async {
    final images = await ImagePicker().getImage(source: ImageSource.camera);
    if (images != null) {
      File? img = File(images.path);
      img = await _cropImage(imageFile: img)
          .whenComplete(() => updateStudentImageController.updatestudentprofile(refresh: true,
          image: images, studentid: studentddd))
          .whenComplete(() =>  studentAttendanceController.getStudentAttendance(refresh: true,
        classectionid: AppManager.dashController.restoreInchargeListModel().classSectionId == null?
        AppManager.dashController.restoreClassInchargeListModel().classSectionId??''
            : AppManager.dashController.restoreInchargeListModel().classSectionId??"",
      ));
      setState(() {
        imageData = img;
        imageDatas = img;
      });
    } else {
      print('No image selected.');
    }
  }

  Future<File?> _cropImage({required File imageFile}) async{
    CroppedFile? croppedImage =
        await ImageCropper().cropImage(sourcePath: imageFile.path);
    if(croppedImage == null) return null;
    return File(croppedImage.path);
  }

  DateTime currentDate = DateTime.now();
  StudentMonthlyAttController studentMonthlyAttController = Get.put(StudentMonthlyAttController());
  @override
  Widget build(BuildContext context) {
    var formattedDate = DateFormat('dd/MM/yyyy').format(date);
    print(formattedDate);
    return SafeArea(
        child: Scaffold(
           key: attendancescaffoldEy,
          backgroundColor: AppColors.screencolor,
           drawer: DrawerElement(),
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: AppColors.darkblue,
            centerTitle: true,
            leading:  IconButton(
                onPressed: (){
                  //Get.find<DashBoardController>().dashboardscaffoldEy.currentState!.openDrawer();
                  attendancescaffoldEy.currentState!.openDrawer();
                },
                icon: Icon(Icons.menu, color: AppColors.white,)
            ),
            title: Text('Attendance',
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 22, color: AppColors.white),),
          ),
          body: GetBuilder<StudentAttendanceController>(
            init: Get.put(StudentAttendanceController()),
            //global: false,
            builder: (studentAttendanceController){
              return studentAttendanceController.studentattendanceData.value.data == null
                  ? const Center(child: CircularProgressIndicator())
                  : studentAttendanceController.studentattendanceData.value.data?.length == null
                  ? Center(
                    child: Text("Today is Holiday",
              style: TextStyle(
                color: AppColors.textcolor, fontWeight: FontWeight.w800, fontSize: 24
              ),),
                  )
                  :SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: Get.height*0.06,
                          width: Get.width*0.4,
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(width: 1.0, color: AppColors.darkblue),
                            ),
                          ),
                          child: Row(
                            children: [
                              SizedBox(width: 9),
                              Image.asset("assets/images/calendar.png"),
                              Container(
                                  height: Get.height*0.05,
                                  width: Get.width*0.26,
                                  // decoration: BoxDecoration(
                                  //     border: Border.all(color: AppColors.black),
                                  //     borderRadius: BorderRadius.circular(20)
                                  // ),
                                  child: Center(
                                    child: TextFormField(
                                        textAlign: TextAlign.center,
                                        controller: studentAttendanceController.dateController,
                                        style: TextStyle(fontWeight: FontWeight.w700, fontSize: Get.width * 0.04,
                                            color: AppColors.darkblue), //editing controller of this TextField
                                        decoration:  InputDecoration(
                                          hintText: formattedDate,
                                          hintStyle:  TextStyle(fontWeight: FontWeight.w700, fontSize: Get.width * 0.04,
                                              color: AppColors.darkblue),
                                          //contentPadding: EdgeInsets.only(bottom: Get.height*0.015),
                                          border: InputBorder.none,
                                        ),
                                        readOnly: true,  // when true user cannot edit text
                                        onTap: () async {
                                          DateTime? pickedDate = await showDatePicker(
                                              context: context,
                                              initialDate: DateTime.now(), //get today's date
                                              firstDate:DateTime(1988), //DateTime.now() - not to allow to choose before today.
                                              lastDate: DateTime(2500)
                                          );
                                          if(pickedDate != null ){
                                            print(pickedDate);  //get the picked date in the format => 2022-07-04 00:00:00.000
                                            String formattedDate = DateFormat('dd/MM/yyyy').format(pickedDate); // format date in required form here we use yyyy-MM-dd that means time is removed
                                            print(formattedDate); //formatted date output using intl package =>  2022-07-04
                                            //You can format date as per your need
                                            studentAttendanceController.dateController.text = formattedDate;
                                          }else{
                                            DateTime.now();
                                          }
                                        }
                                    ),
                                  )
                                // Center(child: Text('24/08/2022',
                                //   style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700,
                                //       color: AppColors.black),)),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: Get.height*0.06,
                          width: Get.width*0.3,
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(width: 1.0, color: AppColors.darkblue),
                              left: BorderSide(width: 1.0, color: AppColors.darkblue),
                            ),
                          ),
                          child: Row(
                            children: [
                              SizedBox(width: Get.width*0.016,),
                              Image.asset("assets/images/user-group.png"),
                              SizedBox(width: 8,),
                              Text(AppManager.dashController.restoreInchargeListModel().classSection == null?
                              AppManager.dashController.restoreClassInchargeListModel().classSection??''
                                  : AppManager.dashController.restoreInchargeListModel().classSection??"",
                                style: TextStyle(fontWeight: FontWeight.w700, fontSize: Get.width * 0.04,
                                    color: AppColors.darkblue),)
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap:AppManager.dashController.restoreInchargeListModel().classSectionId != null?
                          (){}:(){
                            studentAttendanceController.getStudentAttendance(refresh: true,
                                classectionid: AppManager.dashController.restoreInchargeListModel().classSectionId == null?
                                AppManager.dashController.restoreClassInchargeListModel().classSectionId??''
                                    : AppManager.dashController.restoreInchargeListModel().classSectionId??"",
                                attdate: formattedDate
                            ).whenComplete(() => Loader.show(context,
                                progressIndicator: const CircularProgressIndicator()));
                            Future.delayed(const Duration(seconds: 3), () {
                              Loader.hide();
                              //Navigator.pop(context);
                              print("Loader is being shown after hide ${Loader.isShown}");
                            });
                          },
                          child: Container(
                              height: Get.height*0.06,
                              width: Get.width*0.3,
                              decoration: BoxDecoration(
                                color: AppColors.darkblue,
                                border: Border(
                                  bottom: BorderSide(width: 1.0, color: AppColors.darkblue),
                                  left: BorderSide(width: 1.0, color: AppColors.darkblue),
                                ),
                              ),
                              child: Center(
                                child: Text("View",
                                  style: TextStyle(fontSize: Get.width * 0.04, fontWeight: FontWeight.w700, color: AppColors.white),),
                              )
                          ),
                        )
                      ],
                    ),
                    // Text('Mark attendance',
                    //   style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18, color: AppColors.apppurplecolor),),
                    SizedBox(height: Get.height*0.02,),
                    Padding(
                      padding:  EdgeInsets.only(left: Get.width*0.01, right: Get.width*0.01),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //   children: [
                          //     Container(
                          //         height: Get.height*0.05,
                          //         width: Get.width*0.27,
                          //         decoration: BoxDecoration(
                          //             border: Border.all(color: AppColors.black),
                          //             borderRadius: BorderRadius.circular(20)
                          //         ),
                          //         child: Center(
                          //           child: TextFormField(
                          //               textAlign: TextAlign.center,
                          //               controller: studentAttendanceController.dateController,
                          //               style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700,
                          //                   color: AppColors.black), //editing controller of this TextField
                          //               decoration:  InputDecoration(
                          //                 hintText: formattedDate,
                          //                 hintStyle: TextStyle(fontSize: 15, fontWeight: FontWeight.w700,
                          //                     color: AppColors.black),
                          //                 //contentPadding: EdgeInsets.only(bottom: Get.height*0.015),
                          //                 border: InputBorder.none,
                          //               ),
                          //               readOnly: true,  // when true user cannot edit text
                          //               onTap: () async {
                          //                 DateTime? pickedDate = await showDatePicker(
                          //                     context: context,
                          //                     initialDate: DateTime.now(), //get today's date
                          //                     firstDate:DateTime(1988), //DateTime.now() - not to allow to choose before today.
                          //                     lastDate: DateTime(2500)
                          //                 );
                          //                 if(pickedDate != null ){
                          //                   print(pickedDate);  //get the picked date in the format => 2022-07-04 00:00:00.000
                          //                   String formattedDate = DateFormat('dd/MM/yyyy').format(pickedDate); // format date in required form here we use yyyy-MM-dd that means time is removed
                          //                   print(formattedDate); //formatted date output using intl package =>  2022-07-04
                          //                   //You can format date as per your need
                          //                   studentAttendanceController.dateController.text = formattedDate;
                          //                 }else{
                          //                   DateTime.now();
                          //                 }
                          //               }
                          //           ),
                          //         )
                          //       // Center(child: Text('24/08/2022',
                          //       //   style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700,
                          //       //       color: AppColors.black),)),
                          //     ),
                          //     Container(
                          //       height: Get.height*0.05,
                          //       width: Get.width*0.27,
                          //       decoration: BoxDecoration(
                          //           border: Border.all(color: AppColors.black),
                          //           borderRadius: BorderRadius.circular(20)
                          //       ),
                          //       child: Center(child: Text(AppManager.dashController.restoreInchargeListModel().classSection == null?
                          //       AppManager.dashController.restoreClassInchargeListModel().classSection??''
                          //           : AppManager.dashController.restoreInchargeListModel().classSection??"",
                          //         style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: AppColors.black),)
                          //       ),
                          //     ),
                          //     GestureDetector(
                          //       onTap: (){
                          //         studentAttendanceController.getStudentAttendance(refresh: true,
                          //             classectionid: AppManager.dashController.restoreInchargeListModel().classSectionId == null?
                          //             AppManager.dashController.restoreClassInchargeListModel().classSectionId??''
                          //                 : AppManager.dashController.restoreInchargeListModel().classSectionId??"",
                          //             attdate: formattedDate
                          //         ).whenComplete(() => Loader.show(context,
                          //             progressIndicator: const CircularProgressIndicator()));
                          //         Future.delayed(const Duration(seconds: 3), () {
                          //           Loader.hide();
                          //           //Navigator.pop(context);
                          //           print("Loader is being shown after hide ${Loader.isShown}");
                          //         });
                          //       },
                          //       child: Container(
                          //         height: Get.height*0.05,
                          //         width: Get.width*0.27,
                          //         decoration: BoxDecoration(
                          //           //border: Border.all(color: AppColors.black),
                          //             color: AppColors.apppurplecolor,
                          //             borderRadius: BorderRadius.circular(20)
                          //         ),
                          //         child: Center(child: Text('View',
                          //           style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: AppColors.white),)),
                          //       ),
                          //     ),
                          //   ],
                          // ),
                          SizedBox(height: Get.height*0.0,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                height: Get.height * 0.115,
                                width: Get.width * 0.24,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    border: Border.all(color: AppColors.darkblue,width: 1.3)
                                ),
                                child: Column(
                                  children: [
                                    Container(
                                      width: Get.width * 0.35,
                                      height: Get.height*0.068,
                                      decoration: BoxDecoration(
                                        color: AppColors.darkblue,
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: Center(
                                          child: Text("${studentAttendanceController.studentattendanceData.value.totalStudent??"0"}",
                                            style: TextStyle(color: AppColors.welcomecolor, fontWeight: FontWeight.w700, fontSize: 24),)),
                                    ),

                                    SizedBox(
                                      height: 1,
                                    ),
                                    Text("Total \nStudents",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontWeight: FontWeight.w500, fontSize: Get.width * 0.031, color: AppColors.textcolor),),
                                  ],
                                ),
                              ),
                              Container(
                                height: Get.height * 0.115,
                                width: Get.width * 0.23,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    border: Border.all(color: AppColors.greencolor,width: 1.3)
                                ),
                                child: Column(
                                  children: [
                                    Container(
                                      width: Get.width * 0.35,
                                      height: Get.height*0.068,
                                      decoration: BoxDecoration(
                                        color: AppColors.greencolor,
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: Center(
                                          child: Text("${studentAttendanceController.studentattendanceData.value.totalPresent}",
                                            style: TextStyle(color: AppColors.welcomecolor, fontWeight: FontWeight.w700, fontSize: 24),)),
                                    ),

                                    SizedBox(
                                      height: Get.height * 0.01,
                                    ),
                                    Text("Present",
                                      style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14, color: AppColors.greencolor),),
                                  ],
                                ),
                              ),
                              Container(
                                height: Get.height * 0.115,
                                width: Get.width * 0.23,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    border: Border.all(color: AppColors.redcolor,width: 1.3)
                                ),
                                child: Column(
                                  children: [
                                    Container(
                                      width: Get.width * 0.35,
                                      height: Get.height*0.068,
                                      decoration: BoxDecoration(
                                        color: AppColors.redcolor,
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: Center(
                                          child: Text("${studentAttendanceController.studentattendanceData.value.totalAbsent}",
                                            style: TextStyle(color: AppColors.welcomecolor, fontWeight: FontWeight.w700, fontSize: 24),)),
                                    ),

                                    SizedBox(
                                      height: Get.height * 0.01,
                                    ),
                                    Text("Absent",
                                      style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14, color: AppColors.redcolor),),
                                  ],
                                ),
                              ),
                              Container(
                                height: Get.height * 0.115,
                                width: Get.width * 0.23,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    border: Border.all(color: AppColors.bluecolor,width: 1.3)
                                ),
                                child: Column(
                                  children: [
                                    Container(
                                      width: Get.width * 0.35,
                                      height: Get.height*0.068,
                                      decoration: BoxDecoration(
                                        color: AppColors.bluecolor,
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: Center(
                                          child: Text("${studentAttendanceController.studentattendanceData.value.totalLeave}",
                                            style: TextStyle(color: AppColors.welcomecolor, fontWeight: FontWeight.w700, fontSize: 24),)),
                                    ),

                                    SizedBox(
                                      height: Get.height * 0.01,
                                    ),
                                    Text("Leave",
                                      style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14, color: AppColors.bluecolor),),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          // Text('Total Students- ${studentAttendanceController.studentattendanceData.value.data?.length}',
                          //   style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15, color: AppColors.black),),
                          SizedBox(height: Get.height*0.01,),
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
                                  width: Get.width*0.17,
                                  child: Padding(
                                    padding:  EdgeInsets.only(left: 20),
                                    child: Text("№",
                                      style: TextStyle(color: AppColors.screencolor,fontWeight: FontWeight.w500,
                                          fontSize: 13),),
                                  ),
                                ),
                                SizedBox(
                                  width: Get.width*0.55,
                                  child: Padding(
                                    padding:  EdgeInsets.only(left: 20),
                                    child: Text("Students",
                                      style: TextStyle(color: AppColors.screencolor,fontWeight: FontWeight.w500,
                                          fontSize: 13),),
                                  ),
                                ),
                                SizedBox(
                                  width: Get.width*0.2,
                                  child: Text("Attendance",
                                    style: TextStyle(color: AppColors.screencolor,fontWeight: FontWeight.w500,
                                        fontSize: 13),),
                                )
                              ],
                            ),
                          ),
                          SizedBox(height: Get.height*0.01,),
                          //listview show student data
                          Padding(
                            padding:  EdgeInsets.only(left: Get.width*0.01),
                            child: ListView.separated(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                separatorBuilder: (BuildContext context, int index) => SizedBox(height: Get.height*0.01,),
                                itemCount: studentAttendanceController.studentattendanceData.value.data!.length,
                                itemBuilder: (BuildContext context, int index) {
                                  var attdata = studentAttendanceController.studentattendanceData.value.data;
                                  return Stack(
                                    children: [
                                      GestureDetector(
                                        onTap: (){
                                          studentMonthlyAttController.getStudentMonthlyAttendance(
                                              refresh: true,
                                              classsecid: AppManager.dashController.restoreInchargeListModel().classSectionId == null?
                                              AppManager.dashController.restoreClassInchargeListModel().classSectionId??''
                                                  : AppManager.dashController.restoreInchargeListModel().classSectionId??"",
                                              studentid: attdata?[index].studentId ,
                                              studate : studentAttendanceController.dateController.text
                                          ).whenComplete(() => Get.to(()=> ViewAttendaneScreen(
                                            name: attdata?[index].studentName,
                                            stuclass: AppManager.dashController.restoreInchargeListModel().classSection == null?
                                            AppManager.dashController.restoreClassInchargeListModel().classSection??''
                                                : AppManager.dashController.restoreInchargeListModel().classSection??"",
                                          )));
                                        },
                                        child: Container(
                                          height: Get.height*0.1,
                                          width: Get.width*0.91,
                                          padding: EdgeInsets.only(left: Get.width*0.025),
                                          decoration: BoxDecoration(
                                              border: Border.all(color: AppColors.darkblue),
                                              color: AppColors.white,
                                              //color: attendancecolorList[index % attendancecolorList.length],
                                              borderRadius: BorderRadius.circular(10)
                                          ),
                                          child: Row(
                                            //  mainAxisAlignment: MainAxisAlignment,
                                            children: [
                                              SizedBox(
                                                width: Get.width*0.06,
                                                child: Text('${attdata?[index].rollNo}.',
                                                  style: TextStyle(color: AppColors.darkblue, fontSize: 14, fontWeight: FontWeight.w700),),
                                              ),
                                              SizedBox(width: 10,),
                                              GestureDetector(
                                                onLongPress: (){
                                                  getGalleryImage(
                                                    imageData: attdata?[index].image,
                                                    studentddd: attdata?[index].studentId,);
                                                  // _pickImage();
                                                  //getImage().whenComplete(() => updateStudentImageController.updatestudentprofile(refresh: true, image: imageFile));
                                                },
                                                child: CircleAvatar(
                                                  radius: 22,
                                                  backgroundImage: attdata?[index].image != null
                                                      ? FileImage(attdata![index].image!)
                                                      :NetworkImage(
                                                      attdata![index].photo!
                                                    //"https://ddemo.xscholar.com/Uploads/TnpJPQ==/TVRFPQ==/staff/images.jpg"
                                                  )  as ImageProvider,

                                                ),
                                              ),
                                              SizedBox(width: 10,),
                                              Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  SizedBox(
                                                    width: Get.width*0.37,
                                                    child: Text('${attdata[index].studentName}',
                                                      overflow: TextOverflow.ellipsis,
                                                      style: TextStyle(color: AppColors.textcolor, fontWeight: FontWeight.w600, fontSize: 15),
                                                      maxLines: 1,),),
                                                  //SizedBox(height: Get.height*0.004,),
                                                  Text('#${attdata[index].admissionNo}',
                                                    style: TextStyle(color: AppColors.textcolor, fontWeight: FontWeight.w500, fontSize: 13),),

                                                ],
                                              ),
                                              SizedBox(width: Get.width*0.01,),
                                              GestureDetector(
                                                  onTap: ()async{
                                                    Uri phoneno = Uri.parse("tel:${attdata[index].phoneNo}");
                                                    if (await launchUrl(phoneno)) {
                                                      await launchUrl(phoneno);
                                                      //dialer opened
                                                    }else{
                                                      //dailer is not opened
                                                    }
                                                  },
                                                  child: Icon(Icons.call)),

                                              //Image.asset('assets/images/phone.png'),
                                              SizedBox(width: Get.width*0.01,),
                                              GestureDetector(
                                                onTap: (){
                                                  // setState(() {
                                                  //   if(attdata[index].attendence == "P" || (attdata[index].attendence??"").isEmpty){
                                                  //     attdata[index].attendence = "A";
                                                  //   }else if(attdata[index].attendence == "A"){
                                                  //     attdata[index].attendence = "L";
                                                  //   } else if(attdata[index].attendence == "L"){
                                                  //     attdata[index].attendence = "P";
                                                  //   }else {
                                                  //     attdata[index].attendence;
                                                  //   }
                                                  //   studentAttendanceController.updatethestudentattendance(refresh: true,
                                                  //     datetime: formattedDate,
                                                  //     attenadnce: attdata[index].attendence == "P"? "P":
                                                  //   attdata[index].attendence == "L"?"L":
                                                  //   "A",
                                                  //     recordid:attdata[index].recordId
                                                  //   );
                                                  // });
                                                },
                                                child: Container(
                                                  height: Get.height*0.09,
                                                  width: Get.width*0.13,
                                                  decoration: BoxDecoration(
                                                      image: DecorationImage(
                                                          image: AssetImage('assets/images/electricbolyimage.png'),fit: BoxFit.fill
                                                      )
                                                  ),
                                                  child: Center(
                                                      child: CircleAvatar(
                                                        radius: 13,
                                                        backgroundColor: attdata[index].attendence == "P"?Color(0xff2F9C09):attdata[index].attendence == "L"?Colors.yellow: Colors.red,
                                                        child: Center(
                                                          child: Text(attdata[index].attendence == "P"? "P":
                                                          attdata[index].attendence == "L"?"L":
                                                          "A",
                                                            style: TextStyle(color: AppColors.white,
                                                                fontWeight: FontWeight.w700),),
                                                        ),
                                                      )),
                                                ),
                                              ),
                                              SizedBox(width: 10,),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        left: Get.width*0.83,
                                        top: Get.height*0.018,
                                        child: GestureDetector(
                                          onTap: AppManager.dashController.restoreInchargeListModel().classSection == null?
                                              (){
                                            if(AppManager.dashController.restoreClassInchargeListModel().classSection != null){
                                              Loader.show(context, progressIndicator: const CircularProgressIndicator());
                                              setState(() {
                                                if(attdata[index].attendence == "P" || (attdata[index].attendence??"").isEmpty){
                                                  attdata[index].attendence = "A";
                                                }else if(attdata[index].attendence == "A"){
                                                  attdata[index].attendence = "L";
                                                }else if(attdata[index].attendence == "L"){
                                                  attdata[index].attendence = "P";
                                                }
                                                // else {
                                                // attdata[index].attendence;
                                                // }
                                                studentAttendanceController.updatethestudentattendance(refresh: true,
                                                    datetime: formattedDate,
                                                    recordid:attdata[index].recordId,
                                                    attenadnce: attdata[index].attendence
                                                ).whenComplete(() => studentAttendanceController.getStudentAttendance(
                                                    refresh: true,
                                                    classectionid: AppManager.dashController.restoreInchargeListModel().classSectionId == null?
                                                    AppManager.dashController.restoreClassInchargeListModel().classSectionId??''
                                                        : AppManager.dashController.restoreInchargeListModel().classSectionId??"",
                                                    attdate: formattedDate
                                                ));
                                              });
                                              Future.delayed(const Duration(seconds: 1), () {
                                                Loader.hide();
                                              });
                                            }
                                          }:(){},

                                          child: CircleAvatar(
                                            radius: 26,
                                            backgroundColor: AppColors.black,
                                            child: CircleAvatar(
                                              backgroundColor: attdata[index].attendence == "P"?Color(0xff2F9C09):attdata[index].attendence == "L"?Colors.yellow: Colors.red,
                                              radius: 25,
                                              child: Center(
                                                child: Text(
                                                  //"${attdata?[index].attendence == "Absent"?"A":"P"}",
                                                  // attdata?[index].attendence == "Absent"? "A":
                                                  attdata[index].attendence == "P"?"P":
                                                  attdata[index].attendence == "L"?"L":"A",
                                                  style: TextStyle(color: AppColors.white,
                                                      fontSize: 20, fontWeight: FontWeight.w800),),
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  );
                                }),
                          ),
                        ],
                      ),
                    ),

                  ],
                ),
              );

            }
          ),
        )
    );
  }
}
