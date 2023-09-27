import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:staffapp/utils/app_button.dart';
import 'package:staffapp/utils/appstrings.dart';
import 'package:staffapp/utils/apptext_field.dart';
import 'package:staffapp/views/app_screen/attachment_detail_screen.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../controller/class_subject_controller.dart';
import '../../controller/class_test_controller.dart';
import '../../controller/class_test_result_controller.dart';
import '../../controller/grade_controller.dart';
import '../../helpers/app_manager.dart';
import '../../models/class_subject_response_model.dart';
import '../../utils/appcolors_theme.dart';
import '../../utils/drawer_widget.dart';
import 'create_test_screen.dart';
import 'class_test_result_screen.dart';
import 'detail_screen.dart';

class ClassTestScreen extends StatefulWidget {
   ClassTestScreen({Key? key}) : super(key: key);

  @override
  State<ClassTestScreen> createState() => _ClassTestScreenState();
}

class _ClassTestScreenState extends State<ClassTestScreen> {
  final GlobalKey<ScaffoldState> classtestscaffoldEy = GlobalKey<ScaffoldState>();

   final classtestimageList = [
     "assets/images/class_testcard1.png",
     "assets/images/class_testcard2.png"
   ];

   GradeController gradeController = Get.put(GradeController());

   ClassSubjectController classSubjectController = Get.put(ClassSubjectController());

   ClassTestResultController classTestResultController = Get.put(ClassTestResultController());

   ClassTestController classTestController = Get.put(ClassTestController());

   RefreshController refreshController = RefreshController(initialRefresh: false);

   // void onRefresh() async {
   //   await classTestController.getclassTestData(refresh: true);
   //   refreshController.refreshCompleted();
   // }
  void onRefresh() async {
    try {
      await classTestController.getclassTestData(refresh: true);
      refreshController.refreshCompleted();
    } catch (e) {
      refreshController.refreshCompleted();
    }
  }
   void onLoading() async {
     refreshController.loadComplete();
   }

    final colorList = [
      Colors.blue.shade400,
      Colors.orange.shade300,
      Colors.red.shade300,
      Colors.purple.shade300,
      Colors.green.shade300
    ];

   DateTime date = DateTime.now();

   var formattedDate;

   @override
   void initState() {
     formattedDate = DateFormat('dd/MM/yyyy').format(date);
     print(formattedDate);
     classSubjectController.getClassSubjectData(refresh: true,
         classectionid: AppManager.dashController.restoreInchargeListModel().classId == null
             ? AppManager.dashController.restoreClassInchargeListModel().classId??""
             : AppManager.dashController.restoreInchargeListModel().classId??'');
   }

   //GradeData? dropdownvalue;

