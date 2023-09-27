import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:get/get.dart';
import 'package:staffapp/views/app_screen/detail_screen.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../controller/exam_result_controller.dart';
import '../../controller/exam_schedule_controller.dart';
import '../../controller/grade_controller.dart';
import '../../helpers/app_manager.dart';
import '../../utils/app_button.dart';
import '../../utils/appcolors_theme.dart';
import '../../utils/drawer_widget.dart';
import 'create_live_class_screen.dart';
import 'attachment_detail_screen.dart';
import 'exam_result_screen.dart';

class ExamScreen extends StatefulWidget {
   ExamScreen({Key? key}) : super(key: key);

  @override
  State<ExamScreen> createState() => _ExamScreenState();
}

class _ExamScreenState extends State<ExamScreen> {

  final GlobalKey<ScaffoldState> examscaffoldEy = GlobalKey<ScaffoldState>();

  final examimageList = [
    "assets/images/exam_card1.png",
    "assets/images/exam_card2.png",
    "assets/images/exam_card3.png",
  ];
  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   examScheduleController.getExamScheduleData(refresh: true);
  // }

   ExamResultController examResultsController = Get.put(ExamResultController());

   final colorList = [
     Colors.blue.shade400,
     Colors.orange.shade300,
     Colors.red.shade300,
     Colors.purple.shade300,
     Colors.green.shade300
   ];

