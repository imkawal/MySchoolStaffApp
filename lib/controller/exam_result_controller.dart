import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../helpers/endpoints.dart';
import '../helpers/network_manager.dart';
import '../models/exam_result_response_model.dart';
import '../utils/appcolors_theme.dart';

class ExamResultController extends GetxController{
  RefreshController refreshController = RefreshController(initialRefresh: false);
  Rx<ShowExamResultResModel> examresultData = ShowExamResultResModel().obs;
  final GlobalKey<FormState> examresultformKey = GlobalKey<FormState>();
  RxBool isBlock = false.obs;

  Future getExamResultData({required refresh, var examschid}) async {
    isBlock.value = true;
    var input = {
      "operation": "EnterExamResult",
      "ExaminationScheduleID" : examschid
    };
    var examresponse = await NetworkManager.instance.getDio().post(Endpoints.enterexamresult, data: input);
    examresultData.value = ShowExamResultResModel.fromJson(examresponse.data);
    isBlock.value = false;
    update();

  }

  Future UpdateExamResultData({required refresh, var examtype}) async {
    List<Map<String, String>> dta = <Map<String, String>>[];
      for (var i=0;i< (examresultData.value.data??[]).length;i++){
        Map<String, String> studen = {
          "RecordID": examresultData.value.data?[i].recordId??"",
          "ObtainedMarks": examresultData.value.data?[i].otainController?.text??""
        };
        dta.add(studen);
      }

    List<Map<String, String>> gradedta = <Map<String, String>>[];
    for (var i=0;i< (examresultData.value.data??[]).length;i++){
      Map<String, String> gradestuden = {
        "RecordID": examresultData.value.data?[i].recordId??"",
        "ObtainedGrade": examresultData.value.data?[i].gradeController?.text??""
      };
      gradedta.add(gradestuden);
    }
    var input1 = {
      "operation": "UpdateClassTestResult",
      "data": dta
    };
    var input2 = {
      "operation": "UpdateClassTestResult",
      "data": gradedta
    };
    var input = examtype == "Marks" ? input1 : input2;
    var response = await NetworkManager.instance.getDio().post(Endpoints.uupdateexamresult, data: input);
    //examData.value = ExamScheduleResModel.fromJson(response.data);
    if(response.data["result"] == "success"){
      Fluttertoast.showToast(
          msg: "Saved",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: AppColors.notfuntextcolor,
          textColor: Colors.white,
          fontSize: 16.0
      );
      print("data saved");
    }else{
      Fluttertoast.showToast(
          msg: "Data Not Saved",
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

  void onRefresh() async {
    await getExamResultData(refresh: true);
    await UpdateExamResultData(refresh: true);
    refreshController.refreshCompleted();
  }
}