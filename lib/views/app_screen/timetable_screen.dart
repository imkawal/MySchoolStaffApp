import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:get/get.dart';

import '../../utils/appcolors_theme.dart';
import '../../utils/drawer_widget.dart';

class TimeTableScreen extends StatelessWidget {
  TimeTableScreen({Key? key}) : super(key: key);
  final GlobalKey<ScaffoldState> timetablescaffoldEy = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: timetablescaffoldEy,
        drawer: DrawerElement(),
        body: SizedBox(
          height: Get.height*0.9999,
          child: Stack(
            children: [
              Container(
                height: Get.height * 0.34,
                decoration: const BoxDecoration(
                  color: AppColors.backgroundpurple,
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(width: Get.width*0.01,),
                      IconButton(
                          onPressed: (){
                            timetablescaffoldEy.currentState!.openDrawer();
                          },
                          icon: Icon(Icons.menu, color: AppColors.white,)
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: Text(
                          'Timetable',
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: AppColors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              Padding(
                padding: EdgeInsets.only(top: Get.height * 0.07, left: Get.width * 0.045, right:Get.width * 0.045 ),
                child: Container(
                  alignment: Alignment.center,
                  width: Get.width * 0.99,
                  height: Get.height * 0.99,
                  padding: EdgeInsets.only(left: Get.width*0.05, right: Get.width*0.065, top: Get.height*0.03),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: Get.height * 0.01,
                        ),
                        Container(
                          width: Get.width*0.8,
                          decoration: BoxDecoration(
                            color: AppColors.white,
                            //border: Border.all(color: Colors.purple.shade300, width: 10),
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
                          ),
                          child: CalendarCarousel(
                            headerMargin: const EdgeInsets.all(1.0),
                            onCalendarChanged: (val) {
                              // studentattendanceController.getStudentAttendance(
                              //     refresh: false, month: val, year: val);
                            },
                            headerTextStyle: const TextStyle(
                                color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold),
                            iconColor: Colors.pink,
                            todayTextStyle: const TextStyle(
                              color: Colors.black,
                            ),
                            todayButtonColor: Colors.blue,
                            weekendTextStyle: const TextStyle(
                              color: Colors.black,
                            ),
                            weekdayTextStyle: const TextStyle(
                              color: Colors.black,
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
                        ),
                        SizedBox(
                          height: Get.height * 0.03,
                        ),
                        Container(
                          //flex: 1,
                           height: Get.height*0.99,
                           //width: Get.width*0.9,
                          child: ListView.separated(
                            physics: NeverScrollableScrollPhysics(),
                              separatorBuilder: (BuildContext context, int index) => SizedBox(height: Get.height*0.02,),
                              itemCount: 14,
                              itemBuilder: (BuildContext context, int index) {
                                return  Container(
                                    height: Get.height*0.1,
                                    width: Get.width*0.8,
                                    padding: EdgeInsets.only(left: Get.width*0.02),
                                    decoration: BoxDecoration(
                                        color: Colors.transparent,
                                        borderRadius: BorderRadius.circular(10),
                                        image: DecorationImage(
                                            image: AssetImage("assets/images/upcominlecture2.png"),
                                            //colorFilter: ColorFilter.mode(assignmentcolorList[index % assignmentcolorList.length], BlendMode.color),
                                            fit: BoxFit.fill
                                        )
                                    ),
                                    child: Text('data')
                                );
                              }),
                        ),
                        SizedBox(
                          height: Get.height * 0.06,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
