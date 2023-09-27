import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../helpers/endpoints.dart';
import '../helpers/network_manager.dart';
import '../models/monthly_stu_att_response_model.dart';

class StudentMonthlyAttController extends GetxController{
  Rx<MonthlyStudentAttResModel> monthlystudentattendanceData = MonthlyStudentAttResModel().obs;
  RefreshController refreshController = RefreshController(initialRefresh: false);
  TextEditingController dateController = TextEditingController();

  // get monthly_student_attendance
  Future getStudentMonthlyAttendance({required refresh, var classsecid, var studentid, var studate}) async {
    var input = {
      "operation": "ViewStudentAttendance",
      "ClassSectionID": classsecid,
      "StudentID": studentid,
      "Date" : studate,
    };
    var monthlyresponse = await NetworkManager.instance.getDio().post(Endpoints.monthlystudentAttendance, data: input);
    monthlystudentattendanceData.value = MonthlyStudentAttResModel.fromJson(monthlyresponse.data);
    update();

  }


  void onRefresh() async {
    await getStudentMonthlyAttendance(refresh: true);
    // await updatethestudentattendance(refresh: true);
    refreshController.refreshCompleted();
  }
}