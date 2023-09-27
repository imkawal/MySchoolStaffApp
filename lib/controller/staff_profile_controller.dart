import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../helpers/endpoints.dart';
import '../helpers/network_manager.dart';
import '../models/staff_profile_response_model.dart';

class StaffProfileController  extends GetxController{
  RefreshController refreshController = RefreshController(initialRefresh: false);
  Rx<StaffProfileResModel> staffprofileData = StaffProfileResModel().obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    await getStaffProfileData(refresh: true);
  }

  // Api get attendance
  Future getStaffProfileData({required refresh}) async {
    var input = {"operation": "StaffProfile"};
    var response = await NetworkManager.instance.getDio().post(Endpoints.staffprofile, data: input);
    staffprofileData.value = StaffProfileResModel.fromJson(response.data);
    update();

  }

  void onRefresh() async {
    await getStaffProfileData(refresh: true);
    refreshController.refreshCompleted();
  }

}