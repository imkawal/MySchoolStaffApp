import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../helpers/endpoints.dart';
import '../helpers/network_manager.dart';
import '../models/class_test_response_model.dart';
import '../utils/appcolors_theme.dart';
import '../views/app_screen/class_test_screen.dart';

class ClassTestController extends GetxController{
  RefreshController refreshController = RefreshController(initialRefresh: false);
  Rx<ClassTestResModel> classtestresData = ClassTestResModel().obs;
  TextEditingController titleController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController gradeController = TextEditingController();
  TextEditingController maxgradeController = TextEditingController();
  RxString newgradeContoller = "".obs;
  RxString classsubjectidContoller = "".obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    await getclassTestData(refresh: true);
  }

  // Api get attendance
  Future getclassTestData({required refresh}) async {
    var input = {"operation": "ClassTest" };
    var response = await NetworkManager.instance.getDio().post(Endpoints.classtest, data: input);
    print(response);
    classtestresData.value = ClassTestResModel.fromJson(response.data);
    update();

  }

  // for create the class test
  Future createclassTest({required refresh, var classsubjectid , var classsectionid, var subj}) async {
    var input = {
      "operation": "AddClassTest",
      "Name" : titleController.text,
      "Date" : dateController.text,
      "ClassSectionID": classsectionid,
      "ClassSubjectID": classsubjectidContoller.value.isEmpty?classsubjectid == null?subj:classsubjectid:classsubjectidContoller.value,
      "MaxMarks" : maxgradeController.text,
      "OptionalSubjectGroupID": ""
    };

    var response = await NetworkManager.instance.getDio().post(Endpoints.addclasstest, data: input);
    print(response);
    if(response.data['result'] == "success"){
      titleController.clear();
      maxgradeController.clear();
      dateController.clear();
      await getclassTestData(refresh: true);
      // Get.back();
      Get.off(()=> ClassTestScreen());
    }

   // classtestresData.value = ClassTestResModel.fromJson(response.data);
    update();

  }


  // for publish the class test
  Future publishclassTest({required refresh, var classtestid }) async {
    var input = {
      "operation": "PublishClassTest",
      "ClassTestID" : classtestid
    };

    var response = await NetworkManager.instance.getDio().post(Endpoints.publishclasstest, data: input);
    print(response);
    if(response.data["result"] == "success"){
      await getclassTestData(refresh: true);
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

  void onRefresh() async {
    await getclassTestData(refresh: true);
    refreshController.refreshCompleted();
  }
  void onLoading() async {
    refreshController.loadComplete();
  }
}