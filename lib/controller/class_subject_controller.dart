import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../helpers/endpoints.dart';
import '../helpers/network_manager.dart';
import '../models/class_subject_response_model.dart';

class ClassSubjectController extends GetxController{
  RefreshController refreshController = RefreshController(initialRefresh: false);
  Rx<ClassSubjectResModel> classsuubjectresData = ClassSubjectResModel().obs;
  RxBool isBlock = false.obs;


  Future getClassSubjectData({required refresh, var classectionid}) async {
    isBlock.value = true;
    var input = {
      "operation": "ClassSubjects",
      "ClassID" : classectionid};
    var response =
    await NetworkManager.instance.getDio().post(Endpoints.classsubject, data: input);
    classsuubjectresData.value = ClassSubjectResModel.fromJson(response.data);
    isBlock.value = false;
    update();

  }

  void onRefresh() async {
    await getClassSubjectData(refresh: true);
    refreshController.refreshCompleted();
  }
}