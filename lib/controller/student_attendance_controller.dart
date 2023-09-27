import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../helpers/endpoints.dart';
import '../helpers/network_manager.dart';
import '../models/monthly_stu_att_response_model.dart';
import '../models/student_attendance_response_model.dart';

class StudentAttendanceController extends GetxController{
  Rx<StudentAttendanceResModel> studentattendanceData = StudentAttendanceResModel().obs;
  Rx<MonthlyStudentAttResModel> monthlystudentattendanceData = MonthlyStudentAttResModel().obs;
  RefreshController refreshController = RefreshController(initialRefresh: false);
  // final GlobalKey<FormState> attformKey = GlobalKey<FormState>();
  TextEditingController dateController = TextEditingController();
  DateTime currentDate = DateTime.now();
  DateTime date = DateTime.now();
 // var formattedDate;


  // @override
  // Future<void> onInit() async {
  //   super.onInit();
  //   await getStudentAttendance(refresh: true);
  // }

  // Api get attendance
  Future getStudentAttendance({required refresh, var classectionid, var attdate}) async {
    // var formattedDate = DateFormat('dd/MM/yyyy').format(date);
    // print(formattedDate);
    var input = {"operation": "StudentAttendance",
      "Date": dateController.text.isEmpty?attdate:dateController.text,
    //formattedDate:dateController.text,
      "ClassSectionID": classectionid };
    var response = await NetworkManager.instance.getDio().post(Endpoints.studentAttendance, data: input);
    studentattendanceData.value = StudentAttendanceResModel.fromJson(response.data);
    update();

  }

 // for update the student attendance
  Future updatethestudentattendance({required refresh, String? attenadnce, var recordid, var datetime, var attdate}) async {
    var input = {
      "operation": "UpdateStudentAttendance",
      "RecordID": recordid,
      "StartDate": dateController.text.isEmpty? datetime: dateController.text,
      "Attendence" : attenadnce
    };
    var updateresponse = await NetworkManager.instance.getDio().post(Endpoints.updatestudentAttendance, data: input);
    print(updateresponse);
    update();

  }

  void onRefresh() async {
    await getStudentAttendance(refresh: true);
    //await getStudentMonthlyAttendance(refresh: true);
    // await updatethestudentattendance(refresh: true);
    refreshController.refreshCompleted();
  }
  void onLoading() async {
    refreshController.loadComplete();
  }
}