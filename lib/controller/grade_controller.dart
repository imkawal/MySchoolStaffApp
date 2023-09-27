import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../helpers/endpoints.dart';
import '../helpers/network_manager.dart';
import '../models/grade_response_model.dart';

class GradeController extends GetxController {
  RefreshController refreshController = RefreshController(initialRefresh: false);
  Rx<GradeResponseModel> graderesData = GradeResponseModel().obs;

  // @override
  // Future<void> onInit() async {
  //   super.onInit();
  //   await getgradeData(refresh: true);
  // }

  Future getgradeData({required refresh, var classsectionidd, var subjecttypeid}) async {
    var input = {
      "operation": "ShowGrade",
      "ClassSectionID":classsectionidd,
      "SubjectTypeID":subjecttypeid
    };
    var response = await NetworkManager.instance.getDio().post(Endpoints.showgrade, data: input);
    graderesData.value = GradeResponseModel.fromJson(response.data);
    update();

  }

  void onRefresh() async {
    await getgradeData(refresh: true);
    refreshController.refreshCompleted();
  }
}