   List<String> list = <String>['One', 'Two', 'Three', 'Four'];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: classtestscaffoldEy,
        backgroundColor: AppColors.screencolor,
        drawer: DrawerElement(),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: AppColors.darkblue,
          centerTitle: true,
          leading:  IconButton(
              onPressed: (){
                classtestscaffoldEy.currentState!.openDrawer();
              },
              icon: Icon(Icons.menu, color: AppColors.white,)
          ),
          title: Text('Class Test',
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 22, color: AppColors.white),),
        ),
        floatingActionButton: FloatingActionButton(
          // shape: BeveledRectangleBorder(
          //     borderRadius: BorderRadius.circular(10)
          // ),
          onPressed: () {
            // Add your onPressed code here!
          },
          backgroundColor: AppColors.textcolor,
          child: IconButton(
            onPressed: (){
              classSubjectController.getClassSubjectData(refresh: true,
                  classectionid: AppManager.dashController.restoreInchargeListModel().classId == null
                      ? AppManager.dashController.restoreClassInchargeListModel().classId??""
                      : AppManager.dashController.restoreInchargeListModel().classId??'');
              showMyDialog(context);
              //Get.to(()=>CreateTestScreen());
            },
            icon: Icon(Icons.add,
            size: 30,
            color: AppColors.white,),
          ),
        ),
        body: GetBuilder<ClassTestController>(
          init: Get.put(ClassTestController()),
          global: true,
          builder: (classtestController){
            return classtestController.classtestresData.value.data == null
                ? const Center(child: CircularProgressIndicator())
                : SmartRefresher(
              physics:  BouncingScrollPhysics(),
              controller: refreshController,
              onRefresh: () => onRefresh(),
              onLoading: () => onLoading(),
                  child: SingleChildScrollView(
                      child: Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  height: 40,
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
                                      SizedBox(width: 20,),
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
                                  height: 40,
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
                            SizedBox(height: Get.height*0.023,),
                            Padding(
                              padding:  EdgeInsets.only(left: Get.width*0.04, right: Get.width*0.04),
                              child: ListView.separated(
                                shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  separatorBuilder: (BuildContext context, int index) => SizedBox(height: Get.height*0.025,),
                                  itemCount: classtestController.classtestresData.value.data!.length,
                                  itemBuilder: (BuildContext context, int index) {
                                    return  Container(
                                        height: Get.height*0.28,
                                        width: Get.width*0.8,
                                        padding: EdgeInsets.only(left: Get.width*0.05,top: Get.height*0.023, ),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          //border: Border.all(color: AppColors.darkblue),
                                            //color: colorList[index % colorList.length],
                                            borderRadius: BorderRadius.circular(15),
                                          boxShadow: [
                                            BoxShadow(
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
                                                  //SizedBox(width: Get.width*0.023,),
                                                  SizedBox(
                                                    width: Get.width*0.61,
                                                    child: Text('${classtestController.classtestresData.value.data?[index].name}',
                                                    overflow: TextOverflow.ellipsis,
                                                    maxLines: 1,
                                                    style: TextStyle(fontSize: Get.width * 0.04, fontWeight: FontWeight.w700, color: AppColors.lightbluecolor),),
                                                  ),
                                                  Text('${classtestController.classtestresData.value.data?[index].date}',
                                                    style: TextStyle(fontSize: Get.width * 0.035, fontWeight: FontWeight.w500, color: AppColors.darkblue),),
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
                                                              Text('${classtestController.classtestresData.value.data?[index].subjectName??""}',
                                                                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: AppColors.textcolor),),
                                                              SizedBox(height: Get.height*0.007,),
                                                              Text('${classtestController.classtestresData.value.data?[index].classSection}',
                                                                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: AppColors.darkblue),),

                                                            ],
                                                          ),
                                                      ],
                                                      ),
                                                      GestureDetector(
                                                        onTap: (){
                                                          showDetailDialog(
                                                            context,
                                                            classtestid: classtestController.classtestresData.value.data?[index].recordId,
                                                            maxmarks:classtestController.classtestresData.value.data?[index].maxMarks,
                                                            subject:classtestController.classtestresData.value.data?[index].subjectName,
                                                            name: classtestController.classtestresData.value.data?[index].name,
                                                            classsection:  classtestController.classtestresData.value.data?[index].classSection,
                                                            date:  classtestController.classtestresData.value.data?[index].date,
                                                          );
                                                          // Get.to(()=> DeatailScreen(
                                                          //   name: classtestController.classtestresData.value.data?[index].name,
                                                          //   subject: classtestController.classtestresData.value.data?[index].subjectName,
                                                          //   classsection: classtestController.classtestresData.value.data?[index].classSection,
                                                          //   maxmarks: classtestController.classtestresData.value.data?[index].maxMarks,
                                                          //   date: classtestController.classtestresData.value.data?[index].date,
                                                          // ));
                                                        },
                                                        child: Container(
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
                                                  Text('Max. Marks: ${classtestController.classtestresData.value.data?[index].maxMarks}',
                                                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: AppColors.textcolor),),
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
                                                      classtestController.publishclassTest(refresh: true, classtestid: classtestController.classtestresData.value.data?[index].recordId);
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
                                                          Text(classtestController.classtestresData.value.data?[index].isPublish == "True"?"Published":'Publish',
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
                                                      Loader.show(context,
                                                          progressIndicator: const CircularProgressIndicator());
                                                      if(!classTestResultController.isBlock.value){
                                                        classTestResultController.getClassTestResultData(refresh: true,
                                                            classtestid: classtestController.classtestresData.value.data?[index].recordId)
                                                            .whenComplete(() => Navigator.push(
                                                          context,
                                                          MaterialPageRoute(builder: (context) => ClassTestResultScreen(
                                                            classtestid: classtestController.classtestresData.value.data?[index].recordId,
                                                            maxmarks:classtestController.classtestresData.value.data?[index].maxMarks,
                                                            subject:classtestController.classtestresData.value.data?[index].subjectName,
                                                            name: classtestController.classtestresData.value.data?[index].name,
                                                          )),
                                                        )
                                                        );
                                                      }
                                                      Future.delayed(const Duration(seconds: 3), () {
                                                        Loader.hide();
                                                      });

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
                                          ],
                                        )
                                    );
                                  }),
                            ),
                          ],
                        ),
                      ),
                  ),
                );
          }
        ),
      ),
    );
  }

   showMyDialog(BuildContext context) {
     ClassSubjectData? dropdownvalue;
     String dropdownValue = list.first;
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
                     height: height,
                     width: width,
                     padding: EdgeInsets.only(right: Get.width*0.05, left: Get.width*0.05),
                     child: Column(
                       children: [
                         SizedBox(height: 19,),
                         Text("Create Test",
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
                                 SizedBox(width: 9,),
                                 Image.asset("assets/images/user-group1.png"),
                                 SizedBox(width: 15,),
                                 Text('Class Sec.- ${AppManager.dashController.restoreInchargeListModel().classSection == null?
                                 AppManager.dashController.restoreClassInchargeListModel().classSection??''
                                     : AppManager.dashController.restoreInchargeListModel().classSection??""}',
                                   style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16, color: AppColors.textcolor),),
                               ],
                             )
                         ),
                         SizedBox(
                           height: Get.height * 0.02,
                         ),
                         AssignmentTextField(
                           prefix: Image.asset("assets/images/award.png"),
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
                                     border: Border.all(color: AppColors.darkblue),
                                     borderRadius: BorderRadius.circular(6.0),
                                   ),
                                   child:
                   // DropdownButton<String>(
                   //                   value: dropdownValue,
                   //                   icon: const Icon(Icons.arrow_downward),
                   //                   elevation: 16,
                   //                   style: const TextStyle(color: Colors.deepPurple),
                   //                   underline: DropdownButtonHideUnderline(child: Container()),
                   //                   onChanged: (String? value) {
                   //                     // This is called when the user selects an item.
                   //                     setState(() {
                   //                       dropdownValue = value!;
                   //                     });
                   //                   },
                   //                   items: list.map<DropdownMenuItem<String>>((String value) {
                   //                     return DropdownMenuItem<String>(
                   //                       value: value,
                   //                       child: Text(value),
                   //                     );
                   //                   }).toList(),
                   //                 )
                                   DropdownButton<ClassSubjectData>(
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
                                         value: item,
                                         child:  Row(
                                           children: [
                                             Image.asset("assets/images/bookmark-alt1.png"),
                                             SizedBox(width: 15,),
                                             SizedBox(
                                                 width: Get.width*0.55,
                                                 child: Text(item.subject??"Please Select Subject",
                                                   style: TextStyle(color: AppColors.textcolor,fontSize: 16, fontWeight: FontWeight.w600),)),
                                           ],
                                         ),
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
                                     // value: dropdownvalue != null ?
                                     // classSubjectController.classsuubjectresData.value.data?.first:dropdownvalue
                                     value: dropdownvalue??classSubjectController.classsuubjectresData.value.data?.first,
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
                                   SizedBox(width: 9,),
                                   Image.asset("assets/images/bookmark-alt1.png"),
                                   SizedBox(width: 15,),
                                   Text("${AppManager.dashController.restoreInchargeListModel().subjectName}",
                                     style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16,color: AppColors.textcolor),),
                                 ],
                               )
                           ),
                         },
                         SizedBox(
                           height: Get.height * 0.028,
                         ),
                         Container(
                             height: Get.height*0.07,
                             width: Get.width*0.8,
                             decoration: BoxDecoration(
                                 border: Border.all(color: AppColors.darkblue),
                                 borderRadius: BorderRadius.circular(6)
                             ),
                             child: TextFormField(
                                 textAlign: TextAlign.start,
                                 controller: classTestController.dateController,
                                 style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700,
                                     color: AppColors.textcolor), //editing controller of this TextField
                                 decoration:  InputDecoration(
                                   hintText: "Please select date",
                                   //formattedDate,
                                   prefixIcon: Image.asset("assets/images/calendar.png"),
                                   hintStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w700,
                                       color: AppColors.textcolor),
                                   contentPadding: EdgeInsets.only(top: Get.height*0.02, left: Get.width*0.038),
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
                           prefix: Image.asset("assets/images/trending-up.png"),
                           hintText: "Maximum Grading",
                           controller: classTestController.maxgradeController,
                           // validator: validateEmail,
                         ),

                         SizedBox(
                           height: Get.height * 0.15,
                         ),
                         AppButton(
                             buttonName: "Create Test",
                             onTap: (){
                               Loader.show(context,
                                   progressIndicator: const CircularProgressIndicator());
                               classTestController.createclassTest(refresh: true,
                                   classsectionid: AppManager.dashController.restoreInchargeListModel().classSectionId == null?
                                   AppManager.dashController.restoreClassInchargeListModel().classSectionId??''
                                       : AppManager.dashController.restoreInchargeListModel().classSectionId??"",
                                   classsubjectid: AppManager.dashController.restoreInchargeListModel().classSubjectId??"",
                                  subj:classSubjectController.classsuubjectresData.value.data?.first.classSubjectId
                               );
                               Future.delayed(const Duration(seconds: 3), () {
                                 Loader.hide();
                                 //Navigator.pop(context);
                                 print("Loader is being shown after hide ${Loader.isShown}");
                               });
                               classTestController.getclassTestData(refresh: true);
                               Navigator.pop(context);

                             },
                             isIconShow: false,
                             height: Get.height*0.071,
                             fontSize: 18,
                             fontweight: FontWeight.w600,
                             width: Get.width* 0.8,
                             backgroundColor: AppColors.darkblue,
                             //iconColor: AppColors.bluishBlack,
                             textColor: const Color(0xffFFFFFF)),
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
                        padding:  EdgeInsets.only(left: Get.width*0.05, right: Get.width*0.05),
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
                                  width: Get.width*0.45,
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
                                  width: Get.width*0.45,
                                  child: Text("Subject  ",
                                    style: TextStyle(fontSize: 19, fontWeight: FontWeight.w800, color: AppColors.black),),
                                ),
                                Text(": ${subject ?? ""}",
                                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500, color: AppColors.darkblue),)
                              ],
                            ),

                            date == null?SizedBox.shrink():
                            Column(
                              children: [
                                SizedBox(height: Get.height*0.015,),
                                Row(
                                  children: [
                                    SizedBox(
                                      width: Get.width*0.45,
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
                                Row(
                                  children: [
                                    SizedBox(
                                      width: Get.width*0.45,
                                      child: Text("Max. Marks  ",
                                        style: TextStyle(fontSize: 19, fontWeight: FontWeight.w800, color: AppColors.black),),
                                    ),
                                    Text(": ${maxmarks ?? ""}",
                                      style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500, color: AppColors.darkblue),)
                                  ],
                                ),
                              ],
                            ),

                            SizedBox(
                              height: Get.height * 0.07,
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
