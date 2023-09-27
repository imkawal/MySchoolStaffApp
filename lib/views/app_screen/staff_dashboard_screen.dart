import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:staffapp/constants/string_constants.dart';
import 'package:staffapp/utils/appcolors_theme.dart';
import 'package:staffapp/views/app_screen/staff_profile_screen.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../controller/dashboard_controller.dart';
import '../../helpers/app_manager.dart';
import '../../helpers/helper_extension.dart';
import '../../models/staff_dashboard_response_model.dart';
import '../../utils/drawer_widget.dart';

class StaffDashboardScreen extends StatefulWidget {
   StaffDashboardScreen({Key? key}) : super(key: key);

  @override
  State<StaffDashboardScreen> createState() => _StaffDashboardScreenState();
}

class _StaffDashboardScreenState extends State<StaffDashboardScreen> {
  // final GlobalKey<ScaffoldState> dashboardscaffoldEy = GlobalKey<ScaffoldState>();
  final colorList = <Color>[
    const Color(0xff70D9A0),
    const Color(0xff718CEA),
    const Color(0xffFAA7A7),
  ];
  DashBoardController dashBoardController = Get.put(DashBoardController());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dashBoardController.getDashboarData();
  }
  final Map<String, double> dataMap = {"Present": 5, "Leave": 2, "Absent": 3};

   final List classinchargeimages = ["assets/images/classincharge1.png", "assets/images/classincharge2.png"];

   final List subjectinchargeimages = [
     "assets/images/account.png",
     "assets/images/Math.png",
   "assets/images/earth.png"];

  final List subjectboxcolor = [
    Color(0xffE0F0FF),
    Color(0xffFCF3FF),
    Color(0xffE5FFE7),];

   final subjectcolorlist = [
     AppColors.bluecolor,
     AppColors.purplecolor,
     AppColors.greencolor
   ];

   final List notigicationimages = ["assets/images/notificatiocard1.png", "assets/images/notificatiocard2.png"];

   final List upcomingLectureimages = ["assets/images/upcominlecture2.png", "assets/images/upcominlecture2.png"];



   RefreshController refreshController = RefreshController(initialRefresh: false);

   void onLoading() async {
     refreshController.loadComplete();
   }

  void onRefresh() async {
    try {
      await dashBoardController.getDashboarData();
      refreshController.refreshCompleted();
    } catch (e) {
      refreshController.refreshCompleted();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
       // key: dashboardscEy,
       // drawer:  DrawerElement(),
      body: GetBuilder<DashBoardController>(
        init: Get.put(DashBoardController()),
        global: true,
        builder: (dashBoardController){
          return dashBoardController.dashboardData.value.data == null
              ? const Center(child: CircularProgressIndicator())
              : SmartRefresher(
            physics:  BouncingScrollPhysics(),
            controller: refreshController,
            onRefresh: () => onRefresh(),
            onLoading: () => onLoading(),
            child: SingleChildScrollView(
              child: Stack(
                children: [
                  Container(
                    height: Get.height * 0.25,
                    decoration: const BoxDecoration(
                      color: AppColors.lightgreencolor,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(50.0),
                          bottomRight: Radius.circular(50.0)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              SizedBox(width: Get.width*0.04,),
                              const CircleAvatar(
                                radius: 25,
                                backgroundImage: AssetImage('assets/images/DemoSchool_logo.png'),
                              ),
                              const SizedBox(
                                width: 16,
                              ),
                               Padding(
                                padding: EdgeInsets.only(top: 10),
                                child: Text(
                                  "${dashBoardController.dashboardData.value.data?.first.schoolName??""}",
                                  style: TextStyle(fontSize: Get.width * 0.053, fontWeight: FontWeight.w800, color: AppColors.textcolor),
                                ),
                              ),
                            ],
                          ),
                          IconButton(
                              onPressed: (){
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
                                            'Are you sure \nyou want to Sign out?',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16, color: Color(0xff3F3F3F)),
                                          ),
                                          Divider(
                                            color: AppColors.textcolor,
                                            endIndent: 19,
                                            indent: 19,
                                          ),
                                          SizedBox(
                                            height: Get.height * 0.02,
                                          ),
                                          Padding(
                                            padding:  EdgeInsets.only(left: Get.width*0.03, right: Get.width*0.03),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                GestureDetector(
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
                                                GestureDetector(
                                                  onTap: () {
                                                    AppManager.authController.signOut();
                                                    Get.delete<DashBoardController>();
                                                  },
                                                  child: Container(
                                                    height: Get.height * 0.06,
                                                    width: Get.width * 0.33,
                                                    decoration: BoxDecoration(
                                                        color: AppColors.darkblue,
                                                        borderRadius: BorderRadius.circular(10)),
                                                    child: Center(
                                                      child: Text(
                                                        'Sign out',
                                                        style: TextStyle(
                                                            fontSize: 16, fontWeight: FontWeight.w600, color: AppColors.white),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
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
                              icon: Icon(Icons.logout,
                                color: AppColors.textcolor,))
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: Get.height * 0.13, left: Get.width * 0.16),
                    child: Container(
                      width: Get.width * 0.7,
                      //height: Get.height * 0.35,
                      padding: EdgeInsets.only(left: Get.width*0.06, right: Get.width*0.06),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(15),
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
                            height: Get.height * 0.015,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  Text("${dashBoardController.dashboardData.value.data?.first.staffAttendance?.first.totalPresent??"0.0"}",
                                  style: TextStyle(color: AppColors.greencolor,fontWeight: FontWeight.w800, fontSize: 22),),
                                  SizedBox(height: 4,),
                                  Text("Present",
                                      style: TextStyle(color: AppColors.textcolor,fontWeight: FontWeight.w500, fontSize: 14))
                                ],
                              ),
                              Column(
                                children: [
                                  Text("${dashBoardController.dashboardData.value.data?.first.staffAttendance?.first.totalAbsent??"0.0"}",
                                    style: TextStyle(color: AppColors.redcolor,fontWeight: FontWeight.w800, fontSize: 22),),
                                  SizedBox(height: 4,),
                                  Text("Absent",
                                      style: TextStyle(color: AppColors.textcolor,fontWeight: FontWeight.w500, fontSize: 14))
                                ],
                              ),
                              Column(
                                children: [
                                  Text("${dashBoardController.dashboardData.value.data?.first.staffAttendance?.first.totalLeaves??"0.0"}",
                                    style: TextStyle(color: AppColors.bluecolor,fontWeight: FontWeight.w800, fontSize: 22),),
                                  SizedBox(height: 4,),
                                  Text("Leave",
                                      style: TextStyle(color: AppColors.textcolor,fontWeight: FontWeight.w500, fontSize: 14))
                                ],
                              ),
                            ],
                          ),

                          SizedBox(
                            height: Get.height * 0.02,
                          ),
                          Container(
                            height: Get.height*0.057,
                            decoration: BoxDecoration(
                              color: AppColors.Mgreencolor,
                              borderRadius: BorderRadius.circular(10)
                            ),
                            child: Row(
                              children: [
                                Container(
                                    height: Get.height*0.057,
                                  width: Get.width*0.18,
                                  decoration: BoxDecoration(
                                    color:AppColors.darkblue,
                                      borderRadius: BorderRadius.circular(10)
                                  ),
                                    child: Center(
                                      child: Text("Days",
                                        style: TextStyle(color: AppColors.white,fontWeight: FontWeight.w500, fontSize: 14),),
                                    )),
                                Container(
                                    height: Get.height*0.057,
                                    width: Get.width*0.2,
                                    decoration: BoxDecoration(
                                        color:Colors.transparent,
                                        borderRadius: BorderRadius.circular(10)
                                    ),
                                    child: Center(
                                      child: Text("Week",
                                          style: TextStyle(color: AppColors.darkblue,fontWeight: FontWeight.w500, fontSize: 14),),
                                    )),
                                Container(
                                    height: Get.height*0.057,
                                    width: Get.width*0.2,
                                    decoration: BoxDecoration(
                                        color:Colors.transparent,
                                        borderRadius: BorderRadius.circular(10)
                                    ),
                                    child: Center(
                                      child: Text("Month",
                                        style: TextStyle(color: AppColors.darkblue,fontWeight: FontWeight.w500, fontSize: 14),),
                                    ))
                              ],
                            ),
                          ),

                          SizedBox(
                            height: Get.height * 0.03,
                          ),
                          // PieChart(
                          //   dataMap: {"Present": double.parse(dashBoardController.dashboardData.value.data?.first.staffAttendance?.first.totalPresent??"0.0"),
                          //     "Leave": double.parse(dashBoardController.dashboardData.value.data?.first.staffAttendance?.first.totalLeaves??"0.0"),
                          //     "Absent": double.parse(dashBoardController.dashboardData.value.data?.first.staffAttendance?.first.totalAbsent??"0.0")},
                          //   animationDuration: const Duration(milliseconds: 800),
                          //   chartLegendSpacing: 15,
                          //   chartRadius: MediaQuery.of(context).size.width / 3,
                          //   colorList: colorList,
                          //   initialAngleInDegree: 0,
                          //   chartType: ChartType.ring,
                          //   ringStrokeWidth: 15,
                          //   // centerText: "HYBRID",
                          //   legendOptions: const LegendOptions(
                          //     showLegendsInRow: true,
                          //     legendPosition: LegendPosition.bottom,
                          //     showLegends: true,
                          //     // legendShape: _BoxShape.circle,
                          //     legendTextStyle: TextStyle(
                          //       fontWeight: FontWeight.bold,
                          //     ),
                          //   ),
                          //   chartValuesOptions: const ChartValuesOptions(
                          //     showChartValueBackground: true,
                          //     showChartValues: false,
                          //     showChartValuesInPercentage: false,
                          //     showChartValuesOutside: true,
                          //     decimalPlaces: 1,
                          //   ),
                          //   // gradientList: ---To add gradient colors---
                          //   // emptyColorGradient: ---Empty Color gradient---
                          // ),
                        ],
                      ),
                    ),
                  ),
                  // SizedBox(
                  //   height: Get.height * 0.04,
                  // ),
                  Padding(
                    padding: EdgeInsets.only(top: Get.height * 0.345),
                    child: Container(
                      padding: EdgeInsets.only(left: Get.width * 0.04),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //for class incharge
                        if(dashBoardController.dashboardData.value.data?.first.classIncharge?.length != null && dashBoardController.dashboardData.value.data!.first.classIncharge!.isNotEmpty)...{
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Class incharge',
                                style: TextStyle(color: AppColors.textcolor, fontSize: 15, fontWeight: FontWeight.w700),
                              ),
                              SizedBox(
                                height: Get.height * 0.015,
                              ),
                              SizedBox(
                                height: Get.height * 0.12,
                                width: Get.width,
                                child: ListView.separated(
                                    scrollDirection: Axis.horizontal,
                                    separatorBuilder: (BuildContext context, int index) => SizedBox(
                                      width: Get.width * 0.025,
                                    ),
                                    itemCount: (dashBoardController.dashboardData.value.data?.first.classIncharge ?? []).length,
                                    itemBuilder: (BuildContext context, int claindex) {
                                      var inchargedata = dashBoardController.dashboardData.value.data?.first.classIncharge?[claindex];
                                      return InkWell(
                                        onTap: (){
                                          GetStorage().write(Constants.stData, inchargedata?.stdata);
                                          //dashBoardController.storeclassInchargeList(inchargedata!);
                                          dashBoardController.storeclassInchargeList(inchargedata!);
                                          dashBoardController.storeInchargeList(SubjectIncharge());
                                          // GetStorage().remove("SubjectIncharge");
                                          Get.to(()=>  StaffProfileScreen());
                                        },
                                        child: Container(
                                          height: Get.height * 0.13,
                                          width: Get.width * 0.35,
                                          //padding: const EdgeInsets.all(7),
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(15),
                                              border: Border.all(color: AppColors.lightgreencolor,width: 1.3)
                                            // image: DecorationImage(
                                            //     image: AssetImage(classinchargeimages[claindex % classinchargeimages.length]),
                                            //     fit: BoxFit.fill)
                                          ),
                                          child: Column(
                                            children: [
                                              Container(
                                                width: Get.width * 0.35,
                                                height: Get.height*0.067,
                                                decoration: BoxDecoration(
                                                  color: AppColors.lightgreencolor,
                                                  borderRadius: BorderRadius.circular(15),
                                                ),
                                                child: Image.asset('assets/images/classinchargeicon.png'),
                                              ),

                                              SizedBox(
                                                height: Get.height * 0.01,
                                              ),
                                              Text(inchargedata?.classSection ?? "",
                                                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14, color: AppColors.textcolor),),
                                            ],
                                          ),
                                        ),
                                      );
                                    }),
                              ),
                            ],
                          )
                        }else...{
                          SizedBox.shrink(),
                        },


                          SizedBox(
                            height: Get.height * 0.035,
                          ),

                          //for subject incharge
                      dashBoardController.dashboardData.value.data?.first.subjects?.length != null
                          ?Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Subject Incharge',
                            style: TextStyle(color: AppColors.textcolor, fontSize: 15, fontWeight: FontWeight.w700),
                          ),
                          SizedBox(
                            height: Get.height * 0.015,
                          ),
                          SizedBox(
                            height: Get.height * 0.21,
                            width: Get.width,
                            child: ListView.separated(
                                scrollDirection: Axis.horizontal,
                                separatorBuilder: (BuildContext context, int index) => SizedBox(
                                  width: Get.width * 0.05,
                                ),
                                itemCount: (dashBoardController.dashboardData.value.data?.first.subjects ?? []).length,
                                itemBuilder: (BuildContext context, int index) {
                                  var subjectinc = dashBoardController.dashboardData.value.data?.first.subjects;
                                  return InkWell(
                                    onTap: () {
                                      GetStorage().write(Constants.stData, subjectinc?[index].stdata);
                                      dashBoardController.storeInchargeList(subjectinc![index]);
                                      Get.to(()=>  StaffProfileScreen());
                                    },
                                    child: Container(
                                      height: Get.height * 0.1,
                                      width: Get.width * 0.33,
                                      padding: const EdgeInsets.all(7),
                                      decoration: BoxDecoration(
                                          color: subjectboxcolor[index % subjectboxcolor.length],
                                          borderRadius: BorderRadius.circular(15),
                                          border: Border.all(color: subjectcolorlist[index % subjectcolorlist.length])
                                        // image: DecorationImage(
                                        //     image: AssetImage(
                                        //         subjectinchargeimages[index % subjectinchargeimages.length]),
                                        //     fit: BoxFit.fill)
                                      ),
                                      child: Column(
                                        // crossAxisAlignment: CrossAxisAlignment.center,
                                        // mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            height: Get.height * 0.023,
                                          ),
                                          Image.asset(subjectinchargeimages[index % subjectinchargeimages.length]),

                                          SizedBox(
                                            height: Get.height * 0.022,
                                          ),

                                          Text('${subjectinc?[index].subjectName}',
                                            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15,
                                                color: AppColors.textcolor),),
                                          SizedBox(
                                            height: Get.height * 0.019,
                                          ),
                                          Text('${subjectinc?[index].classSection}',
                                            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14,
                                                color: AppColors.textcolor),),


                                          // Image.asset('assets/images/openbook.png'),
                                        ],
                                      ),
                                    ),
                                  );
                                }),
                          ),
                        ],
                      )
                          :SizedBox.shrink(),


                          SizedBox(
                            height: Get.height * 0.035,
                          ),

                          //for live class
                          dashBoardController.dashboardData.value.data?.first.liveClassInfo?.first.classSection == "No Class Schedule"
                             // && dashBoardController.dashboardData.value.data?.first.liveClassInfo?.length == null
                          ?SizedBox.shrink()
                          : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Live Classes',
                            style: TextStyle(color: AppColors.textcolor, fontSize: 15, fontWeight: FontWeight.w700),
                          ),
                          SizedBox(
                            height: Get.height * 0.015,
                          ),
                          SizedBox(
                            height: Get.height * 0.165,
                            width: Get.width,
                            child: ListView.separated(
                                scrollDirection: Axis.horizontal,
                                separatorBuilder: (BuildContext context, int index) => SizedBox(
                                  width: Get.width * 0.028,
                                ),
                                itemCount: (dashBoardController.dashboardData.value.data?.first.liveClassInfo ?? []).length,
                                itemBuilder: (BuildContext context, int index) {
                                  var liveclassdata = dashBoardController.dashboardData.value.data?.first.liveClassInfo;
                                  return Container(
                                    height: Get.height * 0.17,
                                    width: Get.width * 0.75,
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
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            SizedBox(
                                              width: Get.width*0.6,
                                              child: Text('${liveclassdata?[index].heading??""}',
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
                                                          Text('${liveclassdata?[index].startTime??""}',
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
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Text('Class - ${liveclassdata?[index].classSubject??""}',
                                                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500,
                                                    color: Colors.white),),
                                                  InkWell(
                                                    onTap: (){
                                                      UtilityHelper.redirectToURL(
                                                          liveclassdata![index].link);
                                                    },
                                                    child: Container(
                                                      height: Get.height*0.05,
                                                      width: Get.width*0.22,
                                                      decoration: BoxDecoration(
                                                          color: AppColors.lightgreencolor,
                                                          //border: Border.all(color: AppColors.apppurplecolor, width: 2),
                                                          borderRadius: BorderRadius.circular(10)
                                                      ),
                                                      child: Center(child: Text('${liveclassdata?[index].button}',
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
                        ],
                      ),

                          // SizedBox(
                          //   height: Get.height * 0.02,
                          // ),

                          // for Upcoming Lecture
                          // const Text(
                          //   'Upcoming Lecture',
                          //   style: TextStyle(color: AppColors.blue, fontSize: 15, fontWeight: FontWeight.w500),
                          // ),
                          // SizedBox(
                          //   height: Get.height * 0.01,
                          // ),
                          // SizedBox(
                          //   height: Get.height * 0.11,
                          //   width: Get.width,
                          //   child: ListView.separated(
                          //       scrollDirection: Axis.horizontal,
                          //       separatorBuilder: (BuildContext context, int index) => SizedBox(
                          //         width: Get.width * 0.025,
                          //       ),
                          //       itemCount: 14,
                          //       itemBuilder: (BuildContext context, int index) {
                          //         return Stack(
                          //           children: [
                          //             Padding(
                          //               padding: EdgeInsets.only(left: Get.width*0.024),
                          //               child: Container(
                          //                 height: Get.height * 0.1,
                          //                 width: Get.width * 0.55,
                          //                 padding: const EdgeInsets.all(7),
                          //                 decoration: BoxDecoration(
                          //                     image: DecorationImage(
                          //                         image: AssetImage(upcomingLectureimages[index % upcomingLectureimages.length]),
                          //                         fit: BoxFit.fill)),
                          //                 child: Column(
                          //                   // crossAxisAlignment: CrossAxisAlignment.center,
                          //                   // mainAxisAlignment: MainAxisAlignment.center,
                          //                   children: [
                          //                     SizedBox(
                          //                       height: Get.height * 0.01,
                          //                     ),
                          //                     Image.asset('assets/images/classboomark.png'),
                          //                     SizedBox(
                          //                       height: Get.height * 0.01,
                          //                     ),
                          //                     const Text('data'),
                          //                   ],
                          //                 ),
                          //               ),
                          //             ),
                          //             Container(
                          //               height: Get.height * 0.1,
                          //               width: Get.width * 0.2,
                          //               //padding: const EdgeInsets.all(7),
                          //               decoration: BoxDecoration(
                          //                   image: DecorationImage(
                          //                       image: AssetImage("assets/images/upcominlecture1.png"),
                          //                       fit: BoxFit.fill)),
                          //               child: Column(
                          //                 children: [
                          //                   const Text('data'),
                          //                 ],
                          //               ),
                          //             ),
                          //           ],
                          //         );
                          //       }),
                          // ),
                          dashBoardController.dashboardData.value.data?.first.liveClassInfo?.first.classSection == "No Class Schedule"
                              ?SizedBox.shrink()
                              : SizedBox(
                            height: Get.height * 0.035,
                          ),

                      //     // for Notification
                      // dashBoardController.dashboardData.value.data?.first.latestInfo?.length == null
                      //     ?SizedBox.shrink()
                      //     :Column(
                      //   crossAxisAlignment: CrossAxisAlignment.start,
                      //   children: [
                      //     const Text(
                      //       'Notification',
                      //       style: TextStyle(color: AppColors.textcolor, fontSize: 15, fontWeight: FontWeight.w700),
                      //     ),
                      //     SizedBox(
                      //       height: Get.height * 0.015,
                      //     ),
                      //     SizedBox(
                      //       height: Get.height * 0.25,
                      //       width: Get.width,
                      //       child: ListView.separated(
                      //           scrollDirection: Axis.horizontal,
                      //           separatorBuilder: (BuildContext context, int index) => SizedBox(
                      //             width: Get.width * 0.04,
                      //           ),
                      //           itemCount: (dashBoardController.dashboardData.value.data?.first.latestInfo ?? []).length,
                      //           itemBuilder: (BuildContext context, int index) {
                      //             var latest = dashBoardController.dashboardData.value.data?.first.latestInfo;
                      //             return Container(
                      //               height: Get.height,
                      //               width: Get.width * 0.4,
                      //               padding: const EdgeInsets.all(7),
                      //               decoration: BoxDecoration(
                      //                 color: AppColors.lightgreencolor,
                      //                   borderRadius: BorderRadius.circular(16),
                      //                   border: Border.all(color: AppColors.textcolor)
                      //                   // image: DecorationImage(
                      //                   //     image: AssetImage(notigicationimages[index % notigicationimages.length]),
                      //                   //     fit: BoxFit.fill)
                      //               ),
                      //               child: Column(
                      //                 // crossAxisAlignment: CrossAxisAlignment.center,
                      //                 // mainAxisAlignment: MainAxisAlignment.center,
                      //                 children: [
                      //                   SizedBox(
                      //                     height: Get.height * 0.01,
                      //                   ),
                      //                   Row(
                      //                     mainAxisAlignment: MainAxisAlignment.center,
                      //                     children: [
                      //                       SizedBox(
                      //                         width: Get.width*0.25,
                      //                         child: Text('${latest?[index].heading}',
                      //                           overflow: TextOverflow.ellipsis,
                      //                           style: TextStyle(fontSize: 16, fontWeight: FontWeight.w900 , color: Colors.black),),
                      //                       ),
                      //                       SizedBox(width: 14,),
                      //                       Image.asset("assets/images/notificationbell.png")
                      //                     ],
                      //                   ),
                      //
                      //                   SizedBox(
                      //                       height: Get.height*0.18,
                      //                       child: Html(data: latest?[index].description,
                      //                         style: {
                      //                           "p": Style(
                      //                               color: Colors.black,
                      //                               textAlign: TextAlign.left,
                      //                               fontWeight: FontWeight.w500
                      //                           ),
                      //                           "data": Style(
                      //                               color: Colors.black,
                      //                               textAlign: TextAlign.left,
                      //                               fontWeight: FontWeight.w500
                      //                           ),
                      //                         },))
                      //                 ],
                      //               ),
                      //             );
                      //           }),
                      //     ),
                      //   ],
                      // ),

                          SizedBox(
                            height: Get.height * 0.06,
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        }
      ),
    ));
  }
}
