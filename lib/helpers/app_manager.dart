import 'package:get/get.dart';
import 'package:staffapp/controller/dashboard_controller.dart';
import 'package:staffapp/helpers/status_helper.dart';

import '../controller/auth_controller.dart';

class AppManager {
  static StatusHelper statusHelper = StatusHelper();
  static AuthController authController = Get.find<AuthController>();
  static DashBoardController dashController = Get.find<DashBoardController>();
}