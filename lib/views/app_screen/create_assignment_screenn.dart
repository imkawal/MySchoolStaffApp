import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:staffapp/views/app_screen/assignment_screen.dart';
import 'dart:io';
import '../../controller/assignment_controller.dart';
import '../../controller/class_subject_controller.dart';
import '../../helpers/app_manager.dart';
import '../../models/class_subject_response_model.dart';
import '../../utils/app_button.dart';
import '../../utils/appcolors_theme.dart';
import '../../utils/appstrings.dart';
import '../../utils/apptext_field.dart';

class CreateAssignmentScreen extends StatefulWidget {
   CreateAssignmentScreen({Key? key}) : super(key: key);

  @override
  State<CreateAssignmentScreen> createState() => _CreateAssignmentScreenState();
}

class _CreateAssignmentScreenState extends State<CreateAssignmentScreen> {
   AssignmentController assignmentController = Get.put(AssignmentController());

  String ClassSection = AppManager.dashController.restoreInchargeListModel().classSection == null?
  AppManager.dashController.restoreClassInchargeListModel().classSection??''
      : AppManager.dashController.restoreInchargeListModel().classSection??"";

  String classSubject = "";

   ClassSubjectController classSubjectController = Get.find<ClassSubjectController>();

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
                            'Create Assignment',
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
                          height: Get.height * 0.01,
                        ),
                        Row(
                          children: [
                            Text(" ${ClassSection }",
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),),
                            if(AppManager.dashController.restoreInchargeListModel().classSection != null)...{
                              Text("(${AppManager.dashController.restoreInchargeListModel().subjectName})",
                                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),),
                            }else...{
                              Text('')
                            }
                          ],
                        ),
                        SizedBox(
                          height: Get.height * 0.02,
                        ),
                        // AssignmentTextField(
                        //   hintText: AppStrings.classsection,
                        //   //controller: con.userNameController,
                        //   // validator: validateEmail,
                        // ),
                        // SizedBox(
                        //   height: Get.height * 0.028,
                        // ),
                        AssignmentTextField(
                          hintText: AppStrings.topicname,
                          controller: assignmentController.nameController,
                          // validator: validateEmail,
                        ),
                        SizedBox(
                          height: Get.height * 0.028,
                        ),
                        AssignmentTextField(
                          hintText: AppStrings.assigndescription,
                          controller: assignmentController.assignmentdesController,
                          // validator: validateEmail,
                        ),
                        SizedBox(
                          height: Get.height * 0.028,
                        ),
                        if(AppManager.dashController.restoreInchargeListModel().classSection == null)...{
                          Obx(()=>
                              Padding(
                                padding:  EdgeInsets.only(bottom: Get.height*0.02),
                                child: Container(
                                  height: Get.height*0.065,
                                  width: Get.width*0.81,
                                  padding: EdgeInsets.only(left: Get.width*0.035),
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
                                        assignmentController.classsubjectidContoller.value = newVal.classSubjectId??"";
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

                        Container(
                            height: Get.height*0.065,
                            width: Get.width*0.81,
                            padding: EdgeInsets.only(left: Get.width*0.05, top: Get.height*0.008),
                            decoration: BoxDecoration(
                                border: Border.all(color: AppColors.backgroundpurple,),
                              borderRadius: BorderRadius.circular(6.0),
                            ),
                            child: TextFormField(
                                //textAlign: TextAlign.start,
                                controller: assignmentController.dateController,
                                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500,
                                    color: AppColors.black), //editing controller of this TextField
                                decoration:  InputDecoration(
                                  hintText: "Due Date",
                                  hintStyle: TextStyle(fontSize: 15, fontWeight: FontWeight.w500,
                                      color: AppColors.black),
                                  contentPadding: EdgeInsets.only(bottom: Get.height*0.018),
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
                          height: Get.height * 0.028,
                        ),
                        Container(
                            height: Get.height*0.065,
                            width: Get.width*0.81,
                            padding: EdgeInsets.only(left: Get.width*0.05, top: Get.height*0.008),
                            decoration: BoxDecoration(
                              border: Border.all(color: AppColors.backgroundpurple,),
                              borderRadius: BorderRadius.circular(6.0),
                            ),
                            child: TextFormField(
                              //textAlign: TextAlign.start,
                                controller: assignmentController.lastsubmitdateController,
                                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500,
                                    color: AppColors.black), //editing controller of this TextField
                                decoration:  InputDecoration(
                                  hintText: "Last Date for Submission",
                                  hintStyle: TextStyle(fontSize: 15, fontWeight: FontWeight.w500,
                                      color: AppColors.black),
                                  contentPadding: EdgeInsets.only(bottom: Get.height*0.018),
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
                        // AssignmentTextField(
                        //   hintText: AppStrings.duedate,
                        //   //controller: con.userNameController,
                        //   // validator: validateEmail,
                        // ),
                        // SizedBox(
                        //   height: Get.height * 0.028,
                        // ),
                        // AssignmentTextField(
                        //   hintText: AppStrings.time,
                        //   //controller: con.userNameController,
                        //   // validator: validateEmail,
                        // ),
                        SizedBox(
                          height: Get.height * 0.032,
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
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(color: AppColors.black)
                            ),
                            child: Row(
                              children: [
                                SizedBox(width: Get.width*0.02,),
                                Image.asset('assets/images/attachment_icon.png'),
                                SizedBox(width: Get.width*0.02,),
                                Text('Attachment',
                                style: TextStyle(fontWeight: FontWeight.w600),),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: Get.height * 0.08,
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
                                classsubectid: AppManager.dashController.restoreInchargeListModel().classSubjectId == null?
                              AppManager.dashController.restoreClassInchargeListModel().classSectionId??''
                                  : AppManager.dashController.restoreInchargeListModel().classSubjectId??"",
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
   void _menuBottomSheetMenu(context){
     showModalBottomSheet(
         shape: RoundedRectangleBorder(
           borderRadius: BorderRadius.circular(50.0),
         ),
         context: context,
         builder: (BuildContext buildContext){
           return StatefulBuilder(
             builder: (BuildContext context, StateSetter setState /*You can rename this!*/){
              return Container(
                 height: Get.height*0.57,
                 width: Get.width*0.7,
                 color: Colors.transparent,
                 child: Container(
                     padding: EdgeInsets.only(left: Get.width*0.05, right: Get.width*0.04, top: Get.height*0.02),
                     decoration: const BoxDecoration(
                         color: Colors.white,
                         borderRadius: BorderRadius.only(
                             topLeft: Radius.circular(50.0),
                             topRight: Radius.circular(50.0))),
                     child: Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         SizedBox(height: Get.height*0.03,),
                         Card(
                           child: Container(
                             height: Get.height*0.35,
                             padding: EdgeInsets.only(left: Get.width*0.05, right: Get.width*0.05, top: Get.height*0.02),
                             child: Column(
                               children: [
                                 InkWell(
                                   onTap: (){
                                     getImage().whenComplete(() => setState(() {}));

                                   },
                                   child: Row(
                                     children: [
                                       SizedBox(width: Get.width*0.02,),
                                       Image.asset('assets/images/uploadimaeg.png'),
                                       SizedBox(width: Get.width*0.02,),
                                       SizedBox(
                                         width: Get.width*0.6,
                                         child: Text(imageFile != null
                                             ? imageFile!.path.toString()
                                             : 'Upload Image',
                                           overflow: TextOverflow.ellipsis,
                                           style: TextStyle(fontWeight: FontWeight.w600, fontSize: 17),),
                                       ),
                                       imageFile != null
                                           ?InkWell(
                                         onTap: (){
                                           setState(() {
                                             clearimage();
                                             //imageFile = null;
                                           });
                                         },
                                             child: CircleAvatar(
                                         radius: 10,
                                             child: Center(child: Icon(Icons.remove,size: 18,))),
                                           )
                                           :SizedBox.shrink()
                                     ],
                                   ),
                                 ),
                                 SizedBox(height: Get.height*0.01,),
                                 Divider(
                                   color: AppColors.backgroundpurple,
                                   thickness: 3,
                                 ),
                                 //SizedBox(height: Get.height*0.03,),

                                 InkWell(
                                   // onTap: (){
                                   //   //_pickVideo().whenComplete(() => setState(() {}));
                                   // },
                                   child: Row(
                                     children: [
                                       SizedBox(width: Get.width*0.02,),
                                       Image.asset('assets/images/video.png'),
                                       SizedBox(width: Get.width*0.02,),
                                       SizedBox(
                                         width: Get.width*0.6,
                                         height: Get.height*0.06,
                                         child: Center(
                                           child: TextFormField(
                                             controller: assignmentController.videoController,
                                             style: TextStyle(fontWeight: FontWeight.w600, fontSize: 17),
                                             decoration: InputDecoration(
                                               hintText: 'Paste Youtube video link',
                                               border: InputBorder.none,
                                               hintStyle: TextStyle(fontWeight: FontWeight.w600, fontSize: 17, color: AppColors.black)
                                             ),
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
                                         child: CircleAvatar(
                                             radius: 10,
                                             child: Center(child: Icon(Icons.remove,size: 18,))),
                                       )
                                           :SizedBox.shrink()
                                     ],
                                   ),
                                 ),
                                 SizedBox(height: Get.height*0.01,),
                                 Divider(
                                   color: AppColors.backgroundpurple,
                                   thickness: 3,
                                 ),
                                 SizedBox(height: Get.height*0.03,),

                                 InkWell(
                                   onTap: (){
                                     getaudioAndUpload().whenComplete(() => setState(() {}));
                                   },
                                   child: Row(
                                     children: [
                                       SizedBox(width: Get.width*0.02,),
                                       Image.asset('assets/images/auddio.png'),
                                       SizedBox(width: Get.width*0.02,),
                                       SizedBox(
                                         width: Get.width*0.6,
                                         child: Text(file2?.path != null
                                             ? file2!.path.toString()
                                             :'Upload Audio',
                                           overflow: TextOverflow.ellipsis,
                                           style: TextStyle(fontWeight: FontWeight.w600, fontSize: 17),),
                                       ),
                                       file2 != null
                                           ?InkWell(
                                         onTap: (){
                                           setState(() {
                                             clearaudio();
                                             //imageFile = null;
                                           });
                                         },
                                         child: CircleAvatar(
                                             radius: 10,
                                             child: Center(child: Icon(Icons.remove,size: 18,))),
                                       )
                                           :SizedBox.shrink()
                                     ],
                                   ),
                                 ),
                                 SizedBox(height: Get.height*0.01,),
                                 Divider(
                                   color: AppColors.backgroundpurple,
                                   thickness: 3,
                                 ),
                                 SizedBox(height: Get.height*0.03,),

                                 InkWell(
                                   onTap: (){
                                     getPdfAndUpload().whenComplete(() => setState(() {}));
                                   },
                                   child: Row(
                                     children: [
                                       SizedBox(width: Get.width*0.02,),
                                       Image.asset('assets/images/pastelink.png'),
                                       SizedBox(width: Get.width*0.02,),
                                       SizedBox(
                                         width: Get.width*0.6,
                                         child: Text(file1?.path !=null
                                             ?file1!.path
                                             : 'Pdf link',
                                           overflow: TextOverflow.ellipsis,
                                           style: TextStyle(fontWeight: FontWeight.w600, fontSize: 17),),
                                       ),
                                       file1 != null
                                           ?InkWell(
                                         onTap: (){
                                           setState(() {
                                             clearpdf();
                                             //imageFile = null;
                                           });
                                         },
                                         child: CircleAvatar(
                                             radius: 10,
                                             child: Center(child: Icon(Icons.remove,size: 18,))),
                                       )
                                           :SizedBox.shrink()
                                     ],
                                   ),
                                 ),
                               ],
                             ),
                           ),
                         ),

                         SizedBox(height: Get.height*0.03,),
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
                             backgroundColor: AppColors.backgroundpurple,
                             //iconColor: AppColors.bluishBlack,
                             textColor: const Color(0xffFFFFFF)),
                       ],
                     )
                 ),
               );
             }
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
           : Text("Pick up the  image"),
     );
   }
}
