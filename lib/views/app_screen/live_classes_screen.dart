import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:staffapp/models/exam_schedule_response_model.dart';
import 'package:staffapp/utils/app_button.dart';
import 'package:staffapp/utils/apptext_field.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../controller/class_subject_controller.dart';
import '../../controller/live_classes_controller.dart';
import '../../helpers/app_manager.dart';
import '../../helpers/helper_extension.dart';
import '../../models/class_subject_response_model.dart';
import '../../utils/appcolors_theme.dart';
import '../../utils/drawer_widget.dart';
import 'create_live_class_screen.dart';

class LiveClassesScreen extends StatefulWidget {
   LiveClassesScreen({Key? key}) : super(key: key);

  @override
  State<LiveClassesScreen> createState() => _LiveClassesScreenState();
}

class _LiveClassesScreenState extends State<LiveClassesScreen> {

  LiveClassController liveClassController = Get.put(LiveClassController());
  RefreshController refreshController = RefreshController(initialRefresh: false);

  void onLoading() async {
    refreshController.loadComplete();
  }

  void onRefresh() async {
    try {
      await liveClassController.getLiveClassData(refresh: true);
      refreshController.refreshCompleted();
    } catch (e) {
      refreshController.refreshCompleted();
    }
  }
  // void onRefresh() async {
  //   await liveClassController.getLiveClassData(refresh: true);
  //   refreshController.refreshCompleted();
  // }


  final GlobalKey<ScaffoldState> liveclasscaffoldEy = GlobalKey<ScaffoldState>();

   final liveclassimageList = [
     "assets/images/live_card1.png",
     "assets/images/live_card2.png",
     "assets/images/live_card3.png",
   ];
  DateTime date = DateTime.now();

  var formattedDate;

  TimeOfDay times = TimeOfDay.now();
  // var fomattedtime;
  var selectedTime;

   ClassSubjectController classSubjectController = Get.put(ClassSubjectController());
   @override
  void initState() {
    // TODO: implement initState
    super.initState();
    formattedDate = DateFormat('dd/MM/yyyy').format(date);
    selectedTime = TimeOfDay.now();
    // selectedTime = TimeOfDay.now();
    // print(selectedTime);
    print(formattedDate);
    liveClassController.getLiveClassData(refresh: true);
    classSubjectController.getClassSubjectData(refresh: true,
        classectionid: AppManager.dashController.restoreInchargeListModel().classId == null
            ? AppManager.dashController.restoreClassInchargeListModel().classId??""
            : AppManager.dashController.restoreInchargeListModel().classId??'');
  }

