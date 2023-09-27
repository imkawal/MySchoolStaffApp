import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../helpers/endpoints.dart';
import '../helpers/network_manager.dart';

class StudentTimeTableController extends GetxController{
  RefreshController refreshController = RefreshController(initialRefresh: false);
  //Rx<ShowExamResultResModel> examresultData = ShowExamResultResModel().obs;

  Future getStudentTimeTableData({required refresh}) async {
    var input = {
      "operation": "Timetable",
      "StartLimit": "0",
      "EndLimit": "30"
    };
    var timetableresponse = await NetworkManager.instance.getDio().post(Endpoints.studenttimeTable, data: input);
    //examresultData.value = ShowExamResultResModel.fromJson(examresponse.data);
    update();

  }

}