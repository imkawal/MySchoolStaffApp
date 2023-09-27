import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:staffapp/utils/appcolors_theme.dart';
import '../controller/dashboard_controller.dart';
import '../controller/exam_schedule_controller.dart';
import '../controller/student_attendance_controller.dart';
import '../helpers/app_manager.dart';
import '../views/app_screen/assignment_screen.dart';
import '../views/app_screen/attendance_screen.dart';
import '../views/app_screen/chat_room_screen.dart';
import '../views/app_screen/class_test_screen.dart';
import '../views/app_screen/exam_screenn.dart';
import '../views/app_screen/live_classes_screen.dart';
import '../views/app_screen/staff_dashboard_screen.dart';
import '../views/app_screen/timetable_screen.dart';

class DrawerElement extends StatelessWidget {
  DrawerElement({Key? key}) : super(key: key);
  DashBoardController dashBoardController = Get.find<DashBoardController>();
  StudentAttendanceController studentAttendanceController = Get.put(StudentAttendanceController());
  ExamScheduleController examScheduleController = Get.put(ExamScheduleController());
  DateTime currentDate = DateTime.now();
  DateTime date = DateTime.now();

  @override
  Widget build(BuildContext context) {
    var formattedDate = DateFormat('dd/MM/yyyy').format(date);
    print(formattedDate);
    return Stack(
      children: [
        Container(
            width: Get.width * 0.75,
            decoration: const BoxDecoration(
                color: AppColors.textcolor,

            ),
            //padding: EdgeInsets.only(left: Get.width * 0.04, top: 10, bottom: 10),
            child: ClipRRect(
                //borderRadius: const BorderRadius.all(Radius.circular(40.0)),
                child: Drawer(
              backgroundColor: AppColors.textcolor,
              child: Column(
                children: [
                  Container(
                    height: Get.height*0.84,
                    width: Get.width*0.9,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                          alignment: Alignment.bottomCenter,
                            image: AssetImage("assets/images/drawerbackgroundimage.png",),fit: BoxFit.fitWidth
                        )
                    ),
                    child: ListView(
                      // padding: EdgeInsets.zero,
                      children: <Widget>[
                        SizedBox(
                          height: Get.height * 0.17,
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.find<DashBoardController>().dashboardscaffoldEy.currentState?.openEndDrawer();
                            Get.to(() => StaffDashboardScreen())?.whenComplete(() =>  Get.find<DashBoardController>().dashboardscaffoldEy.currentState?.closeDrawer());
                           // Get.find<DashBoardController>().dashboardscaffoldEy.currentState?.closeDrawer();
                          },
                          child: ListTile(
                            dense: true,
                            leading: Image.asset('assets/images/dashboardicon.png'),
                            title: Text(
                              'Dashboard',
                              style: TextStyle(
                                fontSize: Get.width * 0.05,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w500,
                                color: AppColors.white,
                              ),
                            ),
                          ),
                        ),

                        ListTile(
                          dense: true,
                          onTap: () {
                            Get.find<DashBoardController>().dashboardscaffoldEy.currentState?.openEndDrawer();
                            studentAttendanceController.getStudentAttendance(
                              refresh: true,
                                classectionid: AppManager.dashController.restoreInchargeListModel().classSectionId == null?
                                AppManager.dashController.restoreClassInchargeListModel().classSectionId??''
                                    : AppManager.dashController.restoreInchargeListModel().classSectionId??"",
                              attdate: formattedDate
                            );
                            Get.to(() => AttendanceScreen())?.whenComplete(() => Get.find<DashBoardController>().dashboardscaffoldEy.currentState?.closeDrawer());
                          },
                          leading: Image.asset('assets/images/attendanceicon.png'),
                          title: Text(
                            'Attendance',
                            style: TextStyle(
                              fontSize: Get.width * 0.05,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w500,
                              color: AppColors.white,
                            ),
                          ),
                        ),

                        ListTile(
                          dense: true,
                          onTap: () {
                            Get.find<DashBoardController>().dashboardscaffoldEy.currentState?.openEndDrawer();
                            Get.to(() =>  ClassTestScreen())?.whenComplete(() => Get.find<DashBoardController>().dashboardscaffoldEy.currentState?.closeDrawer());
                          },
                          leading: Image.asset('assets/images/classtesticon.png'),
                          title: Text(
                            'Class Test',
                            style: TextStyle(
                              fontSize: Get.width * 0.05,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w500,
                              color: AppColors.white,
                            ),
                          ),
                        ),

                        ListTile(
                          dense: true,
                          onTap: () {
                            Get.find<DashBoardController>().dashboardscaffoldEy.currentState?.openEndDrawer();
                            Get.to(() => AssignmentScreen())?.whenComplete(() => Get.find<DashBoardController>().dashboardscaffoldEy.currentState?.closeDrawer());
                          },
                          leading: Image.asset('assets/images/assignmenticon.png'),
                          title: Text(
                            'Assignment',
                            style: TextStyle(
                              fontSize: Get.width * 0.05,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w500,
                              color: AppColors.white,
                            ),
                          ),
                        ),

                        ListTile(
                          dense: true,
                          onTap: () {
                            // Get.find<DashBoardController>().dashboardscaffoldEy.currentState?.openEndDrawer();
                            //  Get.to(() =>  ChatRoomScreen());
                            Get.find<DashBoardController>().dashboardscaffoldEy.currentState?.closeDrawer();
                          },
                          leading: Image.asset('assets/images/communicationicon.png'),
                          title: Text(
                            'Communication',
                            style: TextStyle(
                              fontSize: Get.width * 0.05,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w500,
                              color: AppColors.white,
                            ),
                          ),
                        ),

                        ListTile(
                          dense: true,
                          onTap: () {
                            Get.find<DashBoardController>().dashboardscaffoldEy.currentState?.openEndDrawer();

                             Get.to(() =>  ExamScreen())?.whenComplete(() =>
                                 Get.find<DashBoardController>().dashboardscaffoldEy.currentState?.closeDrawer())
                                 .whenComplete(() =>  examScheduleController.getExamScheduleData(refresh: true));
                          },
                          leading: Image.asset('assets/images/examicon.png'),
                          title: Text(
                            'Exams',
                            style: TextStyle(
                              fontSize: Get.width * 0.05,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w500,
                              color: AppColors.white,
                            ),
                          ),
                        ),

                        ListTile(
                          dense: true,
                          onTap: () {
                            // Get.find<DashBoardController>().dashboardscaffoldEy.currentState?.openEndDrawer();
                            //  Get.to(() =>  TimeTableScreen());
                            Get.find<DashBoardController>().dashboardscaffoldEy.currentState?.closeDrawer();
                          },
                          leading: Image.asset('assets/images/timetableicon.png'),
                          title: Text(
                            'Time Table',
                            style: TextStyle(
                              fontSize: Get.width * 0.05,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w500,
                              color: AppColors.white,
                            ),
                          ),
                        ),

                        ListTile(
                          dense: true,
                          onTap: () {
                            Get.find<DashBoardController>().dashboardscaffoldEy.currentState?.openEndDrawer();
                             Get.to(() => LiveClassesScreen())?.whenComplete(() => Get.find<DashBoardController>().dashboardscaffoldEy.currentState?.closeDrawer());
                          },
                          leading: Image.asset('assets/images/liveclass.png'),
                          title: Text(
                            'Live Class',
                            style: TextStyle(
                              fontSize: Get.width * 0.05,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w500,
                              color: AppColors.white,
                            ),
                          ),
                        ),

                        ListTile(
                          dense: true,
                          onTap: () {
                           // Get.find<DashBoardController>().dashboardscaffoldEy.currentState?.openEndDrawer();
                            Get.find<DashBoardController>().dashboardscaffoldEy.currentState?.closeDrawer();
                          },
                          leading: Image.asset('assets/images/notificationicon.png'),
                          title: Text(
                            'Notifications',
                            style: TextStyle(
                              fontSize: Get.width * 0.05,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w800,
                              color: AppColors.white,
                            ),
                          ),
                        ),
                        ListTile(
                          dense: true,
                          onTap: () {
                            //Get.find<DashBoardController>().dashboardscaffoldEy.currentState?.closeDrawer();
                            Get.find<DashBoardController>().dashboardscaffoldEy.currentState?.closeDrawer();
                          },
                          leading: Image.asset(
                            'assets/images/concernsicon.png',
                            color: Colors.black87,
                          ),
                          title: Text(
                            'Concerns',
                            style: TextStyle(
                              fontSize: Get.width * 0.05,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w600,
                              color: AppColors.white,
                            ),
                          ),
                        ),
                        // SizedBox(
                        //   height: 10,
                        // ),

                      ],
                    ),
                  ),
                  Container(
                    height: Get.height*0.095,
                    decoration: const BoxDecoration(
                      border: Border(
                        top: BorderSide(
                          color: Colors.black,
                          width: 3.0,
                        ),
                      ),
                    ),
                    child: ListView(
                      children: [
                        // if (AppManager.statusHelper.getLoginStatus)
                        ListTile(
                          onTap: () {
                            // AppManager.authController.signOut();
                            Get.find<DashBoardController>().dashboardscaffoldEy.currentState?.closeDrawer();
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
                          dense: true,
                          title: Padding(
                            padding: EdgeInsets.only(left: Get.width * 0.135),
                            child: Text(
                              'Sign out',
                              style: TextStyle(
                                fontSize: 25,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w600,
                                color: AppColors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ))),
        // Padding(
        //   padding: EdgeInsets.only(top: Get.height * 0.5),
        //   child: Container(
        //       width: Get.width * 0.81,
        //       decoration: BoxDecoration(
        //         image: DecorationImage(
        //           image: AssetImage("assets/images/drawerbackgroundimage.png",)
        //         )
        //       ),
        //       // child: Image.asset(
        //       //   "assets/images/drawerbackgroundimage.png",
        //       //   width: Get.width * 0.85,
        //       //   fit: BoxFit.fill,
        //       // )
        //   ),
        // ),
        Padding(
          padding: EdgeInsets.only(
            left: Get.width * 0.04,
            top: Get.width * 0.056,
          ),
          child: Image.asset(
            "assets/images/drawerimage.png",
            width: Get.width * 0.92,
            fit: BoxFit.fill,
          ),
        ),
        Container(
            width: Get.width,
            margin: EdgeInsets.only(top: Get.height * 0.049, left: Get.width * 0.03, right: Get.width * 0.14),
            child: ListTile(
              leading: Container(
                  width: Get.width * 0.13,
                  height: Get.width * 0.15,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.yellow),
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          fit: BoxFit.fill,
                          image: NetworkImage(
                            dashBoardController.dashboardData.value.data?.first.photo == null ?
                            "https://w7.pngwing.com/pngs/481/915/png-transparent-computer-icons-user-avatar-woman-avatar-computer-business-conversation-thumbnail.png":
                            dashBoardController.dashboardData.value.data?.first.photo??"",

                          )))),
              // : AppManager.authController.restoreSelectedStudentModel().photo)))),
              title: SizedBox(
                width: Get.width*0.2,
                child: Text( dashBoardController.dashboardData.value.data?.first.staffName??"",
                  overflow: TextOverflow.ellipsis,
                  //"Staff",
                  //AppManager.authController.restoreSelectedStudentModel().studentName,
                  style: const TextStyle(fontSize: 19, color: Color(0xFF232323), fontWeight: FontWeight.w700),
                ),
              ),

              //             trailing:  IconButton(
              //               icon: const Icon(Icons.arrow_forward_ios),
              //               onPressed: (){}
              // //Get.to(()=> const StudentProfile()),
              //             )
            )),
      ],
    );
  }
}
