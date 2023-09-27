import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import 'package:get_storage/get_storage.dart';
import 'package:staffapp/controller/dashboard_controller.dart';
import 'package:staffapp/views/app_screen/staff_dashboard_screen.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../helpers/app_manager.dart';
import '../helpers/app_snackbar.dart';
import '../helpers/endpoints.dart';
import '../helpers/network_manager.dart';
import '../models/staff_dashboard_response_model.dart';
import '../utils/stringconstant.dart';
import '../views/login_screen.dart';

class AuthController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  RxBool loading = false.obs;
  String? deviceToken = '';
  RefreshController refreshController = RefreshController(initialRefresh: false);
  // @override
  // onInit() async {
  //   super.onInit();
  //   if (AppManager.statusHelper.getLoginStatus) {
  //     studentListUpdate();
  //   }
  // }

  void onRefresh() async {
    await studentListUpdate();
    refreshController.refreshCompleted();
  }

  Future loginUser() async {
    loading(true);
    var input = {
      "operation": "Login",
      "user": {"UserName": userNameController.text,
        "Password": passwordController.text,
        "DeviceToken": deviceToken}
    };
    await NetworkManager.instance.getDio().post(Endpoints.login, data: input).then((response) async {
      if (response.data['result'] == 'success') {
        showProgress();
        final getBox = GetStorage();
        getBox.write(Constants.token, response.data['token']);
        getBox.write(Constants.userNameSaved, response.data['username']);
        AppManager.statusHelper.setLoginStatus(true);
        DashBoardController dashBoardController = Get.put(DashBoardController());
        NetworkManager.instance.stDATA = false;
        // var selectResponse = await NetworkManager.instance.getDio().post(Endpoints.staffdashoard, data: selectInput);
        // StaffDashboardResModel res = StaffDashboardResModel.fromJson(selectResponse.data);
        // storeStudentList(res);
        // NetworkManager.instance.stDATA = true;
        //getBox.write(Constants.stdata, response.data['token']);
        userNameController.clear();
        passwordController.clear();
        loading(false);
        // Navigator.of(Get.context!).pushAndRemoveUntil(MaterialPageRoute(
        //   builder: (_) => StaffDashboardScreen()
        //   //const LoginScreen()
        // ));
        Get.offAll(() => StaffDashboardScreen());
        hideProgress();
      } else {
        loading(false);
        AppSnackbar.showSnackbar("Error", "Login Failed", AlertType.error,
            position: SnackPosition.TOP, duration: const Duration(seconds: 2));
      }
    }).onError((dio.DioError error, stackTrace) async {
      loading(false);
      AppSnackbar.showSnackbar("Error", '${error.response?.data['message']}', AlertType.error);
    });
  }

  final getBox = GetStorage();
  // void storeStudentList(StaffDashboardResModel model) {
  //   getBox.write('StaffDataList', model.toJson());
  // }

  // StaffDashboardResModel restoreStudentListModel() {
  //   final map = getBox.read('StaffDataList') ?? {};
  //   return StaffDashboardResModel.fromJson(map);
  // }

  // void storeSelectedStudent(StaffData model) {
  //   getBox.write('StaffData', model.toJson());
  // }

  // StaffData restoreSelectedStudentModel() {
  //   final map = getBox.read('StaffData') ?? {};
  //   return StaffData.fromJson(map);
  // }

  studentListUpdate() async {
    var selectInput = {"operation": "StaffDashboard"};
    NetworkManager.instance.stDATA = false;
    var selectResponse = await NetworkManager.instance.getDio().post(Endpoints.staffdashoard, data: selectInput);
    StaffDashboardResModel res = StaffDashboardResModel.fromJson(selectResponse.data);
    // storeStudentList(res);
    NetworkManager.instance.stDATA = true;
    update();
  }

  signOut()  {
     GetStorage().erase();
    Get.offAll(() =>  LoginScreen());
  }
  void showProgress() {
    showDialog(
      context: Get.context!,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        backgroundColor: Colors.transparent,
        contentPadding: const EdgeInsets.symmetric(horizontal: 24),
        content: Container(
            color: Colors.transparent,
            height: 100,
            width: 100,
            alignment: Alignment.center,
            child: const CircularProgressIndicator()
          // valueColor: Animation(),

        ),
      ),
    );
  }

  void hideProgress() {
    Get.back();
  }
}
