import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:get/get.dart';
import 'package:staffapp/helpers/app_manager.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../../controller/student_attendance_controller.dart';
import '../../controller/student_monthly_att_controller.dart';
import '../../utils/appcolors_theme.dart';

class ViewAttendaneScreen extends StatelessWidget {
  String? name;
  String? stuclass;
  ViewAttendaneScreen({Key? key, this.name, this.stuclass}) : super(key: key);

  List attendanceCardimages = [
    "assets/images/attendance_card1.png",
    "assets/images/attendance_card2.png",
    "assets/images/attendance_card3.png"
  ];

  final colorList = <Color>[
    AppColors.greencolor,
    AppColors.redcolor,
    AppColors.purplecolor,
    AppColors.bluecolor,
  ];
  StudentAttendanceController monthlystudentAttendanceController = Get.find<StudentAttendanceController>();
  Map<String, double> dataMap = {"Present": 5, "Leave": 2, "Absent": 3};
  StudentMonthlyAttController studentMonthlyAttController = Get.find<StudentMonthlyAttController>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.screencolor,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: AppColors.darkblue,
          centerTitle: true,
          leading: IconButton(
              onPressed: (){
                Get.back();
              },
              icon: Icon(Icons.arrow_back,size: 27, color: AppColors.white,)),
          title: Text('View Attendance',
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 22, color: AppColors.white),),
        ),
        body: GetBuilder<StudentMonthlyAttController>(
          builder: (studentMonthlyAttController){
            var monthldata = studentMonthlyAttController.monthlystudentattendanceData.value.data;
            var monthvalue =studentMonthlyAttController.monthlystudentattendanceData.value;
            return Stack(
              children: [
                Column(
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
                              SizedBox(width: 20,),
                              Image.asset("assets/images/personicon.png"),
                              SizedBox(width: 8,),
                              SizedBox(
                                width: Get.width*0.38,
                                child: Text(name??"",
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16,
                                      color: AppColors.darkblue),),
                              )

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
                              SizedBox(width: 20,),
                              Image.asset("assets/images/user-group.png"),
                              SizedBox(width: 8,),
                              Text(AppManager.dashController.restoreInchargeListModel().classSection == null?
                              ("Class - ${AppManager.dashController.restoreClassInchargeListModel().classSection??""}")
                                  : ("Class - ${AppManager.dashController.restoreInchargeListModel().classSection??""}"),
                                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16,
                                    color: AppColors.darkblue),),
                            ],
                          ),
                        )
                      ],
                    ),
                    Padding(
                      padding:  EdgeInsets.only(left: Get.width*0.03, right: Get.width*0.03),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: Get.height*0.015,),
                          // Text('Mark attendance',
                          //   style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18, color: AppColors.apppurplecolor),),
                          // SizedBox(height: Get.height*0.02,),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //   children: [
                          //     Container(
                          //       height: Get.height*0.05,
                          //       width: Get.width*0.23,
                          //       decoration: BoxDecoration(
                          //           border: Border.all(color: AppColors.black),
                          //           borderRadius: BorderRadius.circular(20)
                          //       ),
                          //       child: Center(child: Text(stuclass??"",
                          //         style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: AppColors.black),)),
                          //     ),
                          //     Container(
                          //       height: Get.height*0.05,
                          //       width: Get.width*0.35,
                          //       decoration: BoxDecoration(
                          //           border: Border.all(color: AppColors.black),
                          //           borderRadius: BorderRadius.circular(20)
                          //       ),
                          //       child: Center(child: Text(name??"",
                          //         style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: AppColors.black),)),
                          //     ),
                          //     GestureDetector(
                          //       onTap: (){
                          //         // Get.to(()=> ViewAttendaneScreen());
                          //       },
                          //       child: Container(
                          //         height: Get.height*0.05,
                          //         width: Get.width*0.26,
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
                          //SizedBox(height: Get.height*0.02,),
                          CalendarCarousel(
                            headerMargin: const EdgeInsets.all(1.0),
                            onCalendarChanged: (val) {
                              // studentattendanceController.getStudentAttendance(
                              //     refresh: false, month: val, year: val);
                            },
                            daysTextStyle: TextStyle(
                                color: AppColors.textcolor,fontWeight: FontWeight.w500,fontSize: 18
                            ),
                            headerTextStyle: const TextStyle(
                                color: AppColors.textcolor, fontSize: 25, fontWeight: FontWeight.w900),
                            iconColor: Colors.pink,

                            leftButtonIcon: IconButton(
                              onPressed: (){
                                // studentattendanceController.getStudentAttendance(refresh: false,month: DateTime(studentattendanceController.currentDate.month-1),year:'2022' );
                              },
                              icon: const Icon(Icons.arrow_back_ios),color: Colors.transparent,),
                            rightButtonIcon: IconButton(
                              onPressed: (){},
                              icon: const Icon(Icons.arrow_forward_ios),color: Colors.transparent,),
                            todayTextStyle: const TextStyle(
                                color: AppColors.textcolor,fontWeight: FontWeight.w500,fontSize: 18
                            ),
                            todayButtonColor: Colors.blue,
                            weekendTextStyle: const TextStyle(
                                color: AppColors.redcolor,fontWeight: FontWeight.w500,fontSize: 18
                            ),
                            weekdayTextStyle: const TextStyle(
                                color: AppColors.textcolor,fontWeight: FontWeight.w500,fontSize: 18
                            ),
                            // dayButtonColor: studentattendanceController.studentattendanceData.value.data!.p.contains(3) ?
                            //     Colors.green : Colors.transparent,

                            thisMonthDayBorderColor: Colors.grey,
                            customDayBuilder: (
                                /// you can provide your own build function to make custom day containers
                                bool isSelectable,
                                int index,
                                bool isSelectedDay,
                                bool isToday,
                                bool isPrevMonthDay,
                                TextStyle textStyle,
                                bool isNextMonthDay,
                                bool isThisMonthDay,
                                DateTime day,
                                ) {
                              if (monthldata!.p !=
                                  null) {
                                if (monthldata!.p!
                                    .contains(day.day) &&
                                    monthldata!.months
                                    !.contains(day.month.toString())) {
                                  return CircleAvatar(
                                    backgroundColor: Colors.transparent,
                                    child: Column(
                                      children: [
                                        SizedBox(height: 9,),
                                        Text(
                                          day.day.toString(),
                                          style: const TextStyle( color: AppColors.textcolor,fontWeight: FontWeight.w500,fontSize: 18),
                                        ),
                                        Icon(Icons.circle, color: AppColors.greencolor, size: 10,)
                                      ],
                                    ),
                                  );
                                }
                              }
                              if (monthldata.a !=
                                  null) {
                                if (monthldata.a!
                                    .contains(day.day) &&
                                    monthldata.months!
                                        .contains(day.month.toString())) {
                                  return CircleAvatar(
                                    backgroundColor: Colors.transparent,
                                    child: Column(
                                      children: [
                                        SizedBox(height: 9,),
                                        Text(
                                          day.day.toString(),
                                          style: const TextStyle( color: AppColors.textcolor,fontWeight: FontWeight.w500,fontSize: 18),
                                        ),
                                        Icon(Icons.circle, color: AppColors.redcolor,size: 10,)
                                      ],
                                    ),
                                  );
                                }
                              }

                              if (monthldata!.l !=
                                  null) {
                                if (monthldata!.l!
                                    .contains(day.day) &&
                                    monthldata!.months!
                                        .contains(day.month.toString())) {
                                  return CircleAvatar(
                                    backgroundColor: Colors.transparent,
                                    child: Column(
                                      children: [
                                        SizedBox(height: 9,),
                                        Text(
                                          day.day.toString(),
                                          style: const TextStyle( color: AppColors.textcolor,fontWeight: FontWeight.w500,fontSize: 18),
                                        ),
                                        Icon(Icons.circle, size: 10, color: AppColors.bluecolor,)
                                      ],
                                    ),
                                  );
                                }
                              }
                              if (monthldata.h !=
                                  null) {
                                if (monthldata!.h!
                                    .contains(day.day) &&
                                    monthldata!.months!
                                        .contains(day.month.toString())) {
                                  return CircleAvatar(
                                    backgroundColor: Colors.transparent,
                                    child: Column(
                                      children: [
                                        SizedBox(height: 9,),
                                        Text(
                                          day.day.toString(),
                                          style: const TextStyle( color: AppColors.textcolor,fontWeight: FontWeight.w500,fontSize: 18),
                                        ),
                                        Icon(Icons.circle,color: AppColors.purplecolor,size: 10,)
                                      ],
                                    ),
                                  );
                                }
                              } else {
                                return null;
                              }
                              return null;
                            },
                            weekFormat: false,
                            //markedDatesMap: _markedDateMap,
                            height: Get.height * 0.5,
                            //selectedDateTime: _currentDate,
                            //daysHaveCircularBorder: false,
                            selectedDayBorderColor: Colors.yellow,
                            //selectedDayButtonColor: Colors.yellow,
                            //selectedDayTextStyle: const TextStyle(color: Colors.black),
                          ),

                        ],
                      ),
                    ),

                  ],
                ),
                SlidingUpPanel(
                    padding: EdgeInsets.only(left: Get.width*0.05, right: Get.width*0.05),
                    boxShadow: [BoxShadow(blurRadius: 1.0, color: Color.fromRGBO(0, 0, 0, 0.25))],
                    color: Color(0xffCDE6E9),
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(30.0),
                        topLeft: Radius.circular(30.0)),
                    minHeight: Get.height*0.34,
                    maxHeight: Get.height*0.81,
                    panel: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: Get.height*0.02,),
                        Center(
                          child: Image.asset("assets/images/uparrow.png",
                            scale: 0.7,),
                        ),
                        SizedBox(height: Get.height*0.025,),
                        Text('Attendance Summary',
                          style: TextStyle(color: AppColors.textcolor,fontWeight: FontWeight.w700, fontSize: 17),),
                        SizedBox(height: Get.height*0.02,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: 53,
                              width: Get.width*0.42,
                              decoration: BoxDecoration(
                                  color: AppColors.white,
                                  border: Border.all(color: AppColors.darkblue),
                                  borderRadius: BorderRadius.circular(12)
                              ),
                              child: Row(
                                children: [
                                  SizedBox(width: 9,),
                                  Container(
                                    height: 30,
                                    width: 30,
                                    decoration: BoxDecoration(
                                        color: AppColors.greencolor,
                                        borderRadius: BorderRadius.circular(9)
                                    ),
                                    child: Center(child: Text("${monthvalue.totalPresent}",
                                      style: TextStyle(fontWeight: FontWeight.w700, color: AppColors.white, fontSize: 15),)),
                                  ),
                                  SizedBox(width: 9,),
                                  Text("Total Present",
                                    style: TextStyle(color: AppColors.textcolor, fontSize: 14, fontWeight: FontWeight.w700),)
                                ],
                              ),
                            ),
                            Container(
                              height: 53,
                              width: Get.width*0.42,
                              decoration: BoxDecoration(
                                  color: AppColors.white,
                                  border: Border.all(color: AppColors.darkblue),
                                  borderRadius: BorderRadius.circular(12)
                              ),
                              child: Row(
                                children: [
                                  SizedBox(width: 9,),
                                  Container(
                                    height: 30,
                                    width: 30,
                                    decoration: BoxDecoration(
                                        color: AppColors.redcolor,
                                        borderRadius: BorderRadius.circular(9)
                                    ),
                                    child: Center(child: Text("${monthvalue.totalAbsent}",
                                      style: TextStyle(fontWeight: FontWeight.w700, color: AppColors.white, fontSize: 15),)),
                                  ),
                                  SizedBox(width: 9,),
                                  Text("Total Absence",
                                    style: TextStyle(color: AppColors.textcolor, fontSize: 14, fontWeight: FontWeight.w700),)
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: Get.height*0.02,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: 53,
                              width: Get.width*0.42,
                              decoration: BoxDecoration(
                                  color: AppColors.white,
                                  border: Border.all(color: AppColors.darkblue),
                                  borderRadius: BorderRadius.circular(12)
                              ),
                              child: Row(
                                children: [
                                  SizedBox(width: 9,),
                                  Container(
                                    height: 30,
                                    width: 30,
                                    decoration: BoxDecoration(
                                        color: AppColors.bluecolor,
                                        borderRadius: BorderRadius.circular(9)
                                    ),
                                    child: Center(child: Text("${monthvalue.totalLeave}",
                                      style: TextStyle(fontWeight: FontWeight.w700, color: AppColors.white, fontSize: 15),)),
                                  ),
                                  SizedBox(width: 9,),
                                  Text("Total Leaves",
                                    style: TextStyle(color: AppColors.textcolor, fontSize: 14, fontWeight: FontWeight.w700),)
                                ],
                              ),
                            ),
                            Container(
                              height: 53,
                              width: Get.width*0.42,
                              decoration: BoxDecoration(
                                  color: AppColors.white,
                                  border: Border.all(color: AppColors.darkblue),
                                  borderRadius: BorderRadius.circular(12)
                              ),
                              child: Row(
                                children: [
                                  SizedBox(width: 9,),
                                  Container(
                                    height: 30,
                                    width: 30,
                                    decoration: BoxDecoration(
                                        color: AppColors.purplecolor,
                                        borderRadius: BorderRadius.circular(9)
                                    ),
                                    child: Center(child: Text("${monthvalue.totalHalfDay}",
                                      style: TextStyle(fontWeight: FontWeight.w700, color: AppColors.white, fontSize: 15),)),
                                  ),
                                  SizedBox(width: 9,),
                                  Text("Half Days",
                                    style: TextStyle(color: AppColors.textcolor, fontSize: 14, fontWeight: FontWeight.w700),)
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: Get.height*0.025,),
                        Text('Attendance Chart',
                          style: TextStyle(color: AppColors.textcolor,fontWeight: FontWeight.w700, fontSize: 17),),
                        SizedBox(height: Get.height*0.02),
                        Center(
                          child: Container(
                            alignment: Alignment.center,
                            width: Get.width * 0.89,
                            height: Get.height * 0.4,
                            decoration: BoxDecoration(
                              color: Color(0xffE7FCFF),
                              border: Border.all(color: AppColors.darkblue, width: 1.4),
                              borderRadius: BorderRadius.circular(20),
                              // color: Colors.pink.shade200,
                            ),
                            child: PieChart(
                                dataMap:
                                {
                                  "${monthvalue.graphData?.presents?.toString()}\nPresent\n": double.parse(monthvalue.totalPresent!.isNotEmpty?"${monthvalue.totalPresent}":"0.0"),
                                  "${monthvalue.graphData?.absent?.toString()}\nAbsent\n": double.parse(monthvalue.totalAbsent!.isNotEmpty?"${monthvalue.totalAbsent}":"0.0"),
                                  "${monthvalue.graphData?.halfDays?.toString()}\nHalf Days\n": double.parse(monthvalue.totalHalfDay!.isNotEmpty?"${monthvalue.totalHalfDay}":"0.0"),
                                  "${monthvalue.graphData?.leaved?.toString()}\nLeave\n": double.parse(monthvalue.totalLeave!.isNotEmpty?"${monthvalue.totalLeave}":"0.0"),
                                },
                                //dataMap,
                                animationDuration: const Duration(milliseconds: 800),
                                chartLegendSpacing: 15,
                                chartRadius: MediaQuery.of(context).size.width / 3,
                                colorList: colorList,
                                initialAngleInDegree: 0,
                                chartType: ChartType.ring,
                                ringStrokeWidth: 22,
                                // centerText: "HYBRID",
                                legendOptions: const LegendOptions(
                                  showLegendsInRow: false,
                                  legendPosition: LegendPosition.right,
                                  showLegends: true,
                                  legendShape: BoxShape.circle,
                                  legendTextStyle: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                chartValuesOptions: const ChartValuesOptions(
                                  showChartValueBackground: true,
                                  showChartValues: false,
                                  showChartValuesInPercentage: false,
                                  showChartValuesOutside: true,
                                  decimalPlaces: 1,
                                ),
                                // gradientList: ---To add gradient colors---
                                emptyColorGradient: [
                                  Color(0xffD9D9D9)
                                ]
                            ),

                          ),
                        ),
                      ],
                    )
                )
              ],
            );
          }
        )
      ),
    );
  }
}