   GradeController gradeController = Get.put(GradeController());

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
           style:  TextStyle(
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
  ExamScheduleController examScheduleController = Get.put(ExamScheduleController());

  final RefreshController homeRefreshController = RefreshController();

  void onRefresh() async {
    try {
      await examScheduleController.getExamScheduleData(refresh: true);
      homeRefreshController.refreshCompleted();
    } catch (e) {
      homeRefreshController.refreshFailed();
    }
  }

  void onLoading() async {
    homeRefreshController.refreshCompleted();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.screencolor,
        key: examscaffoldEy,
        drawer: DrawerElement(),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: AppColors.darkblue,
          centerTitle: true,
          leading:  IconButton(
              onPressed: (){
                examscaffoldEy.currentState!.openDrawer();
              },
              icon: const Icon(Icons.menu, color: AppColors.white,)
          ),
          title: const Text('Exam',
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 22, color: AppColors.white),),
        ),
        body: GetBuilder<ExamScheduleController>(
          init: Get.put(ExamScheduleController()),
          //global: false,
          builder: (examScheduleController){
            return examScheduleController.examData.value.data == null
                  ? const Center(child: CircularProgressIndicator())
                  :SmartRefresher(
              physics:  BouncingScrollPhysics(),
                 controller: homeRefreshController,
                 onRefresh: () => onRefresh(),
                 onLoading: () => onLoading(),
                  child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                height: 45,
                                width: AppManager.dashController.restoreInchargeListModel().classSection == null
                                    ?Get.width
                                    :Get.width*0.5,
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(width: 1.0, color: AppColors.darkblue),
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    SizedBox(width: 10,),
                                    Image.asset("assets/images/user-group.png"),
                                    SizedBox(width: 8,),
                                    Text(AppManager.dashController.restoreInchargeListModel().classSection == null?
                                    ("Class - ${AppManager.dashController.restoreClassInchargeListModel().classSection??""}")
                                        : ("Class - ${AppManager.dashController.restoreInchargeListModel().classSection??""}"),
                                      style: TextStyle(fontWeight: FontWeight.w700, fontSize: Get.width * 0.04,
                                          color: AppColors.darkblue),),
                                  ],
                                ),
                              ),
                              AppManager.dashController.restoreInchargeListModel().classSection == null
                                  ?SizedBox.shrink()
                                  : Container(
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
                                    SizedBox(width: 20,),
                                    Image.asset("assets/images/bookmark-alt.png"),
                                    SizedBox(width: 8,),
                                    if(AppManager.dashController.restoreInchargeListModel().classSection != null)...{
                                      Text("${AppManager.dashController.restoreInchargeListModel().subjectName}",
                                        style: TextStyle(fontWeight: FontWeight.w700, fontSize: Get.width * 0.04,
                                            color: AppColors.darkblue),)
                                    }else...{
                                      Text('')
                                    },
                                  ],
                                ),
                              )
                            ],
                          ),

                          Column(
                            children: [
                              SizedBox(height: 15,),
                              Padding(
                                padding:  EdgeInsets.only(left: Get.width*0.04, right: Get.width*0.04),
                                child: Container(
                                  width: Get.width*0.87,
                                  //height: Get.height*0.065,
                                  padding: EdgeInsets.only(left: Get.width*0.01),
                                  decoration: BoxDecoration(
                                      color: AppColors.white,
                                      border: Border.all(color: AppColors.darkblue, width: 2.0),
                                      borderRadius: BorderRadius.circular(20)
                                  ),
                                  child: TextFormField(
                                      decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: "Search",
                                          prefixIcon: Icon(Icons.search, color: AppColors.darkblue,)
                                      ),
                                      controller: _textEditingController,
                                      onChanged: (query){
                                        final searchResult = examScheduleController.examData.value.data?.where((element) {
                                          final title = element.subjectName?.toLowerCase();
                                          final queryLowerCase = query.toLowerCase();
                                          return title!.contains(queryLowerCase);
                                        }).toList();
                                        examScheduleController.filterdata.value = searchResult!;
                                        setState(() {});
                                      }
                                  ),
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
                              ),
                              SizedBox(height: 15,),
                              Padding(
                                padding:  EdgeInsets.only(left: Get.width*0.04, right: Get.width*0.04),
                                child: ListView.separated(
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    separatorBuilder: (BuildContext context, int index) => SizedBox(height: Get.height*0.02,),
                                    itemCount: examScheduleController.filterdata.value.length,
                                    itemBuilder: (BuildContext context, int index) {
                                      return  Card(
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                                        child: Container(
                                            width: Get.width*0.99,
                                            padding: EdgeInsets.only(left: Get.width*0.05,top: Get.height*0.023, ),
                                            decoration: BoxDecoration(
                                              //color: Colors.transparent,
                                              borderRadius: BorderRadius.circular(10),
                                              // image: DecorationImage(
                                              //     image: AssetImage(assignmentimageList[index % assignmentimageList.length]),
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
                                                      RichText(
                                                        text: TextSpan(
                                                            children: highlightOccurrences(examScheduleController.filterdata.value[index].subjectName??"", _textEditingController.text),
                                                            style: TextStyle(fontSize: Get.width * 0.04, fontWeight: FontWeight.w700, color: AppColors.lightbluecolor)
                                                        ),
                                                      ),
                                                      // SizedBox(
                                                      //   width: Get.width*0.5,
                                                      //   child: Text('${examScheduleController.filterdata.value[index].subjectName}',
                                                      //     overflow: TextOverflow.ellipsis,
                                                      //     maxLines: 1,
                                                      //     style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: AppColors.lightbluecolor),),
                                                      // ),
                                                      // Text('${examScheduleController.filterdata.value[index].}',
                                                      //   style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: AppColors.darkblue),),
                                                    ],
                                                  ),
                                                ),
                                                Divider(
                                                  color: AppColors.darkblue,
                                                  thickness: 1,
                                                  endIndent: 16,
                                                ),
                                                //SizedBox(height: Get.height*0.007,),
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
                                                              Container(
                                                                height: Get.height*0.06,
                                                                width: 5,
                                                                decoration: BoxDecoration(
                                                                    color: AppColors.lightbluecolor,
                                                                    borderRadius: BorderRadius.circular(5)
                                                                ),
                                                              ),
                                                              SizedBox(width: 10),
                                                              Column(
                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                children: [
                                                                  Text('${examScheduleController.filterdata.value[index].exam??""}',
                                                                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: AppColors.textcolor),),
                                                                  SizedBox(height: Get.height*0.007,),
                                                                  Text('${examScheduleController.filterdata.value[index].classSection}',
                                                                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: AppColors.darkblue),),

                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                          GestureDetector(
                                                            onTap: (){
                                                              showDetailDialog(
                                                                context,
                                                                classtestid: examScheduleController.filterdata.value[index].recordId,
                                                                maxmarks:examScheduleController.filterdata.value[index].maxMarks,
                                                                subject:examScheduleController.filterdata.value[index].subjectName,
                                                                name: examScheduleController.filterdata.value[index].exam,
                                                                classsection: examScheduleController.filterdata.value[index].classSection,
                                                               // date:  examScheduleController.filterdata.value[index].da,
                                                              );
                                                              // Get.to(()=> DeatailScreen(
                                                              //   name: examScheduleController.filterdata.value[index].exam,
                                                              //   subject: examScheduleController.filterdata.value[index].subjectName,
                                                              //   classsection: examScheduleController.filterdata.value[index].classSection,
                                                              //  maxmarks: examScheduleController.filterdata.value[index].maxMarks,
                                                              // ));
                                                            },
                                                            child: SizedBox(
                                                              height: Get.height*0.065,
                                                              child: Column(
                                                                children: [
                                                                  Image.asset("assets/images/eye.png"),
                                                                  Text("View",
                                                                    style: TextStyle(color: AppColors.darkblue, fontSize: 14, fontWeight: FontWeight.w500),)
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(height: Get.height*0.012,),
                                                      if(examScheduleController.filterdata.value[index].maxMarks == "0")...{
                                                        Text('Max. Grade: A+',
                                                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: AppColors.textcolor),),

                                                      }else...{
                                                        Text('Max. Marks: ${examScheduleController.filterdata.value[index].maxMarks??""}',
                                                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: AppColors.textcolor),),
                                                      }

                                                      // Text('${examScheduleController.filterdata.value[index].classSection}',
                                                      //   style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color:  AppColors.black),),
                                                      // SizedBox(height: Get.height*0.007,),

                                                      // Text('${examScheduleController.examData.value.data?[index].subjectName??""}',
                                                      //   style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: AppColors.black),),
                                                      // SizedBox(height: Get.height*0.007,),
                                                      // Text('${examScheduleController.examData.value.data?[index].date}',
                                                      //   style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: AppColors.white),),
                                                      // SizedBox(height: Get.height*0.007,),
                                                      // Text('${examScheduleController.filterdata.value[index].maxMarks}',
                                                      //   style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color:  AppColors.black),),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(height: Get.height*0.019,),
                                                Padding(
                                                  padding:  EdgeInsets.only(left: Get.width*0.028),
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      InkWell(
                                                        onTap: (){
                                                          Loader.show(context,
                                                              progressIndicator: const CircularProgressIndicator());
                                                          examScheduleController.publishexamdata(refresh: true,
                                                               examtypeid: examScheduleController.filterdata.value[index].examinationTypeId,
                                                              classid: examScheduleController.filterdata.value[index].classId);
                                                          Future.delayed(const Duration(seconds: 3), () {
                                                            Loader.hide();
                                                          });
                                                        },
                                                        child: SizedBox(
                                                          height: Get.height*0.06,
                                                          child: Column(
                                                            children: [
                                                              Image.asset('assets/images/send.png',),
                                                              SizedBox(height: 3),
                                                              if(examScheduleController.filterdata.value[index].isPublsih == "True")...{
                                                                Text('Published',
                                                                  style: TextStyle(
                                                                      color: AppColors.darkblue,
                                                                      fontWeight: FontWeight.w500,fontSize: 13
                                                                  ),)
                                                              }else...{
                                                                Text('Publish',
                                                                  style: TextStyle(
                                                                      color: AppColors.darkblue,
                                                                      fontWeight: FontWeight.w500,fontSize: 13
                                                                  ),)
                                                              }
                                                            ],
                                                          ),
                                                        ),
                                                      ),

                                                      InkWell(
                                                        onTap: (){
                                                          if(!examResultsController.isBlock.value){
                                                            gradeController.getgradeData(refresh: true,
                                                                classsectionidd: AppManager.dashController.restoreInchargeListModel().classSection == null?
                                                                AppManager.dashController.restoreClassInchargeListModel().classSectionId
                                                                    : AppManager.dashController.restoreInchargeListModel().classSectionId,
                                                                subjecttypeid: examScheduleController.filterdata.value[index].subjectTypeId);
                                                            examResultsController.getExamResultData(refresh: true,
                                                                examschid:examScheduleController.filterdata.value[index].recordId)
                                                                .whenComplete(() => Get.to(()=> ExamResultScreen(
                                                                examid: examScheduleController.filterdata.value[index].recordId,
                                                                inputype:  examScheduleController.filterdata.value[index].inputType,
                                                                maxmarks: examScheduleController.filterdata.value[index].maxMarks,
                                                                maxgrade : examScheduleController.filterdata.value[index].maxGrade,
                                                                subject: examScheduleController.filterdata.value[index].subjectName,
                                                                name: examScheduleController.filterdata.value[index].exam
                                                            )));
                                                          }
                                                        },
                                                        child: Container(
                                                          height: Get.height*0.07,
                                                          child: Column(
                                                            children: [
                                                              Image.asset('assets/images/check-circle.png'),
                                                              SizedBox(height: 3),
                                                              Text('Enter Result',
                                                                style: TextStyle(
                                                                    color: AppColors.darkblue,
                                                                    fontWeight: FontWeight.w500,fontSize: 13
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
                                                                    Text(
                                                                      "You don't have a \npermission to delete the exam",
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
                                                                          child: Center(
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
                                                          width: Get.width*0.19,
                                                          height: Get.height*0.053,
                                                          decoration: BoxDecoration(
                                                            color: AppColors.darkblue,
                                                            borderRadius: BorderRadius.only(
                                                                topLeft: Radius.circular(20.0),
                                                                bottomLeft: Radius.circular(20.0)),
                                                          ),
                                                          child: Image.asset('assets/images/trash-2.png'),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                // SizedBox(height: Get.height*0.01,),
                                                // const Divider(
                                                //   color: AppColors.black,
                                                //   thickness: 2,
                                                // ),
                                                // Row(
                                                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                //   children: [
                                                //     GestureDetector(
                                                //       onTap: (){
                                                //         gradeController.getgradeData(refresh: true);
                                                //         examResultsController.getExamResultData(refresh: true,
                                                //             examschid:examScheduleController.filterdata.value[index].recordId);
                                                //         Get.to(()=> ExamResultScreen(
                                                //             examid: examScheduleController.filterdata.value[index].recordId,
                                                //             inputype:  examScheduleController.filterdata.value[index].inputType,
                                                //             maxmarks: examScheduleController.filterdata.value[index].maxMarks,
                                                //             subject: examScheduleController.filterdata.value[index].subjectName,
                                                //             name: examScheduleController.filterdata.value[index].exam
                                                //         ));
                                                //       },
                                                //       child: Row(
                                                //         children: [
                                                //           Image.asset('assets/images/check.png',color: AppColors.black,),
                                                //           SizedBox(width: Get.width*0.015,),
                                                //           const Text('Enter Result',
                                                //               style: TextStyle(
                                                //                   color: AppColors.black,fontWeight: FontWeight.w800
                                                //               ))
                                                //         ],
                                                //       ),
                                                //     ),
                                                //     Row(
                                                //       children: [
                                                //         Image.asset('assets/images/publish.png',color: AppColors.black,),
                                                //         SizedBox(width: Get.width*0.015,),
                                                //         const Text('Publish',
                                                //             style: TextStyle(
                                                //                 color: AppColors.black,fontWeight: FontWeight.w800
                                                //             ))
                                                //       ],
                                                //     ),
                                                //     Row(
                                                //       children: [
                                                //         Image.asset('assets/images/Delete Bin.png',color: AppColors.black,),
                                                //         SizedBox(width: Get.width*0.015,),
                                                //         const Text('Delete',
                                                //           style: TextStyle(
                                                //               color: AppColors.black,fontWeight: FontWeight.w800
                                                //           ),)
                                                //       ],
                                                //     ),
                                                //   ],
                                                // ),
                                                 SizedBox(height: 14,),
                                              ],
                                            )
                                        ),
                                      );
                                    }),
                              ),
                            ],
                          ),
                        ],
                      ),
                  ),
                );
          }
        ),
      ),
    );
  }

   showDetailDialog(BuildContext context,
       {String? classtestid,String? name,
         String? subject,
         String? classsection,
         String? maxmarks,
         String? date,}) {
     showDialog(
         context: context,
         builder: (_) =>  AlertDialog(
           insetPadding: EdgeInsets.only(top: Get.height*0.08, bottom: Get.height*0.08, left: Get.width*0.06, right: Get.width*0.06),
           contentPadding: EdgeInsets.zero,
           scrollable: true,
           clipBehavior: Clip.antiAliasWithSaveLayer,
           shape: RoundedRectangleBorder(
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
                       height: height*0.4,
                       width: width,
                       child: Padding(
                         padding:  EdgeInsets.only(left: Get.width*0.045, right: Get.width*0.0),
                         child: Column(
                           crossAxisAlignment: CrossAxisAlignment.start,
                           children: [
                             SizedBox(height: Get.height*0.03,),
                             Row(
                               mainAxisAlignment: MainAxisAlignment.center,
                               children: [
                                 // SizedBox(
                                 //   width: Get.width*0.2,
                                 //   child: Text("Name : ",
                                 //     style: TextStyle(fontSize: 19, fontWeight: FontWeight.w800, color: AppColors.black),),
                                 // ),
                                 Text(name??"",
                                   style: TextStyle(fontSize: 17, fontWeight: FontWeight.w800, color: AppColors.darkblue),)
                               ],
                             ),

                             SizedBox(height: Get.height*0.015,),
                             Row(
                               children: [
                                 SizedBox(
                                   width: Get.width*0.35,
                                   child: Text("Class Section ",
                                     style: TextStyle(fontSize: 19, fontWeight: FontWeight.w800, color: AppColors.black),),
                                 ),
                                 Text(": ${classsection ?? ""}",
                                   style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500, color: AppColors.darkblue),)
                               ],
                             ),
                             SizedBox(height: Get.height*0.015,),
                             Row(
                               children: [
                                 SizedBox(
                                   width: Get.width*0.35,
                                   child: Text("Subject  ",
                                     style: TextStyle(fontSize: 19, fontWeight: FontWeight.w800, color: AppColors.black),),
                                 ),
                                 SizedBox(
                                   width: Get.width*0.4,
                                   child: Text(": ${subject ?? ""}",
                                     overflow: TextOverflow.ellipsis,
                                     style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500, color: AppColors.darkblue),),
                                 )
                               ],
                             ),

                             date == null?SizedBox.shrink():
                             Column(
                               children: [
                                 SizedBox(height: Get.height*0.015,),
                                 Row(
                                   children: [
                                     SizedBox(
                                       width: Get.width*0.35,
                                       child: Text("Date ",
                                         style: TextStyle(fontSize: 19, fontWeight: FontWeight.w800, color: AppColors.black),),
                                     ),
                                     Text(": ${date??" "}",
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
                                 if(maxmarks == "0")...{
                                   Container()
                                 }else...{
                                   Row(
                                     children: [
                                       SizedBox(
                                         width: Get.width*0.35,
                                         child: Text("Max. Marks  ",
                                           style: TextStyle(fontSize: 19, fontWeight: FontWeight.w800, color: AppColors.black),),
                                       ),
                                       Text(": ${maxmarks ?? ""}",
                                         style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500, color: AppColors.darkblue),)
                                     ],
                                   ),
                                 }

                               ],
                             ),

                             SizedBox(
                               height: Get.height * 0.08,
                             ),
                             Padding(
                               padding:  EdgeInsets.only(right: Get.width*0.05),
                               child: AppButton(
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
                             ),

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
}
