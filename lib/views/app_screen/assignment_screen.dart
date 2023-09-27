import 'dart:io';
import 'dart:ui';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:staffapp/utils/app_button.dart';
import 'package:staffapp/utils/appstrings.dart';
import 'package:staffapp/utils/apptext_field.dart';
import 'package:staffapp/views/app_screen/attachment_detail_screen.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../controller/assignment_controller.dart';
import '../../controller/class_subject_controller.dart';
import '../../helpers/app_manager.dart';
import '../../models/class_subject_response_model.dart';
import '../../utils/appcolors_theme.dart';
import '../../utils/drawer_widget.dart';
import 'create_assignment_screenn.dart';

class AssignmentScreen extends StatefulWidget {
   AssignmentScreen({Key? key}) : super(key: key);

  @override
  State<AssignmentScreen> createState() => _AssignmentScreenState();
}

class _AssignmentScreenState extends State<AssignmentScreen> {
   RefreshController refreshController = RefreshController(initialRefresh: false);

   AssignmentController assignmentController = Get.put(AssignmentController());
   @override
  void initState() {
    // TODO: implement initState
    super.initState();
    assignmentController.getStudentAssignmentData(refresh: true);
    classSubjectController.getClassSubjectData(refresh: true,
        classectionid:  AppManager.dashController.restoreInchargeListModel().classId == null
            ? AppManager.dashController.restoreClassInchargeListModel().classId??""
            : AppManager.dashController.restoreInchargeListModel().classId??'');
  }

   void onLoading() async {
     refreshController.loadComplete();
   }
   void onRefresh() async {
     try {
       await assignmentController.getStudentAssignmentData(refresh: true);
       refreshController.refreshCompleted();
     } catch (e) {
       refreshController.refreshCompleted();
     }
   }
   // void onRefresh() async {
   //   await assignmentController.getStudentAssignmentData(refresh: true);
   //   refreshController.refreshCompleted();
   // }

   final assignmentcolorList = <Color>[
    const Color(0xffF5CEAA),
    const Color(0xffF2ABFE),
    const Color(0xffBAECEC),
    const Color(0xff9C93FF),
    const Color(0xff9A9A9A),
    const Color(0xffF5CEAA),
  ];

   final assignmentimageList = [
     "assets/images/assignmentcard.png",
    "assets/images/assignmentcard1.png"
   ];

   final colorList = [
     Colors.blue.shade400,
     Colors.orange.shade300,
     Colors.red.shade300,
     Colors.purple.shade300,
     Colors.green.shade300
   ];

  final GlobalKey<ScaffoldState> assignmentscaffoldEy = GlobalKey<ScaffoldState>();

   ClassSubjectController classSubjectController = Get.put(ClassSubjectController());


   String ClassSection = AppManager.dashController.restoreInchargeListModel().classSection == null?
   AppManager.dashController.restoreClassInchargeListModel().classSection??''
       : AppManager.dashController.restoreInchargeListModel().classSection??"";

   String classSubject = "";

   ClassSubjectData? dropdownvalue;

   //pick image from galary
   File? imageFile;
   Future getImage() async {
     final images = await ImagePicker().getImage(source: ImageSource.gallery);
     setState(() {
       if (images != null) {
         imageFile = File(images.path);
         //assignmentController.addstudentAssignment(refresh: true, imagename: images );
       } else {
         print('No image selected.');
       }
     });
   }
   clearimage() {
     setState(() {
       imageFile = null;
     });
   }


   //pick video from gallery
   File? videofile;
   Future _pickVideo() async {
     final video = await ImagePicker().pickVideo(source: ImageSource.gallery).whenComplete(() => setState(() {}));
     setState(() {
       if (video != null) {
         videofile = File(video.path);
       } else {
         print('No video selected.');
       }
     });
     // _video = video;
     // _videoPlayerController = VideoPlayerController.file(_video)..initialize().then((_) {
     //   setState(() { });
     //   _videoPlayerController.play();;
   }

   //for pick the pdf
   File? file1;
   Future getPdfAndUpload() async {

     FilePickerResult? result = await FilePicker.platform.pickFiles(
       type: FileType.custom,
       allowedExtensions: ['pdf'],
     ).whenComplete(() => setState(() {}));
     if(result  != null) {
       PlatformFile file = result.files.first;
       print(file.name);
       print(file.extension);
       print(file.path);
       setState(() {
         file1 = File(file.path!);
         //file1 is a global variable which i created
         print(file1);
       });
     }
   }
   clearpdf() {
     setState(() {
       file1 = null;
     });
   }


   //for upload the audio
   File? file2;
   Future getaudioAndUpload() async {

     FilePickerResult? result = await FilePicker.platform.pickFiles(
       type: FileType.audio,
       //  allowedExtensions: ['mp3'],
     ).whenComplete(() => setState(() {}));
     if(result  != null) {
       PlatformFile file = result.files.first;
       print(file.name);
       print(file.extension);
       print(file.path);
       setState(() {
         file2 = File(file.path!);
         //file1 is a global variable which i created
         print(file2);
       });
     }
   }
   clearaudio() {
     setState(() {
       file2 = null;
     });
   }


   List<TextSpan> highlightOccurrences(String source, String query) {
     if (query == null || query.isEmpty || !source.toLowerCase().contains(query.toLowerCase())) {
       return [ TextSpan(text: source) ];
     }
     final matches = query.toLowerCase().allMatches(source.toLowerCase());

     int lastMatchEnd = 0;

     final List<TextSpan> children = [];
     for (var i = 0; i < matches.length; i++) {
       final match = matches.elementAt(i);

       if (match.start != lastMatchEnd) {
         children.add(TextSpan(
           text: source.substring(lastMatchEnd, match.start),
         ));
       }

       children.add(TextSpan(
           text: source.substring(match.start, match.end),
           style:  const TextStyle(
               fontWeight: FontWeight.w900,fontSize: 16,
               color: AppColors.darkblue
           )
       ));

       if (i == matches.length - 1 && match.end != source.length) {
         children.add(TextSpan(
           text: source.substring(match.end, source.length),
         ));
       }

       lastMatchEnd = match.end;
     }
     return children;
   }

   TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          backgroundColor: AppColors.screencolor,
          key: assignmentscaffoldEy,
          drawer: DrawerElement(),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              // Add your onPressed code here!
            },
            backgroundColor: AppColors.textcolor,
            child: IconButton(
              onPressed: () async {
                if(!classSubjectController.isBlock.value){
                  await classSubjectController.getClassSubjectData(refresh: true,
                      classectionid: AppManager.dashController.restoreInchargeListModel().classId == null
                          ? AppManager.dashController.restoreClassInchargeListModel().classId??""
                          : AppManager.dashController.restoreInchargeListModel().classId??'')
                      .then((value) => showMyDialog(context));
                }
                //Get.to(()=>CreateAssignmentScreen());
              },
              icon: const Icon(Icons.add,
              size: 30,
              color: AppColors.white,),
            ),
          ),
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: AppColors.darkblue,
            centerTitle: true,
            leading:  IconButton(
                onPressed: (){
                  assignmentscaffoldEy.currentState!.openDrawer();
                },
                icon: const Icon(Icons.menu, color: AppColors.white,)
            ),
            title: const Text('Assignment',
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 22, color: AppColors.white),),
          ),
          body: GetBuilder<AssignmentController>(
            init: Get.put(AssignmentController()),
            global: true,
            builder: (assignmentController){
              return assignmentController.stuassignmentresData.value.data == null
                  ? const Center(child: CircularProgressIndicator())
                  :SmartRefresher(
                physics:  const BouncingScrollPhysics(),
                controller: refreshController,
                onRefresh: () => onRefresh(),
                onLoading: () => onLoading(),
                    child: SingleChildScrollView(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(height: Get.height*0.02,),
                            Container(
                                width: Get.width*0.87,
                                //height: Get.height*0.065,
                                padding: EdgeInsets.only(left: Get.width*0.01),
                                decoration: BoxDecoration(
                                  color: AppColors.white,
                                    border: Border.all(color: AppColors.darkblue, width: 2.0),
                                    borderRadius: BorderRadius.circular(13)
                                ),
                                child: TextFormField(
                                  controller: _textEditingController,
                                  decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Search",
                                      hintStyle: TextStyle(color: AppColors.darkblue, fontWeight: FontWeight.w600),
                                      prefixIcon: Icon(Icons.search, color: AppColors.darkblue,)
                                  ),
                                    onChanged: (query){
                                      final searchResult = assignmentController.stuassignmentresData.value.data?.where((element) {
                                        final title = element.subjectName?.toLowerCase()??"";
                                        final queryLowerCase = query.toLowerCase();
                                        return title.contains(queryLowerCase);
                                      }).toList();
                                      assignmentController.filterdata.value = searchResult!;
                                      setState(() {});
                                    }
                                )
                              // Center(
                              //   child: Row(
                              //    // mainAxisAlignment: MainAxisAlignment.center,
                              //     children: [
                              //       IconButton(
                              //           onPressed: (){},
                              //           icon: Icon(Icons.search)),
                              //       Text('Search'),
                              //
                              //     ],
                              //   ),
                              // ),
                            ),
                            SizedBox(height: Get.height*0.023,),
                            Padding(
                              padding:  EdgeInsets.only(left: Get.width*0.05, right: Get.width*0.05),
                              child: ListView.separated(
                                shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  separatorBuilder: (BuildContext context, int index) => SizedBox(height: Get.height*0.02,),
                                  itemCount: assignmentController.filterdata.value.length,
                                  itemBuilder: (BuildContext context, int index) {
                                    var assignmentdata = assignmentController.filterdata.value;
                                    // final birthday = assignmentdata?[index].lastSubmitDate;
                                    // final date2 = DateTime.now();
                                    // final difference = date2.difference(birthday).inDays.toString();
                                    return  Container(
                                       // height: Get.height*0.25,
                                        width: Get.width*0.8,
                                        padding: EdgeInsets.only(left: Get.width*0.05,top: Get.height*0.023, ),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          //border: Border.all(color: AppColors.darkblue),
                                          //color: colorList[index % colorList.length],
                                          borderRadius: BorderRadius.circular(15),
                                          boxShadow: [
                                            const BoxShadow(
                                              color: AppColors.darkblue, //New
                                              blurRadius: 2.0,
                                            )
                                          ],
                                          // image: DecorationImage(
                                          //     image: AssetImage(classtestimageList[index % classtestimageList.length]),
                                          //     //colorFilter: ColorFilter.mode(assignmentcolorList[index % assignmentcolorList.length], BlendMode.color),
                                          //     fit: BoxFit.fill
                                          // )
                                        ),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding:  EdgeInsets.only(right: Get.width*0.05),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Row(
                                                    children: [
                                                      RichText(
                                                        text: TextSpan(
                                                            children: highlightOccurrences(assignmentController.filterdata.value[index].subjectName??"", _textEditingController.text),
                                                            style:  TextStyle(fontSize: Get.width * 0.04,
                                                                fontWeight: FontWeight.w700, color: AppColors.lightbluecolor)
                                                        ),
                                                      ),
                                                      if(assignmentController.filterdata.value[index].subjectName != null)...{
                                                        Text("-",style:  TextStyle(fontSize: Get.width * 0.04,
                                                            fontWeight: FontWeight.w700, color: AppColors.lightbluecolor)),
                                                      }else...{
                                                        Container()
                                                      },

                                                      SizedBox(
                                                        width: Get.width*0.3,
                                                        child: Text("${assignmentController.filterdata.value[index].name}",
                                                            style:  TextStyle(fontSize: Get.width * 0.04,
                                                                overflow: TextOverflow.ellipsis,fontWeight: FontWeight.w700, color: AppColors.lightbluecolor)),
                                                      )
                                                    ],
                                                  ),
                                                  // SizedBox(
                                                  //   width: Get.width*0.5,
                                                  //   child: Text('${assignmentdata?[index].subjectName??"Subject Name"}',
                                                  //     overflow: TextOverflow.ellipsis,
                                                  //     maxLines: 1,
                                                  //       style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: AppColors.lightbluecolor),),
                                                  // ),
                                                  Text('${assignmentController.filterdata.value[index].date}',
                                                    style:  TextStyle(fontSize: Get.width * 0.04, fontWeight: FontWeight.w500, color: AppColors.darkblue),),
                                                ],
                                              ),
                                            ),
                                            const Divider(
                                              color: AppColors.darkblue,
                                              thickness: 1,
                                              endIndent: 16,
                                            ),
                                            SizedBox(height: Get.height*0.01,),
                                            Padding(
                                              padding:  EdgeInsets.only(left: Get.width*0.028,right: Get.width*0.05),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          const SizedBox(width: 10),
                                                          Container(
                                                            //width: 5,
                                                            decoration: BoxDecoration(
                                                               // color: AppColors.lightbluecolor,
                                                                border: Border(
                                                                  left: BorderSide( //                   <--- left side
                                                                    color:  AppColors.lightbluecolor,
                                                                    width: 5.0,
                                                                  ),
                                                                ),
                                                            ),
                                                            child: Padding(
                                                              padding:  EdgeInsets.only(left: 8),
                                                              child: Column(
                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                children: [
                                                                  SizedBox(
                                                                    width: Get.width*0.4,
                                                                    child: Text('${assignmentController.filterdata.value[index].description??""}',
                                                                      overflow: TextOverflow.ellipsis,
                                                                      style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: AppColors.textcolor),),
                                                                  ),
                                                                  SizedBox(height: Get.height*0.007,),
                                                                  Text('${assignmentController.filterdata.value[index].classSection}',
                                                                    style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: AppColors.darkblue),),

                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      // GestureDetector(
                                                      //   onTap: (){
                                                      //     // Get.to(()=> AttachmentDetailScreen(
                                                      //     //   name: assignmentController.filterdata.value[index].name,
                                                      //     //   subject: assignmentController.filterdata.value[index].subjectName,
                                                      //     //   classsection: assignmentController.filterdata.value[index].classSection,
                                                      //     //   description: assignmentController.filterdata.value[index].description,
                                                      //     //   date: assignmentController.filterdata.value[index].date,
                                                      //     //   lastdate: assignmentController.filterdata.value[index].lastSubmitDate,
                                                      //     //   imgelink: imageFile?.path.toString()??"",
                                                      //     //   videolink: assignmentController.videoController.text.isEmpty?"": assignmentController.videoController.text.toString(),
                                                      //     //   pdflink: file1?.path.toString()??"",
                                                      //     //   audiolink: file2?.path.toString()??"",
                                                      //     // ));
                                                      //   },
                                                      //   child: SizedBox(
                                                      //     height: Get.height*0.065,
                                                      //     child: Column(
                                                      //       children: [
                                                      //         Image.asset("assets/images/eye.png"),
                                                      //         const Text("View",
                                                      //           style: TextStyle(color: AppColors.darkblue, fontSize: 14, fontWeight: FontWeight.w500),)
                                                      //       ],
                                                      //     ),
                                                      //   ),
                                                      // ),
                                                    ],
                                                  ),
                                                  SizedBox(height: Get.height*0.012,),

                                                  // Text('${assignmentdata?[index].description}',
                                                  //   style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: AppColors.black),),
                                                  // SizedBox(height: Get.height*0.034,),
                                                  // Row(
                                                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  //   children: [
                                                  //     Row(
                                                  //       children: [
                                                  //         Text('${assignmentdata?[index].subjectName??"English"}',
                                                  //           style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: AppColors.black),),
                                                  //         SizedBox(width: 10,),
                                                  //         Text('${assignmentdata?[index].classSection??""}',
                                                  //           style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: AppColors.black),),
                                                  //       ],
                                                  //     ),
                                                  //     Text('${assignmentdata?[index].lastSubmitDate}',
                                                  //       style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Colors.grey),),
                                                  //   ],
                                                  // ),

                                                  // SizedBox(height: Get.height*0.007,),
                                                  // Text('${assignmentdata?[index].date}',
                                                  //   style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: AppColors.black),),
                                                  //SizedBox(height: Get.height*0.007,),
                                                  // Text('${assignmentdata?[index].remarks}',
                                                  //   style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: AppColors.black),),
                                                ],
                                              ),
                                            ),
                                            SizedBox(height: Get.height*0.019,),
                                            Padding(
                                              padding:  EdgeInsets.only(left: Get.width*0.028),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  GestureDetector(
                                                    onTap: (){
                                                      showDetailDialog(
                                                        context,
                                                        name: assignmentController.filterdata.value[index].name,
                                                        subject: assignmentController.filterdata.value[index].subjectName,
                                                        classsection: assignmentController.filterdata.value[index].classSection,
                                                        description: assignmentController.filterdata.value[index].description,
                                                        date: assignmentController.filterdata.value[index].date,
                                                        lastdate: assignmentController.filterdata.value[index].lastSubmitDate,
                                                        imgelink: assignmentController.filterdata.value[index].image.toString()??"",
                                                        videolink: assignmentController.filterdata.value[index].video.toString()??"",
                                                        pdflink: assignmentController.filterdata.value[index].pdf.toString()??"",
                                                        audiolink: assignmentController.filterdata.value[index].audio.toString()??"",
                                                        // date:  examScheduleController.filterdata.value[index].da,
                                                      );
                                                    },
                                                    child: SizedBox(
                                                      width: Get.width*0.3,
                                                      child: Row(
                                                        children: [
                                                          Image.asset('assets/images/paper-clip.png',),
                                                          const SizedBox(height: 7),
                                                          const Text('Attachment',
                                                            style: TextStyle(
                                                                color: AppColors.darkblue,
                                                                fontWeight: FontWeight.w500,fontSize: 15
                                                            ),)
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  GestureDetector(
                                                    onTap: (){
                                                      showDialog(
                                                        context: context,
                                                        builder: (ctx) => AlertDialog(
                                                          shape: RoundedRectangleBorder(
                                                            borderRadius: BorderRadius.circular(30),
                                                          ),
                                                          contentPadding: EdgeInsets.only(left: Get.width * 0.02, right: Get.width * 0.02),
                                                          content: SizedBox(
                                                            height: Get.height * 0.25,
                                                            width: Get.width,
                                                            child: Column(
                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                              // crossAxisAlignment: CrossAxisAlignment.center,
                                                              children: [
                                                                // SizedBox(
                                                                //   height: Get.height * 0.02,
                                                                // ),
                                                                // Image.asset(
                                                                //   'assets/images/couplelogoutimage.png',
                                                                //   scale: 0.8,
                                                                // ),
                                                                SizedBox(
                                                                  height: Get.height * 0.02,
                                                                ),
                                                                const Text(
                                                                  "You don't have a \npermission to delete the class test",
                                                                  textAlign: TextAlign.center,
                                                                  style: TextStyle(fontWeight: FontWeight.w600,
                                                                      letterSpacing: 1.5,
                                                                      fontSize: 16, color: Color(0xff3F3F3F)),
                                                                ),
                                                                SizedBox(
                                                                  height: Get.height * 0.015,
                                                                ),
                                                                // Divider(
                                                                //   color: AppColors.textcolor,
                                                                //   endIndent: 19,
                                                                //   indent: 19,
                                                                // ),
                                                                SizedBox(
                                                                  height: Get.height * 0.02,
                                                                ),
                                                                Padding(
                                                                  padding:  EdgeInsets.only(left: Get.width*0.05, right: Get.width*0.05),
                                                                  child: GestureDetector(
                                                                    onTap: () {
                                                                      Get.back();
                                                                    },
                                                                    child: Container(
                                                                      height: Get.height * 0.06,
                                                                      width: Get.width * 0.33,
                                                                      decoration: BoxDecoration(
                                                                          color: AppColors.white,
                                                                          border: Border.all(color: AppColors.darkblue),
                                                                          borderRadius: BorderRadius.circular(10)),
                                                                      child: const Center(
                                                                        child: Text(
                                                                          'Cancel',
                                                                          style: TextStyle(
                                                                              fontSize: 15, fontWeight: FontWeight.w600, color: AppColors.darkblue),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  height: Get.height * 0.02,
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                    child: Container(
                                                      width: Get.width*0.23,
                                                      height: Get.height*0.0682,
                                                      decoration: const BoxDecoration(
                                                        color: AppColors.darkblue,
                                                        borderRadius: BorderRadius.only(
                                                            topLeft: Radius.circular(20.0),
                                                            bottomRight: Radius.circular(10.0),
                                                            bottomLeft: Radius.circular(3.0)),
                                                      ),
                                                      child: Image.asset('assets/images/trash-2.png'),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            //SizedBox(height: Get.height*0.01,),
                                            // Divider(
                                            //   color: AppColors.black,
                                            //   thickness: 2,
                                            // ),
                                            // Row(
                                            //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            //   children: [
                                            //     Row(
                                            //       children: [
                                            //         Image.asset('assets/images/check.png'),
                                            //         SizedBox(width: Get.width*0.015,),
                                            //         Text('View',
                                            //           style: TextStyle(
                                            //               color: AppColors.black,fontWeight: FontWeight.w800
                                            //           ),)
                                            //       ],
                                            //     ),
                                            //     Row(
                                            //       children: [
                                            //         Image.asset('assets/images/Delete Bin.png'),
                                            //         SizedBox(width: Get.width*0.015,),
                                            //         Text('Delete',
                                            //           style: TextStyle(
                                            //               color: AppColors.black,
                                            //               fontWeight: FontWeight.w800
                                            //           ),)
                                            //       ],
                                            //     ),
                                            //   ],
                                            // ),
                                            // SizedBox(height: Get.height*0.025,),
                                          ],
                                        )
                                    );
                                  }),
                            ),
                          ],
                      ),
                    ),
                  );
            }
          ),
        ));
  }

   showMyDialog(BuildContext context) {
     ClassSubjectData? dropdownvalue;
     showDialog(
         context: context,
         builder: (_) =>  AlertDialog(
           insetPadding: EdgeInsets.only(top: Get.height*0.03, bottom: Get.height*0.08, left: Get.width*0.06, right: Get.width*0.06),
           contentPadding: EdgeInsets.zero,
           scrollable: true,
           clipBehavior: Clip.antiAliasWithSaveLayer,
           shape: const RoundedRectangleBorder(
               borderRadius:
               BorderRadius.all(
                   Radius.circular(10.0))),
           content: Builder(
             builder: (context) {
               // Get available height and width of the build area of this widget. Make a choice depending on the size.
               var height = MediaQuery.of(context).size.height;
               var width = MediaQuery.of(context).size.width;
               return StatefulBuilder(
                 builder: (BuildContext context, StateSetter setState /*You can rename this!*/){
                   return Container(
                     height: height,
                     width: width,
                     padding: EdgeInsets.only(right: Get.width*0.05, left: Get.width*0.05),
                     child: Column(
                       children: [
                         const SizedBox(height: 19,),
                         const Text("Create Assignment",
                           style: TextStyle(
                               color: AppColors.textcolor,fontWeight: FontWeight.w700,
                               fontSize: 20
                           ),),
                         SizedBox(
                           height: Get.height * 0.03,
                         ),
                         Container(
                             height: Get.height*0.07,
                             width: Get.width*0.78,
                             decoration: BoxDecoration(
                                 border: Border.all(color: AppColors.darkblue),
                                 borderRadius: BorderRadius.circular(6)
                             ),
                             child: Row(
                               children: [
                                 const SizedBox(width: 10,),
                                 Image.asset("assets/images/user-group1.png"),
                                 const SizedBox(width: 12,),
                                 Text('Class Sec.- ${AppManager.dashController.restoreInchargeListModel().classSection == null?
                                 AppManager.dashController.restoreClassInchargeListModel().classSection??''
                                     : AppManager.dashController.restoreInchargeListModel().classSection??""}',
                                   style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16, color: AppColors.textcolor),),
                               ],
                             )
                         ),
                         SizedBox(
                           height: Get.height * 0.02,
                         ),
                         AssignmentTextField(
                           prefix: Image.asset("assets/images/award.png"),
                           hintText: AppStrings.topicname,
                           controller: assignmentController.nameController,
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
                                     border: Border.all(color: AppColors.darkblue),
                                     borderRadius: BorderRadius.circular(6.0),
                                   ),
                                   child: DropdownButton<ClassSubjectData>(
                                     hint: Row(
                                       children: [
                                         Image.asset("assets/images/bookmark-alt1.png"),
                                         SizedBox(width: 15,),
                                         SizedBox(
                                           width: Get.width*0.55,
                                           child: Text("Please Select Subject",
                                             style: TextStyle(color: AppColors.textcolor,fontSize: 16, fontWeight: FontWeight.w600),),
                                         ),
                                       ],
                                     ),
                                     items: classSubjectController.classsuubjectresData.value.data?.map((item) {
                                       return  DropdownMenuItem<ClassSubjectData>(
                                         child:  Row(
                                           children: [
                                             Image.asset("assets/images/bookmark-alt1.png"),
                                             const SizedBox(width: 15,),
                                             SizedBox(
                                                 width: Get.width*0.55,
                                                 child: Text(item.subject??'Please Select Subject',
                                                   style: const TextStyle(color: AppColors.textcolor,fontSize: 16, fontWeight: FontWeight.w600),)),
                                           ],
                                         ),
                                         value: item,
                                       );
                                     }).toList(),
                                     onChanged: ( newVal) {
                                       setState(() {
                                         // saveeventcon.currencyController.text = newVal.toString();
                                         //  print(saveeventcon.currencyController.text);
                                         dropdownvalue = newVal as ClassSubjectData;
                                         assignmentController.classsubjectidContoller.value = newVal.classSubjectId??"";
                                       });
                                     },
                                     underline: DropdownButtonHideUnderline(child: Container()),
                                     value:
                                     //dropdownvalue != null ? classSubjectController.classsuubjectresData.value.data?.first : dropdownvalue,
                                     dropdownvalue??classSubjectController.classsuubjectresData.value.data?.first,
                                   ),
                                 ),
                               ),
                           )
                         }else...{
                           SizedBox(
                             height: Get.height * 0.028,
                           ),
                           Container(
                               height: Get.height*0.07,
                               width: Get.width*0.78,
                               decoration: BoxDecoration(
                                   border: Border.all(color: AppColors.darkblue),
                                   borderRadius: BorderRadius.circular(6)
                               ),
                               child: Row(
                                 children: [
                                   const SizedBox(width: 9,),
                                   Image.asset("assets/images/bookmark-alt1.png"),
                                   const SizedBox(width: 15,),
                                   Text("${AppManager.dashController.restoreInchargeListModel().subjectName}",
                                     style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16,color: AppColors.textcolor),),
                                 ],
                               )
                           ),
                         },
                         SizedBox(
                           height: Get.height * 0.02,
                         ),
                         Container(
                             height: Get.height*0.065,
                             width: Get.width*0.81,
                             padding: EdgeInsets.only(left: Get.width*0.00, top: Get.height*0.00),
                             decoration: BoxDecoration(
                               border: Border.all(color: AppColors.darkblue,),
                               borderRadius: BorderRadius.circular(6.0),
                             ),
                             child: TextFormField(
                               //textAlign: TextAlign.start,
                                 controller: assignmentController.dateController,
                                 style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600,
                                     color: AppColors.textcolor), //editing controller of this TextField
                                 decoration:  InputDecoration(
                                   prefixIcon: Image.asset("assets/images/calendar.png"),
                                   hintText: "Due Date",
                                   hintStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600,
                                       color: AppColors.textcolor),
                                   contentPadding: EdgeInsets.only(top: Get.height*0.02),
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
                                     assignmentController.dateController.text = formattedDate;
                                   }else{
                                     DateTime.now();
                                   }
                                 }
                             )
                           // Center(child: Text('24/08/2022',
                           //   style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700,
                           //       color: AppColors.black),)),
                         ),
                         SizedBox(
                           height: Get.height * 0.02,
                         ),
                         Container(
                             height: Get.height*0.065,
                             width: Get.width*0.81,
                             padding: EdgeInsets.only(left: Get.width*0.0, top: Get.height*0.00),
                             decoration: BoxDecoration(
                               border: Border.all(color: AppColors.darkblue,),
                               borderRadius: BorderRadius.circular(6.0),
                             ),
                             child: TextFormField(
                               //textAlign: TextAlign.start,
                                 controller: assignmentController.lastsubmitdateController,
                                 style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600,
                                     color: AppColors.textcolor), //editing controller of this TextField
                                 decoration:  InputDecoration(
                                   prefixIcon: Image.asset("assets/images/calendar.png"),
                                   hintText: "Last Date for Submission",
                                   hintStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600,
                                       color: AppColors.textcolor),
                                   contentPadding: EdgeInsets.only(top: Get.height*0.02),
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
                                     assignmentController.lastsubmitdateController.text = formattedDate;
                                   }else{
                                     DateTime.now();
                                   }
                                 }
                             )
                           // Center(child: Text('24/08/2022',
                           //   style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700,
                           //       color: AppColors.black),)),
                         ),
                         SizedBox(
                           height: Get.height * 0.02,
                         ),
                         Container(
                             height: Get.height*0.1,
                             width: Get.width*0.81,
                             padding: EdgeInsets.only(left: Get.width*0.0, top: Get.height*0.00),
                             decoration: BoxDecoration(
                               border: Border.all(color: AppColors.darkblue,),
                               borderRadius: BorderRadius.circular(6.0),
                             ),
                             child: TextFormField(
                                 controller: assignmentController.assignmentdesController,
                                 style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600,
                                     color: AppColors.textcolor),
                               maxLines: 5,//editing controller of this TextField
                                 decoration:  InputDecoration(
                                   prefixIcon: Image.asset("assets/images/trending-up.png"),
                                   hintText: AppStrings.assigndescription,
                                   hintStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600,
                                       color: AppColors.textcolor),
                                   contentPadding: EdgeInsets.only(top: Get.height*0.02),
                                   border: InputBorder.none,
                                 ),
                             )
                         ),
                         // AssignmentTextField(
                         //   prefix: Image.asset("assets/images/trending-up.png"),
                         //   hintText: AppStrings.assigndescription,
                         //   controller: assignmentController.assignmentdesController,
                         //   keyboardType: TextInputType.datetime,
                         //   // validator: validateEmail,
                         // ),
                         SizedBox(
                           height: Get.height * 0.02,
                         ),
                         GestureDetector(
                           onTap: (){
                             _menuBottomSheetMenu(context);
                             setState(() {

                             });
                           },
                           child: Container(
                             width: Get.width*0.35,
                             height: Get.height*0.06,
                             decoration: BoxDecoration(
                                 borderRadius: BorderRadius.circular(10),
                                 border: Border.all(color: AppColors.darkblue)
                             ),
                             child: Row(
                               children: [
                                 SizedBox(width: Get.width*0.02,),
                                 Image.asset('assets/images/paper-clip.png'),
                                 SizedBox(width: Get.width*0.02,),
                                 const Text('Attachment',
                                   style: TextStyle(fontWeight: FontWeight.w600, color: AppColors.darkblue),),
                               ],
                             ),
                           ),
                         ),
                         SizedBox(
                           height: Get.height * 0.02,
                         ),
                         AppButton(
                             buttonName: "Share Assignment",
                             onTap: (){
                               Loader.show(context,
                                   progressIndicator: const CircularProgressIndicator());
                               assignmentController.addstudentAssignment(refresh: true,
                                 classsectionid: AppManager.dashController.restoreInchargeListModel().classSectionId == null?
                                 AppManager.dashController.restoreClassInchargeListModel().classSectionId??''
                                     : AppManager.dashController.restoreInchargeListModel().classSectionId??"",
                                 classsubectid: AppManager.dashController.restoreInchargeListModel().classSubjectId,
                                 subj:classSubjectController.classsuubjectresData.value.data?.first.classSubjectId,
                                 fileimage:  imageFile,
                                 audioimage:file2,
                                 pdfimage: file1,
                                 video: videofile,
                               ).whenComplete(() {
                                 assignmentController.videoController.text = "";
                                 imageFile = null;
                                 file2 = null;
                                 file1 = null;
                               }
                               );
                               //Get.to(()=>AssignmentScreen());
                               assignmentController.getStudentAssignmentData(refresh: true);
                               Get.back();
                               Future.delayed(const Duration(seconds: 3), () {
                                 Loader.hide();
                                 //Navigator.pop(context);
                                 //print("Loader is being shown after hide ${Loader.isShown}");
                               });
                             },
                             isIconShow: false,
                             height: Get.height*0.071,
                             fontSize: 18,
                             fontweight: FontWeight.w600,
                             width: Get.width* 0.65,
                             backgroundColor: AppColors.darkblue,
                             //iconColor: AppColors.bluishBlack,
                             textColor: const Color(0xffFFFFFF)
                         ),
                       ],
                     ),
                   );
                 }
               );
             },
           ),
         )
     );
   }

   showDetailDialog(BuildContext context,
       {String? classtestid,String? name,
         String? subject,
         String? classsection,
         String? maxmarks,
         String? date, String? description, String? lastdate, required String imgelink, required String videolink, required String pdflink, required String audiolink,}) {
     showDialog(
         context: context,
         builder: (_) =>  AlertDialog(
           insetPadding: EdgeInsets.only(top: Get.height*0.08, bottom: Get.height*0.08, left: Get.width*0.06, right: Get.width*0.06),
           contentPadding: EdgeInsets.zero,
           scrollable: true,
           clipBehavior: Clip.antiAliasWithSaveLayer,
           shape: const RoundedRectangleBorder(
               borderRadius:
               BorderRadius.all(
                   Radius.circular(10.0))),
           content: Builder(
             builder: (context) {
               // Get available height and width of the build area of this widget. Make a choice depending on the size.
               var height = MediaQuery.of(context).size.height;
               var width = MediaQuery.of(context).size.width;
               return StatefulBuilder(
                   builder: (BuildContext context, StateSetter setState /*You can rename this!*/){
                     return Container(
                       //height: Get.height*0.68,
                       width: width,
                       child: Padding(
                         padding:  EdgeInsets.only(left: Get.width*0.03, right: Get.width*0.02),
                         child: Column(
                           crossAxisAlignment: CrossAxisAlignment.start,
                           children: [
                             SizedBox(height: Get.height*0.02),
                             Row(
                               mainAxisAlignment: MainAxisAlignment.center,
                               children: [
                                 // Text("Name : ",
                                 //   style: TextStyle(fontSize: 19, fontWeight: FontWeight.w800, color: AppColors.black),),
                                 Text(name??"",
                                   style:  TextStyle(fontSize: Get.width * 0.05, fontWeight: FontWeight.w800, color: AppColors.darkblue),)
                               ],
                             ),

                             SizedBox(height: Get.height*0.015,),
                             Row(
                               children: [
                                 SizedBox(
                                   width: Get.width*0.54,
                                   child:  Text("Class Section ",
                                     style: TextStyle(fontSize: Get.width * 0.045, fontWeight: FontWeight.w800, color: AppColors.black),),
                                 ),
                                 Text(": ${classsection ?? ""}",
                                   style:  TextStyle(fontSize: Get.width * 0.045, fontWeight: FontWeight.w500, color: AppColors.darkblue),)
                               ],
                             ),
                             SizedBox(height: Get.height*0.015,),
                             Row(
                               children: [
                                 SizedBox(
                                   width: Get.width*0.54,
                                   child:  Text("Subject  ",
                                     style: TextStyle(fontSize: Get.width * 0.045, fontWeight: FontWeight.w800, color: AppColors.black),),
                                 ),
                                 Text(": ${subject ?? ""}",
                                   style:  TextStyle(fontSize: Get.width * 0.045, fontWeight: FontWeight.w500, color: AppColors.darkblue),)
                               ],
                             ),

                             date == null?const SizedBox.shrink():
                             Column(
                               children: [
                                 SizedBox(height: Get.height*0.015,),
                                 Row(
                                   children: [
                                     SizedBox(
                                       width: Get.width*0.54,
                                       child:  Text("Date  ",
                                         style: TextStyle(fontSize: Get.width * 0.045, fontWeight: FontWeight.w800, color: AppColors.black),),
                                     ),
                                     Text(": ${date??" "}",
                                       style:  TextStyle(fontSize: Get.width * 0.045, fontWeight: FontWeight.w500, color: AppColors.darkblue),)
                                   ],
                                 ),
                               ],
                             ),
                             lastdate == null?const SizedBox.shrink():
                             Column(
                               crossAxisAlignment: CrossAxisAlignment.start,
                               children: [
                                 SizedBox(height: Get.height*0.015,),
                                 Row(
                                   children: [
                                     SizedBox(
                                       width: Get.width*0.54,
                                       child:  Text("Last Date of Submission ",
                                         style: TextStyle(fontSize: Get.width * 0.045, fontWeight: FontWeight.w800, color: AppColors.black),),
                                     ),
                                     Text(": ${lastdate??" "}",
                                       style:  TextStyle(fontSize: Get.width * 0.045, fontWeight: FontWeight.w500, color: AppColors.darkblue),)
                                   ],
                                 ),
                               ],
                             ),

                             maxmarks == null?const SizedBox.shrink():
                             Column(
                               crossAxisAlignment: CrossAxisAlignment.start,
                               children: [
                                 SizedBox(height: Get.height*0.015,),
                                 Row(
                                   children: [
                                     SizedBox(
                                       width: Get.width*0.54,
                                       child:  Text("Max. Marks  ",
                                         style: TextStyle(fontSize: Get.width * 0.045, fontWeight: FontWeight.w800, color: AppColors.black),),
                                     ),
                                     Text(": ${maxmarks??" "}",
                                       style:  TextStyle(fontSize: Get.width * 0.045, fontWeight: FontWeight.w500, color: AppColors.darkblue),)
                                   ],
                                 ),
                               ],
                             ),

                             description == null ?const SizedBox.shrink()
                                 : Column(
                               crossAxisAlignment: CrossAxisAlignment.start,
                               children: [
                                 SizedBox(height: Get.height*0.015,),
                                  Text("Description  ",
                                   style: TextStyle(fontSize: Get.width * 0.045, fontWeight: FontWeight.w800, color: AppColors.black),),
                                 SizedBox(height: Get.height*0.01,),
                                 Padding(
                                   padding:  EdgeInsets.only(left: Get.width*0.25),
                                   child: Text(" $description",
                                     maxLines: 4,
                                     style:  TextStyle(fontSize: Get.width * 0.045, fontWeight: FontWeight.w500, color: AppColors.darkblue),),
                                 ),
                               ],
                             ),

                             SizedBox(height: Get.height*0.015,),
                             if(imgelink != "" && imgelink!.isNotEmpty)...{
                               const Text("Attachment : ",
                                 style: TextStyle(fontSize: 19, fontWeight: FontWeight.w800, color: AppColors.black),),
                             } else if(videolink != "" && videolink!.isNotEmpty)...{
                               const Text("Attachment : ",
                                 style: TextStyle(fontSize: 19, fontWeight: FontWeight.w800, color: AppColors.black),),
                             }else if(audiolink != "" && audiolink!.isNotEmpty)...{
                               const Text("Attachment : ",
                                 style: TextStyle(fontSize: 19, fontWeight: FontWeight.w800, color: AppColors.black),),
                             }else if(pdflink != "" && pdflink!.isNotEmpty)...{
                               const Text("Attachment : ",
                                 style: TextStyle(fontSize: 19, fontWeight: FontWeight.w800, color: AppColors.black),),
                             }
                             else...{
                                const SizedBox.shrink()
                               },

                             imgelink != ""  ?
                             Column(
                               crossAxisAlignment: CrossAxisAlignment.start,
                               children: [
                                 SizedBox(height: Get.height*0.015,),
                                 Row(
                                   children: [
                                     SizedBox(
                                       width: Get.width*0.54,
                                       child: const Text("Image  ",
                                         style: TextStyle(fontSize: 19, fontWeight: FontWeight.w800, color: AppColors.black),),
                                     ),
                                     SizedBox(width: Get.width*0.03,),
                                     InkWell(
                                       onTap: (){
                                         _launchURL(imgelink??"");
                                       },
                                       child: Container(
                                         height: Get.height*0.03,
                                         width: Get.width*0.15,
                                         decoration: BoxDecoration(
                                           color: AppColors.greencolor,
                                           borderRadius: BorderRadius.circular(10)
                                         ),
                                        child: const Center(
                                          child: Text("View",
                                          style: TextStyle(color: AppColors.white,
                                          fontWeight: FontWeight.w800),),
                                        )
                                       ),
                                     ),
                                     // Text(imgelink??"",
                                     //   style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500, color: AppColors.darkblue),)
                                   ],
                                 ),
                               ],
                             ):const SizedBox.shrink(),

                             videolink != "" && videolink!.isNotEmpty ?
                             Column(
                               crossAxisAlignment: CrossAxisAlignment.start,
                               children: [
                                 SizedBox(height: Get.height*0.015,),
                                 Row(
                                   children: [
                                     SizedBox(
                                       width: Get.width*0.54,
                                       child: const Text("Video  ",
                                         style: TextStyle(fontSize: 19, fontWeight: FontWeight.w800, color: AppColors.black),),
                                     ),
                                     SizedBox(width: Get.width*0.03,),
                                     InkWell(
                                       onTap: (){
                                         _launchURL(videolink??"");
                                       },
                                       child: Container(
                                           height: Get.height*0.03,
                                           width: Get.width*0.15,
                                           decoration: BoxDecoration(
                                               color: AppColors.purplecolor,
                                               borderRadius: BorderRadius.circular(10)
                                           ),
                                           child: const Center(
                                             child: Text("View",
                                               style: TextStyle(color: AppColors.white,
                                                   fontWeight: FontWeight.w800),),
                                           )
                                       ),
                                     ),
                                     // Text(videolink??"",
                                     //   style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500, color: AppColors.darkblue),)
                                   ],
                                 ),
                               ],
                             ):const SizedBox.shrink(),

                             audiolink != "" && audiolink!.isNotEmpty ?
                             Column(
                               crossAxisAlignment: CrossAxisAlignment.start,
                               children: [
                                 SizedBox(height: Get.height*0.015,),
                                 Row(
                                   children: [
                                     SizedBox(
                                       width: Get.width*0.54,
                                       child: const Text("Audio ",
                                         style: TextStyle(fontSize: 19, fontWeight: FontWeight.w800, color: AppColors.black),),
                                     ),
                                     SizedBox(width: Get.width*0.03,),
                                     InkWell(
                                       onTap: (){
                                         _launchURL(audiolink??"");
                                       },
                                       child: Container(
                                           height: Get.height*0.03,
                                           width: Get.width*0.15,
                                           decoration: BoxDecoration(
                                               color: AppColors.yellow,
                                               borderRadius: BorderRadius.circular(10)
                                           ),
                                           child: const Center(
                                             child: Text("View",
                                               style: TextStyle(color: AppColors.white,
                                                   fontWeight: FontWeight.w800),),
                                           )
                                       ),
                                     ),
                                     // Text(audiolink??"",
                                     //   style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500, color: AppColors.darkblue),)
                                   ],
                                 ),
                               ],
                             ):const SizedBox.shrink(),

                             pdflink != "" && pdflink!.isNotEmpty ?
                             Column(
                               crossAxisAlignment: CrossAxisAlignment.start,
                               children: [
                                 SizedBox(height: Get.height*0.015,),
                                 Row(
                                   children: [
                                     SizedBox(
                                       width: Get.width*0.54,
                                       child: const Text("Pdf  ",
                                         style: TextStyle(fontSize: 19, fontWeight: FontWeight.w800, color: AppColors.black),),
                                     ),
                                     SizedBox(width: Get.width*0.03,),
                                     InkWell(
                                       onTap: (){
                                         _launchURL(pdflink??"");
                                       },
                                       child: Container(
                                           height: Get.height*0.03,
                                           width: Get.width*0.15,
                                           decoration: BoxDecoration(
                                               color: AppColors.redcolor,
                                               borderRadius: BorderRadius.circular(10)
                                           ),
                                           child: const Center(
                                             child: Text("View",
                                               style: TextStyle(color: AppColors.white,
                                                   fontWeight: FontWeight.w800),),
                                           )
                                       ),
                                     ),
                                     // Text(pdflink??"",
                                     //   style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500, color: AppColors.darkblue),)
                                   ],
                                 ),
                               ],
                             ):const SizedBox.shrink(),

                             SizedBox(
                               height: Get.height * 0.02,
                             ),
                             AppButton(
                                 buttonName: "Cancel",
                                 onTap: (){
                                   Get.back();
                                 },
                                 isIconShow: false,
                                 height: Get.height*0.071,
                                 fontSize: 18,
                                 fontweight: FontWeight.w600,
                                 width: Get.width* 0.65,
                                 backgroundColor: AppColors.darkblue,
                                 //iconColor: AppColors.bluishBlack,
                                 textColor: const Color(0xffFFFFFF)
                             ),
                             SizedBox(height: Get.height*0.02,),
                           ],
                         ),
                       ),
                     );
                   }
               );
             },
           ),
         )
     );
   }


   _launchURL(String title) async {
     final url = title;
     if (await canLaunch(url)) {
       await launch(url);
     } else {
       throw 'Could not launch $url';
     }
   }

   void _menuBottomSheetMenu(context){
     showModalBottomSheet(
         isScrollControlled: true,
         barrierColor: Colors.white.withOpacity(0),
         backgroundColor: Colors.transparent,
         shape: RoundedRectangleBorder(
           borderRadius: BorderRadius.circular(50.0),
         ),
         context: context,
         builder: (BuildContext buildContext){
           return DraggableScrollableSheet(
             builder: (context, scrollController) => SingleChildScrollView(
               controller: scrollController,
               child: StatefulBuilder(
                   builder: (BuildContext context, StateSetter setState /*You can rename this!*/){
                     return ClipRRect(
                       borderRadius: const BorderRadius.all(Radius.circular(20)),
                       child: BackdropFilter(
                         filter: ImageFilter.blur(
                           sigmaX: 20.0,
                           sigmaY: 20.0,
                         ),
                         child: Container(
                           height: Get.height*0.65,
                           width: Get.width*0.7,
                           decoration: const BoxDecoration(
                             borderRadius: BorderRadius.all(Radius.circular(20)),
                             color: Colors.transparent,
                           ),

                           child: Container(
                               padding: EdgeInsets.only(left: Get.width*0.05, right: Get.width*0.04, top: Get.height*0.0),
                               decoration: const BoxDecoration(
                                   color: Colors.transparent,
                                   borderRadius: BorderRadius.only(
                                       topLeft: Radius.circular(50.0),
                                       topRight: Radius.circular(50.0))),
                               child: Column(
                                 crossAxisAlignment: CrossAxisAlignment.center,
                                 mainAxisAlignment: MainAxisAlignment.center,
                                 children: [
                                   //SizedBox(height: Get.height*0.03,),
                                   Card(
                                     shape: const RoundedRectangleBorder(
                                       borderRadius: BorderRadius.all(Radius.circular(20)),
                                     ),
                                     child: Container(
                                       height: Get.height*0.35,
                                       decoration: const BoxDecoration(
                                         borderRadius: BorderRadius.all(Radius.circular(20)),
                                       ),
                                       //padding: EdgeInsets.only(left: Get.width*0.05, right: Get.width*0.05, top: Get.height*0.02),
                                       child: Column(
                                         crossAxisAlignment: CrossAxisAlignment.center,
                                         mainAxisAlignment: MainAxisAlignment.center,
                                         children: [
                                           SizedBox(
                                             height: Get.height*0.04,
                                             child: InkWell(
                                               onTap: (){
                                                 getImage().whenComplete(() => setState(() {}));

                                               },
                                               child: Row(
                                                 children: [
                                                   SizedBox(width: Get.width*0.02,),
                                                   Image.asset('assets/images/image.png'),
                                                   SizedBox(width: Get.width*0.02,),
                                                   SizedBox(
                                                     width: Get.width*0.6,
                                                     child: Text(imageFile != null
                                                         ? imageFile!.path.toString()
                                                         : 'Upload Image',
                                                       overflow: TextOverflow.ellipsis,
                                                       style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15, color: AppColors.textcolor),),
                                                   ),
                                                   imageFile != null
                                                       ?InkWell(
                                                     onTap: (){
                                                       setState(() {
                                                         clearimage();
                                                         //imageFile = null;
                                                       });
                                                     },
                                                     child: const CircleAvatar(
                                                         radius: 10,
                                                         child: Center(child: Icon(Icons.remove,size: 18,))),
                                                   )
                                                       :const SizedBox.shrink()
                                                 ],
                                               ),
                                             ),
                                           ),
                                           SizedBox(height: Get.height*0.01,),
                                           const Divider(
                                             color: AppColors.darkblue,
                                             thickness: 2,
                                           ),
                                          // SizedBox(height: Get.height*0.01,),
                                           SizedBox(
                                              height: Get.height*0.055,
                                             child: InkWell(
                                               // onTap: (){
                                               //   //_pickVideo().whenComplete(() => setState(() {}));
                                               // },
                                               child: Row(
                                                 children: [
                                                   SizedBox(width: Get.width*0.02,),
                                                  Image.asset('assets/images/video1.png'),
                                                  SizedBox(width: Get.width*0.02,),
                                                   // SizedBox(
                                                   //     height: Get.height*0.06,
                                                   //     width: Get.width*0.6,
                                                   //     child: TextField(
                                                   //       controller: assignmentController.videoController,
                                                   //       style: TextStyle(fontWeight: FontWeight.w600, fontSize: 17), //editing controller of this TextField
                                                   //       decoration:  InputDecoration(
                                                   //         // prefixIcon: Image.asset('assets/images/video1.png'),
                                                   //         hintText: 'Paste Youtube video link',
                                                   //         hintStyle:TextStyle(fontWeight: FontWeight.w600, fontSize: 17, color: AppColors.textcolor),
                                                   //         border: InputBorder.none,
                                                   //       ),
                                                   //     )
                                                   // ),
                                                   SizedBox(
                                                     width: Get.width*0.6,
                                                     height: Get.height*0.06,
                                                     child: TextFormField(
                                                       controller: assignmentController.videoController,
                                                       style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15,color: AppColors.textcolor),
                                                       decoration:  InputDecoration(
                                                        // prefix:  Image.asset('assets/images/video1.png'),
                                                           hintText: 'Paste Youtube video link',
                                                           border: InputBorder.none,
                                                           hintStyle: TextStyle(fontWeight: FontWeight.w600, fontSize: 15, color: AppColors.textcolor),
                                                       ),
                                                     ),
                                                   ),
                                                   assignmentController.videoController.text.isNotEmpty
                                                       ?InkWell(
                                                     onTap: (){
                                                       setState(() {
                                                         assignmentController.videoController.text = "";
                                                         //imageFile = null;
                                                       });
                                                     },
                                                     child: const CircleAvatar(
                                                         radius: 10,
                                                         child: Center(child: Icon(Icons.remove,size: 18,))),
                                                   )
                                                       :const SizedBox.shrink()
                                                 ],
                                               ),
                                             ),
                                           ),
                                           //SizedBox(height: Get.height*0.01,),
                                           const Divider(
                                             color: AppColors.darkblue,
                                             thickness: 2,
                                           ),
                                           SizedBox(height: Get.height*0.01,),
                                           SizedBox(
                                             height: Get.height*0.04,
                                             child: InkWell(
                                               onTap: (){
                                                 getaudioAndUpload().whenComplete(() => setState(() {}));
                                               },
                                               child: Row(
                                                 children: [
                                                   SizedBox(width: Get.width*0.02,),
                                                   Image.asset('assets/images/mic.png'),
                                                   SizedBox(width: Get.width*0.02,),
                                                   SizedBox(
                                                     width: Get.width*0.6,
                                                     child: Text(file2?.path != null
                                                         ? file2!.path.toString()
                                                         :'Upload Audio',
                                                       overflow: TextOverflow.ellipsis,
                                                       style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15, color: AppColors.textcolor),),
                                                   ),
                                                   file2 != null
                                                       ?InkWell(
                                                     onTap: (){
                                                       setState(() {
                                                         clearaudio();
                                                         //imageFile = null;
                                                       });
                                                     },
                                                     child: const CircleAvatar(
                                                         radius: 10,
                                                         child: Center(child: Icon(Icons.remove,size: 18,))),
                                                   )
                                                       :const SizedBox.shrink()
                                                 ],
                                               ),
                                             ),
                                           ),
                                           SizedBox(height: Get.height*0.01,),
                                           const Divider(
                                             color: AppColors.darkblue,
                                             thickness: 2,
                                           ),
                                           SizedBox(height: Get.height*0.01,),
                                           SizedBox(
                                             height: Get.height*0.04,
                                             child: InkWell(
                                               onTap: (){
                                                 getPdfAndUpload().whenComplete(() => setState(() {}));
                                               },
                                               child: Row(
                                                 children: [
                                                   SizedBox(width: Get.width*0.02,),
                                                   Image.asset('assets/images/link1.png'),
                                                   SizedBox(width: Get.width*0.02,),
                                                   SizedBox(
                                                     width: Get.width*0.6,
                                                     child: Text(file1?.path !=null
                                                         ?file1!.path
                                                         : 'Pdf link',
                                                       overflow: TextOverflow.ellipsis,
                                                       style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15, color: AppColors.textcolor),),
                                                   ),
                                                   file1 != null
                                                       ?InkWell(
                                                     onTap: (){
                                                       setState(() {
                                                         clearpdf();
                                                         //imageFile = null;
                                                       });
                                                     },
                                                     child: const CircleAvatar(
                                                         radius: 10,
                                                         child: Center(child: Icon(Icons.remove,size: 18,))),
                                                   )
                                                       :const SizedBox.shrink()
                                                 ],
                                               ),
                                             ),
                                           ),
                                         ],
                                       ),
                                     ),
                                   ),

                                   SizedBox(height: Get.height*0.01,),
                                   AppButton(
                                       buttonName: "Cancel",
                                       onTap: (){
                                         Navigator.pop(context);
                                       },
                                       isIconShow: false,
                                       height: Get.height*0.071,
                                       fontSize: 18,
                                       fontweight: FontWeight.w600,
                                       width: Get.width* 0.7,
                                       backgroundColor:AppColors.darkblue,
                                       //iconColor: AppColors.bluishBlack,
                                       textColor: AppColors.white),
                                   SizedBox(height: Get.height*0.12,),
                                 ],
                               )
                           ),
                         ),
                       ),
                     );
                   }
               ),
             ),
           );
         }
     );
   }

   Widget root() {
     return Container(
       child: imageFile != null
           ? Image.file(
         imageFile!,
         height: MediaQuery
             .of(context)
             .size
             .height / 5,
       )
           : const Text("Pick up the  image"),
     );
   }

}
