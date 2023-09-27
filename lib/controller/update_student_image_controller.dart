import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../helpers/endpoints.dart';
import '../helpers/network_manager.dart';
import 'package:dio/dio.dart'as dio;

class UpdateStudentImageController extends GetxController{
  RefreshController refreshController = RefreshController(initialRefresh: false);


  Future updatestudentprofile({required refresh,  image, var studentid}) async {
    String fileName = image.path.split('/').last;
    var input = dio.FormData.fromMap({
      "operation" : "UpdateStudentImage",
      "StudentID" : studentid,
      "Image": await dio.MultipartFile.fromFile(image.path, filename: fileName),
    });

    var response = await NetworkManager.instance.getDio().post(Endpoints.updatestudentimage, data: input);
    print(response);
    update();

  }

  void onRefresh() async {
    await updatestudentprofile(refresh: true);
    refreshController.refreshCompleted();
  }
}