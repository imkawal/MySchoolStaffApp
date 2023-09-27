import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../helpers/endpoints.dart';
import '../helpers/network_manager.dart';
import '../models/class_test_result_response_model.dart';
import '../utils/appcolors_theme.dart';
import '../views/app_screen/class_test_screen.dart';

class ClassTestResultController extends GetxController{
  RefreshController refreshController = RefreshController(initialRefresh: false);
  Rx<ClassTestResultResModel> classtestresultresData = ClassTestResultResModel().obs;
  TextEditingController obtainmarksController = TextEditingController();
   List<TextEditingController> texttEditingControllers = [];
  final GlobalKey<FormState> classtestformKey = GlobalKey<FormState>();
   var myControllers = [];
  RxBool isBlock = false.obs;

  // @override
  // Future<void> onInit() async {
  //   super.onInit();
  //   await getClassTestResultData(refresh: true);
  // }


  Future getClassTestResultData({required refresh , var classtestid}) async {
    isBlock.value = true;
    var input = {
      "operation": "ClassTestResult",
      "ClassTestID" : classtestid };
    var response = await NetworkManager.instance.getDio().post(Endpoints.classtestresult, data: input);
    print(response);
    classtestresultresData.value = ClassTestResultResModel.fromJson(response.data);
    isBlock.value = false;
    update();

  }

  Future getUpdateClassTestResultData({required refresh }) async {
    List<Map<String, String>> dta = <Map<String, String>>[];
    for (var i=0;i<(classtestresultresData.value.data??[]).length;i++){
      Map<String, String> studen = {
        "RecordID": classtestresultresData.value.data?[i].recordId??"",
        "ObtainedMarks": classtestresultresData.value.data?[i].otainController?.text??"0"
      };
      dta.add(studen);
    }
    var input =
    {
      "operation": "UpdateClassTestResult",
      "data": dta
    };
    var updateresponse = await NetworkManager.instance.getDio().post(Endpoints.updateclasstestresult, data: input);
    print(updateresponse);
    if(updateresponse.data["result"] == "success"){
      Fluttertoast.showToast(
          msg: "Saved",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: AppColors.notfuntextcolor,
          textColor: Colors.white,
          fontSize: 16.0
      );
    }
  //  obtainmarksController.clear();
   // await getClassTestResultData(refresh: true);
    //Get.to(()=> ClassTestScreen());
   // classtestresultresData.value = ClassTestResultResModel.fromJson(response.data);
    update();

  }

  void onRefresh() async {
   // await getClassTestResultData(refresh: true);
    await getUpdateClassTestResultData(refresh: true);
    refreshController.refreshCompleted();
  }
}