  @override
  Widget build(BuildContext context) {
    // var df = DateFormat("h:mm a");
    // var dt = df.parse(timeRecord!.format(context));
    // print(DateFormat('HH:mm').format(dt));
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.screencolor,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: AppColors.darkblue,
          centerTitle: true,
          leading:  IconButton(
              onPressed: (){
                liveclasscaffoldEy.currentState!.openDrawer();
              },
              icon: Icon(Icons.menu, color: AppColors.white,)
          ),
          title: Text('Live Classes',
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 22, color: AppColors.white),),
        ),
        key: liveclasscaffoldEy,
        drawer: DrawerElement(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
          },
          backgroundColor: AppColors.darkblue,
          child: IconButton(
            onPressed: ()async{
                if(!classSubjectController.isBlock.value){
                  await classSubjectController.getClassSubjectData(refresh: true,
                      classectionid: AppManager.dashController.restoreInchargeListModel().classId == null
                          ? AppManager.dashController.restoreClassInchargeListModel().classId??""
                          : AppManager.dashController.restoreInchargeListModel().classId??'')
                      .then((value) => showMyDialog(context));
                }
            },
            icon: Icon(Icons.add,
            size: 30,
                color: AppColors.white,),
          ),
        ),
        body: GetBuilder<LiveClassController>(
          init: Get.put(LiveClassController()),
          //global: false,
         builder: (liveclassController){
           return liveclassController.liveclasData.value.message == null
               ? const Center(child: CircularProgressIndicator())
               :SmartRefresher(
             physics:  BouncingScrollPhysics(),
             controller: refreshController,
             onRefresh: () => onRefresh(),
             onLoading: () => onLoading(),
                 child: SingleChildScrollView(
                     child: Padding(
                       padding:  EdgeInsets.only(left: Get.width*0.05),
                       child: Column(
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: [
                           SizedBox(height: Get.height*0.023,),

                           if(liveClassController.liveclasData.value.currentClasses?.length != null && liveClassController.liveclasData.value.currentClasses!.isNotEmpty)...{
                             Column(
                               crossAxisAlignment: CrossAxisAlignment.start,
                               children: [
                                 Text("Live Classes",
                                   style: TextStyle(color: AppColors.textcolor, fontSize: 15, fontWeight: FontWeight.w700),),
                                 SizedBox(height: Get.height*0.016,),
                                 SizedBox(
                                   height: Get.height*0.18,
                                   width: Get.width*0.999,
                                   child: ListView.separated(
                                     //shrinkWrap: true,
                                       scrollDirection: Axis.horizontal,
                                       // physics: NeverScrollableScrollPhysics(),
                                       separatorBuilder: (BuildContext context, int index) => SizedBox(width: Get.width*0.02,),
                                       itemCount: liveclassController.liveclasData.value.currentClasses!.length,
                                       itemBuilder: (BuildContext context, int index) {
                                         return  Container(
                                           height: Get.height * 0.2,
                                           width: Get.width * 0.8,
                                           padding:  EdgeInsets.only(left: Get.width*0.05, top: Get.height*0.02, right: Get.width*0.03),
                                           decoration:  BoxDecoration(
                                               gradient: LinearGradient(
                                                   begin: Alignment.topLeft,
                                                   end: Alignment.topRight,
                                                   stops: [
                                                     0.1,
                                                     0.6
                                                   ], colors: [
                                                 Color(0xff139B83),
                                                 Color(0xff048293),
                                               ]),
                                               borderRadius: BorderRadius.circular(15)
                                             // image: DecorationImage(
                                             //     image: AssetImage("assets/images/liveclassescard.png"), fit: BoxFit.fill)
                                           ),
                                           child: Column(
                                             crossAxisAlignment: CrossAxisAlignment.start,
                                             // mainAxisAlignment: MainAxisAlignment.center,
                                             children: [
                                               SizedBox(
                                                 height: 4,
                                               ),
                                               SizedBox(
                                                 width: Get.width*0.99,
                                                 child: Text('${liveclassController.liveclasData.value.currentClasses?[index].heading??""}',
                                                   overflow: TextOverflow.ellipsis,
                                                   style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600,
                                                       color: AppColors.white),),
                                               ),
                                               SizedBox(
                                                 height: 4,
                                               ),
                                               Row(
                                                 //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                 children: [
                                                   SizedBox(
                                                     width: Get.width*0.6,
                                                     child: Text('${liveclassController.liveclasData.value.currentClasses?[index].subjectName??""}',
                                                       overflow: TextOverflow.ellipsis,
                                                       style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600,
                                                           color: AppColors.white),),
                                                   ),
                                                   // Text('30/06/2023',
                                                   //   style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500,
                                                   //       color: AppColors.white),)
                                                 ],
                                               ),
                                               Padding(
                                                 padding: EdgeInsets.only(left: Get.width*0.01),
                                                 child: Column(
                                                   crossAxisAlignment: CrossAxisAlignment.start,
                                                   children: [
                                                     SizedBox(
                                                       height: Get.height * 0.01,
                                                     ),
                                                     Row(
                                                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                       children: [
                                                         Column(
                                                           crossAxisAlignment: CrossAxisAlignment.start,
                                                           children: [
                                                             // Text("I-A",
                                                             //   //'${liveclassdata?[index].classSection??""}',
                                                             //   style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),),
                                                             // SizedBox(
                                                             //   height: Get.height * 0.001,
                                                             // ),
                                                             Row(
                                                               children: [
                                                                 Image.asset("assets/images/clock.png"),
                                                                 SizedBox(width: 5,),
                                                                 Text('${liveclassController.liveclasData.value.currentClasses?[index].startTime??""}',
                                                                   style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500,
                                                                       color: AppColors.white),),
                                                               ],
                                                             ),
                                                           ],
                                                         ),
                                                       ],
                                                     ),
                                                     SizedBox(
                                                       height: Get.height * 0.001,
                                                     ),
                                                     Row(
                                                       mainAxisAlignment: MainAxisAlignment.end,
                                                       children: [
                                                         // Text('Class - ${liveclassController.liveclasData.value.currentClasses?[index].subjectName??""}',
                                                         //   style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500,
                                                         //       color: Colors.white),),
                                                         InkWell(
                                                           onTap: (){
                                                             UtilityHelper.redirectToURL(
                                                                 liveclassController.liveclasData.value.currentClasses?[index].link??"");
                                                           },
                                                           child: Container(
                                                             height: Get.height*0.05,
                                                             width: Get.width*0.22,
                                                             decoration: BoxDecoration(
                                                                 color: AppColors.lightgreencolor,
                                                                 //border: Border.all(color: AppColors.apppurplecolor, width: 2),
                                                                 borderRadius: BorderRadius.circular(10)
                                                             ),
                                                             child: Center(child: Text('Join',
                                                               style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15, color: AppColors.darkblue),)),
                                                           ),
                                                         ),
                                                       ],
                                                     ),
                                                   ],
                                                 ),
                                               ),

                                             ],
                                           ),
                                         );
                                       }),
                                 ),
                                 SizedBox(height: Get.height*0.023,),
                               ],
                             ),
                           }else...{
                             SizedBox.shrink()
                           },


                           if(liveClassController.liveclasData.value.upcomingClasses?.length != null && liveClassController.liveclasData.value.upcomingClasses!.isNotEmpty)...{
                             Column(
                               crossAxisAlignment: CrossAxisAlignment.start,
                               children: [
                                 Text("Upcoming Classes ",
                                   style: TextStyle(color: AppColors.textcolor, fontSize: 15, fontWeight: FontWeight.w700),),
                                 SizedBox(height: Get.height*0.016,),
                                 SizedBox(
                                   height: Get.height*0.19,
                                   width: Get.width*0.999,
                                   child: ListView.separated(
                                     //shrinkWrap: true,
                                       scrollDirection: Axis.horizontal,
                                       // physics: NeverScrollableScrollPhysics(),
                                       separatorBuilder: (BuildContext context, int index) => SizedBox(width: Get.width*0.02,),
                                       itemCount: liveclassController.liveclasData.value.upcomingClasses!.length,
                                       itemBuilder: (BuildContext context, int index) {
                                         return  Container(
                                           height: Get.height * 0.18,
                                           width: Get.width * 0.8,
                                           padding:  EdgeInsets.only(left: Get.width*0.05, top: Get.height*0.02, right: Get.width*0.03),
                                           decoration:  BoxDecoration(
                                             // gradient: LinearGradient(
                                             //     begin: Alignment.topLeft,
                                             //     end: Alignment.topRight,
                                             //     stops: [
                                             //       0.1,
                                             //       0.6
                                             //     ], colors: [
                                             //   Color(0xff139B83),
                                             //   Color(0xff048293),
                                             // ]),
                                               color: Color(0xffCDE6E9),
                                               borderRadius: BorderRadius.circular(15)
                                             // image: DecorationImage(
                                             //     image: AssetImage("assets/images/liveclassescard.png"), fit: BoxFit.fill)
                                           ),
                                           child: Column(
                                             crossAxisAlignment: CrossAxisAlignment.start,
                                             // mainAxisAlignment: MainAxisAlignment.center,
                                             children: [
                                               SizedBox(
                                                 height: 4,
                                               ),
                                               SizedBox(
                                                 width: Get.width*0.99,
                                                 child: Text('${liveclassController.liveclasData.value.upcomingClasses?[index].heading??""}',
                                                   overflow: TextOverflow.ellipsis,
                                                   style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600,
                                                       color:  AppColors.darkblue),),
                                               ),
                                               SizedBox(
                                                 height: 4,
                                               ),
                                               Row(
                                                 // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                 children: [
                                                   SizedBox(
                                                     width: Get.width*0.6,
                                                     child: Text('${liveclassController.liveclasData.value.upcomingClasses?[index].subjectName??""}',
                                                       overflow: TextOverflow.ellipsis,
                                                       style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600,
                                                           color:  AppColors.darkblue),),
                                                   ),
                                                   // Text('30/06/2023',
                                                   //   style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500,
                                                   //       color:  AppColors.darkblue),)
                                                 ],
                                               ),
                                               Padding(
                                                 padding: EdgeInsets.only(left: Get.width*0.01),
                                                 child: Column(
                                                   crossAxisAlignment: CrossAxisAlignment.start,
                                                   children: [
                                                     SizedBox(
                                                       height: Get.height * 0.01,
                                                     ),
                                                     Row(
                                                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                       children: [
                                                         Column(
                                                           crossAxisAlignment: CrossAxisAlignment.start,
                                                           children: [
                                                             // Text("I-A",
                                                             //   //'${liveclassdata?[index].classSection??""}',
                                                             //   style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),),
                                                             // SizedBox(
                                                             //   height: Get.height * 0.001,
                                                             // ),
                                                             Row(
                                                               children: [
                                                                 Image.asset("assets/images/clock.png",
                                                                   color:  AppColors.darkblue,),
                                                                 SizedBox(width: 5,),
                                                                 Text('${liveclassController.liveclasData.value.upcomingClasses?[index].startTime??""}',
                                                                   style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500,
                                                                       color:  AppColors.darkblue),),
                                                               ],
                                                             ),
                                                           ],
                                                         ),
                                                       ],
                                                     ),
                                                     SizedBox(
                                                       height: Get.height * 0.001,
                                                     ),
                                                     Row(
                                                       mainAxisAlignment: MainAxisAlignment.end,
                                                       children: [
                                                         // Text('Class - ${liveclassController.liveclasData.value.currentClasses?[index].subjectName??""}',
                                                         //   style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500,
                                                         //       color:  AppColors.darkblue),),
                                                         InkWell(
                                                           onTap: (){
                                                             // UtilityHelper.redirectToURL(
                                                             //     liveclassdata![index].link);
                                                           },
                                                           child: Container(
                                                             height: Get.height*0.07,
                                                             width: Get.width*0.12,
                                                             decoration: BoxDecoration(
                                                                 color: AppColors.lightgreencolor,
                                                                 border: Border.all(color: Color(0xff048293), width: 2),
                                                                 borderRadius: BorderRadius.circular(10)
                                                             ),
                                                             child: Center(child: Image.asset("assets/images/upcomingclassicon.png",color: AppColors.textcolor,
                                                               scale: 0.9,)),
                                                           ),
                                                         ),
                                                       ],
                                                     ),
                                                   ],
                                                 ),
                                               ),

                                             ],
                                           ),
                                         );
                                       }),
                                 ),
                               ],
                             ),
                           }else...{
                             SizedBox.shrink()
                           },


                           if(liveClassController.liveclasData.value.doneClasses?.length != null && liveClassController.liveclasData.value.doneClasses!.isNotEmpty)...{
                              Column(
                               crossAxisAlignment: CrossAxisAlignment.start,
                               children: [
                                 SizedBox(height: Get.height*0.023,),
                                 Text("Done Classes",
                                   style: TextStyle(color: AppColors.textcolor, fontSize: 15, fontWeight: FontWeight.w700),),
                                 SizedBox(height: Get.height*0.016,),
                                 SizedBox(
                                   height: Get.height*0.2,
                                   width: Get.width*0.999,
                                   child: ListView.separated(
                                     //shrinkWrap: true,
                                       scrollDirection: Axis.horizontal,
                                       // physics: NeverScrollableScrollPhysics(),
                                       separatorBuilder: (BuildContext context, int index) => SizedBox(width: Get.width*0.02,),
                                       itemCount: liveclassController.liveclasData.value.doneClasses!.length,
                                       itemBuilder: (BuildContext context, int index) {
                                         return Container(
                                           height: Get.height * 0.18,
                                           width: Get.width * 0.8,
                                           padding:  EdgeInsets.only(left: Get.width*0.05, top: Get.height*0.02, right: Get.width*0.03),
                                           decoration:  BoxDecoration(
                                               color: Color(0xff048293),
                                               // gradient: LinearGradient(
                                               //     begin: Alignment.topLeft,
                                               //     end: Alignment.topRight,
                                               //     stops: [
                                               //       0.1,
                                               //       0.6
                                               //     ], colors: [
                                               //   Color(0xff139B83),
                                               //   Color(0xff048293),
                                               // ]),
                                               borderRadius: BorderRadius.circular(15)
                                             // image: DecorationImage(
                                             //     image: AssetImage("assets/images/liveclassescard.png"), fit: BoxFit.fill)
                                           ),
                                           child: Column(
                                             crossAxisAlignment: CrossAxisAlignment.start,
                                             // mainAxisAlignment: MainAxisAlignment.center,
                                             children: [
                                               SizedBox(
                                                 height: 4,
                                               ),
                                               SizedBox(
                                                 width: Get.width*0.7,
                                                 child: Text('${liveclassController.liveclasData.value.doneClasses?[index].heading??""}',
                                                   overflow: TextOverflow.ellipsis,
                                                   style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600,
                                                       color: AppColors.white),),
                                               ),
                                               SizedBox(
                                                 height: 4,
                                               ),
                                               Row(
                                                 // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                 children: [
                                                   SizedBox(
                                                     width: Get.width*0.7,
                                                     child: Text('${liveclassController.liveclasData.value.doneClasses?[index].subjectName??""}',
                                                       overflow: TextOverflow.ellipsis,
                                                       style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600,
                                                           color: AppColors.white),),
                                                   ),
                                                   // Text('30/06/2023',
                                                   //   style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500,
                                                   //       color: AppColors.white),)
                                                 ],
                                               ),
                                               Padding(
                                                 padding: EdgeInsets.only(left: Get.width*0.01),
                                                 child: Column(
                                                   crossAxisAlignment: CrossAxisAlignment.start,
                                                   children: [
                                                     SizedBox(
                                                       height: Get.height * 0.01,
                                                     ),
                                                     Row(
                                                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                       children: [
                                                         Column(
                                                           crossAxisAlignment: CrossAxisAlignment.start,
                                                           children: [
                                                             // Text("I-A",
                                                             //   //'${liveclassdata?[index].classSection??""}',
                                                             //   style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),),
                                                             // SizedBox(
                                                             //   height: Get.height * 0.001,
                                                             // ),
                                                             Row(
                                                               children: [
                                                                 Image.asset("assets/images/clock.png"),
                                                                 SizedBox(width: 5,),
                                                                 Text('${liveclassController.liveclasData.value.doneClasses?[index].startTime??""}',
                                                                   style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500,
                                                                       color: AppColors.white),),
                                                               ],
                                                             ),
                                                           ],
                                                         ),
                                                       ],
                                                     ),
                                                     SizedBox(
                                                       height: Get.height * 0.001,
                                                     ),
                                                     Row(
                                                       mainAxisAlignment: MainAxisAlignment.end,
                                                       children: [
                                                         // Text('Class - ${liveclassController.liveclasData.value.currentClasses?[index].subjectName??""}',
                                                         //   style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500,
                                                         //       color: Colors.white),),
                                                         InkWell(
                                                           onTap: (){
                                                             // UtilityHelper.redirectToURL(
                                                             //     liveclassdata![index].link);
                                                           },
                                                           child: Container(
                                                               height: Get.height*0.08,
                                                               width: Get.width*0.22,
                                                               // decoration: BoxDecoration(
                                                               //     color: AppColors.lightgreencolor,
                                                               //    // border: Border.all(color: Color(0xff048293), width: ),
                                                               //     borderRadius: BorderRadius.circular(10)
                                                               // ),
                                                               child: Column(
                                                                 children: [
                                                                   Image.asset("assets/images/checkboxicon.png"),
                                                                   SizedBox(height: 10,),
                                                                   Text("Done",
                                                                     style: TextStyle(color: Color(0xffF3FEFF),fontWeight: FontWeight.w700, fontSize: 15),)
                                                                 ],
                                                               )
                                                             // Center(child: Text('Join',
                                                             //   style: TextStyle(fontWeight: FontWeight.w600,
                                                             //       fontSize: 15, color: AppColors.darkblue),)),
                                                           ),
                                                         ),
                                                       ],
                                                     ),
                                                   ],
                                                 ),
                                               ),

                                             ],
                                           ),
                                         );
                                       }),
                                 ),
                               ],
                             )
                           }else...{
                               SizedBox.shrink()
                              }


                           // Column(
                           //   crossAxisAlignment: CrossAxisAlignment.start,
                           //   children: [
                           //     // Row(
                           //     //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                           //     //   children: [
                           //     //     Container(
                           //     //       width: Get.width*0.25,
                           //     //       height: Get.height*0.065,
                           //     //       padding: EdgeInsets.only(left: Get.width*0.01),
                           //     //       decoration: BoxDecoration(
                           //     //         //color: AppColors.apppurplecolor,
                           //     //           border: Border.all(color: AppColors.apppurplecolor),
                           //     //           borderRadius: BorderRadius.circular(20)
                           //     //       ),
                           //     //       child: Center(
                           //     //         child: Text('Xth',
                           //     //           style: TextStyle(fontWeight: FontWeight.w700, fontSize: 17),),),
                           //     //     ),
                           //     //     Container(
                           //     //       width: Get.width*0.28,
                           //     //       height: Get.height*0.065,
                           //     //       padding: EdgeInsets.only(left: Get.width*0.01),
                           //     //       decoration: BoxDecoration(
                           //     //         //color: AppColors.apppurplecolor,
                           //     //           border: Border.all(color: AppColors.apppurplecolor),
                           //     //           borderRadius: BorderRadius.circular(20)
                           //     //       ),
                           //     //       child: Center(
                           //     //         child: Text('30/06/2022',
                           //     //           style: TextStyle(fontWeight: FontWeight.w700, fontSize: 17),),),
                           //     //     ),
                           //     //     Container(
                           //     //       width: Get.width*0.26,
                           //     //       height: Get.height*0.065,
                           //     //       padding: EdgeInsets.only(left: Get.width*0.01),
                           //     //       decoration: BoxDecoration(
                           //     //         color: AppColors.apppurplecolor,
                           //     //           border: Border.all(color: AppColors.apppurplecolor),
                           //     //           borderRadius: BorderRadius.circular(20)
                           //     //       ),
                           //     //       child: Center(
                           //     //         child: Text('View',
                           //     //           style: TextStyle(fontWeight: FontWeight.w700, fontSize: 17,color: AppColors.white),),),
                           //     //     ),
                           //     //   ],
                           //     // ),
                           //
                           //
                           //   ],
                           // ),
                           // Container(
                           //   height: Get.height * 0.34,
                           //   decoration: const BoxDecoration(
                           //     color: AppColors.backgroundpurple,
                           //   ),
                           //   child: Padding(
                           //     padding: const EdgeInsets.only(top: 10),
                           //     child: Row(
                           //       crossAxisAlignment: CrossAxisAlignment.start,
                           //       children: [
                           //         SizedBox(width: Get.width*0.01,),
                           //         IconButton(
                           //             onPressed: (){
                           //               liveclasscaffoldEy.currentState!.openDrawer();
                           //             },
                           //             icon: Icon(Icons.menu, color: AppColors.white,)
                           //         ),
                           //         const Padding(
                           //           padding: EdgeInsets.only(top: 10),
                           //           child: Text(
                           //             'Live Classes',
                           //             style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: AppColors.white),
                           //           ),
                           //         ),
                           //       ],
                           //     ),
                           //   ),
                           // ),
                           // Container(
                           //   // alignment: Alignment.center,
                           //   // width: Get.width * 0.99,
                           //   //height: Get.height * 0.9,
                           //   //padding: EdgeInsets.only(left: Get.width*0.03, right: Get.width*0.03, top: Get.height*0.03),
                           //   // decoration: BoxDecoration(
                           //   //   color: AppColors.white,
                           //   //   borderRadius: BorderRadius.circular(10),
                           //   //   boxShadow: const [
                           //   //     BoxShadow(
                           //   //       color: Colors.grey,
                           //   //       offset: Offset(
                           //   //         1.0,
                           //   //         1.0,
                           //   //       ),
                           //   //       blurRadius: 3.0,
                           //   //       spreadRadius: 1.0,
                           //   //     ), //BoxShadow
                           //   //     BoxShadow(
                           //   //       color: Colors.white,
                           //   //       offset: Offset(0.0, 0.0),
                           //   //       blurRadius: 0.0,
                           //   //       spreadRadius: 0.0,
                           //   //     ), //BoxShadow
                           //   //   ],
                           //   //   // color: Colors.pink.shade200,
                           //   // ),
                           //   child:
                           // ),
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
                        Text("Create Live Class",
                          style: TextStyle(
                              color: AppColors.textcolor,fontWeight: FontWeight.w700,
                              fontSize: 20
                          ),),
                        SizedBox(
                          height: Get.height * 0.02,
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
                        // SizedBox(
                        //   height: Get.height * 0.03,
                        // ),
                        AssignmentTextField(
                          prefix: Image.asset("assets/images/pencil-alt.png"),
                          hintText: "Heading",
                          controller: liveClassController.headdingController,
                          // validator: validateEmail,
                        ),
                        SizedBox(
                          height: Get.height * 0.02,
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
                        // SizedBox(
                        //   height: Get.height * 0.02,
                        // ),
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
                                            SizedBox(width: 15,),
                                            SizedBox(
                                                width: Get.width*0.55,
                                                child: Text(item.subject??'Please Select Subject',
                                                  style: TextStyle(color: AppColors.textcolor,fontSize: 16, fontWeight: FontWeight.w600),)),
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
                                        liveClassController.subectidd.value = newVal.classSubjectId??"";
                                      });
                                    },
                                    underline: DropdownButtonHideUnderline(child: Container()),
                                    value:
                                    //dropdownvalue != null ? classSubjectController.classsuubjectresData.value.data?.first : dropdownvalue,
                                     dropdownvalue??classSubjectController.classsuubjectresData.value.data?.first,
                                  ),
                                ),
                              ),
                            // Padding(
                            //   padding:  EdgeInsets.only(top: Get.height*0.02),
                            //   child: Container(
                            //     height: Get.height*0.065,
                            //     width: Get.width*0.81,
                            //     padding: EdgeInsets.only(left: Get.width*0.025),
                            //     decoration: BoxDecoration(
                            //       border: Border.all(color: AppColors.darkblue,),
                            //       borderRadius: BorderRadius.circular(6.0),
                            //     ),
                            //     child: DropdownButton<ClassSubjectData>(
                            //       items: classSubjectController.classsuubjectresData.value.data?.map((item) {
                            //         return  DropdownMenuItem<ClassSubjectData>(
                            //           child:  Row(
                            //             children: [
                            //               Image.asset("assets/images/bookmark-alt1.png"),
                            //               SizedBox(width: 15,),
                            //               SizedBox(
                            //                   width: Get.width*0.55,
                            //                   child: Text(item.subject??'Choose Subject',
                            //                     style: TextStyle(color: AppColors.textcolor,fontSize: 16, fontWeight: FontWeight.w600),)),
                            //             ],
                            //           ),
                            //           value: item,
                            //         );
                            //       }).toList(),
                            //       onChanged: ( newVal) {
                            //         setState(() {
                            //           // saveeventcon.currencyController.text = newVal.toString();
                            //           //  print(saveeventcon.currencyController.text);
                            //           dropdownvalue = newVal as ClassSubjectData;
                            //           liveClassController.subectidd.value = newVal.classSubjectId??"";
                            //         });
                            //       },
                            //       underline: DropdownButtonHideUnderline(child: Container()),
                            //       value: dropdownvalue == null?classSubjectController.classsuubjectresData.value.data?.first:dropdownvalue,
                            //     ),
                            //   ),
                            // ),
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
                            width: Get.width*0.88,
                            decoration: BoxDecoration(
                                border: Border.all(color: AppColors.darkblue),
                                borderRadius: BorderRadius.circular(6)
                            ),
                            child: Row(
                              children: [
                                SizedBox(width: 9,),
                                Image.asset("assets/images/clock1.png"),
                                SizedBox(width: 2,),
                                SizedBox(
                                  height: Get.height*0.07,
                                  width: Get.width*0.32,
                                  child: TextFormField(
                                    textAlign: TextAlign.start,
                                    controller: liveClassController.startdateController,
                                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700,
                                        color: AppColors.textcolor), //editing controller of this TextField
                                    decoration:  InputDecoration(
                                      hintText: "${formattedDate}",
                                     // prefixIcon: Image.asset("assets/images/clock1.png"),
                                      hintStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w700,
                                          color: AppColors.textcolor),
                                      contentPadding: EdgeInsets.only(top: Get.height*0.0, left: Get.width*0.038),
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
                                        liveClassController.startdateController.text = formattedDate;
                                      }else{
                                        Text('Live Class Date');
                                      }
                                        TimeOfDay? timeRecord = await showTimePicker(
                                          context: context,
                                          initialTime: times.replacing(hour: times.hourOfPeriod),
                                          builder: (BuildContext context, Widget? child) {
                                            return MediaQuery(
                                              data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
                                              child: child!,
                                            );
                                          },
                                        );
                                        if (timeRecord != null) {
                                          setState(() {
                                            var df = DateFormat("h:mm a");
                                            var dt = df.parse(timeRecord.format(context));
                                            var finaltime =  DateFormat('HH:mm a').format(dt);
                                            var selectedTime = DateFormat('HH:mm a').format(dt);

                                            print(finaltime);
                                           // liveClassController.timeController.value = finaltime;
                                            setState(() {
                                              selectedTime = finaltime;
                                              selectedTime = timeRecord.format(context);
                                            });
                                            liveClassController.timecon.text = selectedTime;
                                            print(selectedTime);
                                            // this will return 13:30 only
                                          });}
                                    },
                                  ),
                                ),
                                if(liveClassController.timecon.text != null)...{
                                  SizedBox(
                                    height: Get.height*0.07,
                                    width: Get.width*0.2,
                                    child: Padding(
                                      padding:  EdgeInsets.only(top: Get.height*0.02),
                                      child: Text("${liveClassController.timecon.text??""}",
                                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700,
                                            color: AppColors.textcolor),),
                                    ),
                                  )

                                }
                                else...{
                                  Text("Select date and time")
                                }
                              ],
                            )
                        ),
                        // AssignmentTextField(
                        //   prefix: Image.asset("assets/images/clock1.png"),
                        //   hintText: "Start Date",
                        //   controller: liveClassController.startdateController,
                        //   // validator: validateEmail,
                        // ),
                        SizedBox(
                          height: Get.height * 0.028,
                        ),
                        AssignmentTextField(
                          prefix: Image.asset("assets/images/sand.png"),
                          hintText: "Duration in minutes",
                          controller: liveClassController.durationController,
                          keyboardType: TextInputType.number,
                          // validator: validateEmail,
                        ),
                        SizedBox(
                          height: Get.height * 0.032,
                        ),
                        AssignmentTextField(
                          prefix: Image.asset("assets/images/link.png"),
                          hintText: "Paste link ",
                          controller: liveClassController.linkController,
                          // validator: validateEmail,
                        ),
                        SizedBox(
                          height: Get.height * 0.09,
                        ),

                        AppButton(
                            buttonName: "Create Live Class",
                            onTap: (){
                              Loader.show(context,
                                  progressIndicator: const CircularProgressIndicator());
                              liveClassController.addLiveClassData(refresh: true,
                                  classsectionid: AppManager.dashController.restoreInchargeListModel().classSectionId == null?
                                  AppManager.dashController.restoreClassInchargeListModel().classSectionId??''
                                      : AppManager.dashController.restoreInchargeListModel().classSectionId??"",
                                  classsubjectid: AppManager.dashController.restoreInchargeListModel().classSubjectId??"",
                                subj:classSubjectController.classsuubjectresData.value.data?.first.classSubjectId
                              );
                              Get.back();
                              liveClassController.timeController.value == null;
                              liveClassController.timeController.value.isEmpty;
                              liveClassController.timeController.value == "";
                              liveClassController.timeController.value.trim();
                              liveClassController.timeController == null;
                              selectedTime == null;
                              Future.delayed(const Duration(seconds: 3), () {
                                Loader.hide();
                                //Navigator.pop(context);
                                print("Loader is being shown after hide ${Loader.isShown}");
                              });

                            },
                            isIconShow: false,
                            height: Get.height*0.071,
                            fontSize: 18,
                            fontweight: FontWeight.w600,
                            width: Get.width* 0.8,
                            backgroundColor: AppColors.darkblue,
                            //iconColor: AppColors.bluishBlack,
                            textColor: const Color(0xffFFFFFF)),

                        // SizedBox(
                        //   height: Get.height * 0.01,
                        // ),
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
  Future<TimeOfDay?> getTime({
    required BuildContext context,
    String? title,
    TimeOfDay? initialTime,
    String? cancelText,
    String? confirmText,
  }) async {
    TimeOfDay? time = await showTimePicker(
      initialEntryMode: TimePickerEntryMode.dial,
      context: context,
      initialTime: initialTime ?? TimeOfDay.now(),
      cancelText: cancelText ?? "Cancel",
      confirmText: confirmText ?? "Save",
      helpText: title ?? "Select time",
      builder: (context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
          child: child!,
        );
      },
    );

    return time;
  }

}
