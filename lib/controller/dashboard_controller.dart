import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../helpers/app_manager.dart';
import '../helpers/endpoints.dart';
import '../helpers/network_manager.dart';
import '../models/staff_dashboard_response_model.dart';

class DashBoardController extends GetxController {
  final GlobalKey<ScaffoldState> dashboardscaffoldEy = GlobalKey<ScaffoldState>();
  Rx<StaffDashboardResModel> dashboardData = StaffDashboardResModel().obs;
  RefreshController refreshController = RefreshController(initialRefresh: false);

  @override
  onInit() async {
    super.onInit();
    await getDashboarData();
    await studentListUpdate();
    // if (AppManager.statusHelper.getLoginStatus) {
    //   studentListUpdate();
    // }
  }

  void onRefresh() async {
    await studentListUpdate();
    await getDashboarData();
    refreshController.refreshCompleted();
  }

  Future getDashboarData() async {
    var selectInput = {"operation": "StaffDashboard"};
    NetworkManager.instance.stDATA = false;
    var selectResponse = await NetworkManager.instance.getDio().post(Endpoints.staffdashoard, data: selectInput);
    StaffDashboardResModel res = StaffDashboardResModel.fromJson(selectResponse.data);
    // storeStudentList(res);
    dashboardData.value = res;
    // NetworkManager.instance.stDATA = true;
    update();
  }

  final getBox = GetStorage();
  // void storeStudentList(StaffDashboardResModel model) {
  //   getBox.write('StudentList', model.toJson());
  // }
  //
  // StaffDashboardResModel restoreStudentListModel() {
  //   final map = getBox.read('StudentList') ?? {};
  //   return StaffDashboardResModel.fromJson(map);
  // }


  //for store subject incharge data
  void storeInchargeList(SubjectIncharge model) {
    getBox.write('SubjectIncharge', model.toJson());
  }

  SubjectIncharge restoreInchargeListModel() {
    final map = getBox.read('SubjectIncharge') ?? {};
    return SubjectIncharge.fromJson(map);
  }

  //for store class incharge data
  void storeclassInchargeList(ClassIncharge model) {
    getBox.write('ClassIncharge', model.toJson());
  }

  ClassIncharge restoreClassInchargeListModel() {
    final map = getBox.read('ClassIncharge') ?? {};
    return ClassIncharge.fromJson(map);
  }

  // for store staff data
  void storestaffList(StaffData model) {
    getBox.write('SelectStaffData', model.toJson());
  }

  StaffData restorestaffdataListModel() {
    final map = getBox.read('SelectStaffData') ?? {};
    return StaffData.fromJson(map);
  }

  void storeSelectedStudent(StaffData model) {
    getBox.write('SelectedStudent', model.toJson());
  }

  StaffData restoreSelectedStudentModel() {
    final map = getBox.read('SelectedStudent') ?? {};
    return StaffData.fromJson(map);
  }

  studentListUpdate() async {
    var selectInput = { "operation": "StaffDashboard"};
    NetworkManager.instance.stDATA = false;
    var selectResponse = await NetworkManager.instance.getDio().post(Endpoints.staffdashoard, data: selectInput);
    StaffDashboardResModel res = StaffDashboardResModel.fromJson(selectResponse.data);
    dashboardData.value = res;
    // storeStudentList(res);
    NetworkManager.instance.stDATA = true;
    update();
  }


  void onLoadings() async {
    refreshController.loadComplete();
  }
}
