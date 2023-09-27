import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../helpers/endpoints.dart';
import '../helpers/network_manager.dart';
import '../models/exam_result_response_model.dart';
import '../models/exam_schedule_response_model.dart';
import '../utils/appcolors_theme.dart';

class ExamScheduleController extends GetxController{
  RefreshController examrefreshController = RefreshController(initialRefresh: false);
  Rx<ExamScheduleResModel> examData = ExamScheduleResModel().obs;
  RxList<ExamScheduleData> filterdata = <ExamScheduleData>[].obs;

  Future<void> onInit() async {
    super.onInit();
    await getExamScheduleData(refresh: true);
  }

  void onexamRefresh() async {
    await getExamScheduleData(refresh: true);
    examrefreshController.refreshCompleted();
  }
  // Api get attendance
  Future getExamScheduleData({required refresh}) async {
    var input = {"operation": "ExamSchedule"};
    var response = await NetworkManager.instance.getDio().post(Endpoints.examschedule, data: input);
    examData.value = ExamScheduleResModel.fromJson(response.data);
    filterdata.value = examData.value.data!;
    update();

  }

  //publish exam
  Future publishexamdata({required refresh, var examtypeid, var classid}) async {
    var input = {
      "operation": "ExamPublish",
      "ExaminationTypeID" : examtypeid ,
      "ClassID" : classid
    };
    var response = await NetworkManager.instance.getDio().post(Endpoints.publishexam, data: input);
    await getExamScheduleData(refresh: true);
    if(response.data["result"] == "success"){
      Fluttertoast.showToast(
          msg: "Published",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: AppColors.notfuntextcolor,
          textColor: Colors.white,
          fontSize: 16.0
      );
    }
    update();

  }



  void onexamLoading() async {
    examrefreshController.loadComplete();
  }


}