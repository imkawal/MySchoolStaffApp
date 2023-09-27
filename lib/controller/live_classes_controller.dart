import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../helpers/endpoints.dart';
import '../helpers/network_manager.dart';
import '../models/live_class_response_model.dart';
import '../utils/appcolors_theme.dart';
import '../views/app_screen/live_classes_screen.dart';

class LiveClassController extends GetxController{
  RefreshController refreshController = RefreshController(initialRefresh: false);
  Rx<LiveClassResModel> liveclasData = LiveClassResModel().obs;
  TextEditingController headdingController = TextEditingController();
  TextEditingController startdateController = TextEditingController();
  TextEditingController durationController = TextEditingController();
  TextEditingController linkController = TextEditingController();
  TextEditingController timecon = TextEditingController();
  RxString dateController = "".obs;
  RxString timeController = "".obs;
  RxString subectidd = "".obs;
  RxBool isBlock = false.obs;

  Future<void> onInit() async {
    super.onInit();
    await getLiveClassData(refresh: true);
  }

  // Api get attendance
  Future getLiveClassData({required refresh}) async {
    var input = {"operation": "LiveClasses"};
    var response = await NetworkManager.instance.getDio().post(Endpoints.liveclass, data: input);
    liveclasData.value = LiveClassResModel.fromJson(response.data);
    update();

  }

  Future addLiveClassData({required refresh, var classsectionid, var classsubjectid, var subj}) async {
    var starttime = "${startdateController.text} ${timecon.text}";
    var input = {
      "operation": "AddLiveClasses",
      "Heading" : headdingController.text,
      "StartTime": starttime,
      "ClassSectionID": classsectionid,
      "ClassSubjectID": subectidd.value.isEmpty?classsubjectid == null?subj:classsubjectid:subectidd.value,
      "Duration" : durationController.text,
      "Link": linkController.text,
      "Navigate" : linkController.text};
    var response = await NetworkManager.instance.getDio().post(Endpoints.addliveclass, data: input);
    if(response.data['result'] == "success"){
      Fluttertoast.showToast(
          msg: "Created",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: AppColors.notfuntextcolor,
          textColor: Colors.white,
          fontSize: 16.0
      );
      headdingController.clear();
      startdateController.clear();
      durationController.clear();
      linkController.clear();
      timecon.clear();
      await getLiveClassData(refresh: true);
      //Get.back();
     // Get.to(()=> LiveClassesScreen());
    }

   // liveclasData.value = LiveClassResModel.fromJson(response.data);
    update();

  }

  void onRefresh() async {
    await getLiveClassData(refresh: true);
    refreshController.refreshCompleted();
  }
}