import 'package:dio/dio.dart'as dio;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../helpers/app_manager.dart';
import '../helpers/endpoints.dart';
import '../helpers/network_manager.dart';
import '../models/student_assignment_response_model.dart';
import '../utils/appcolors_theme.dart';
import '../views/app_screen/assignment_screen.dart';

class AssignmentController extends GetxController{
  RefreshController refreshController = RefreshController(initialRefresh: false);
  Rx<StudentAssignmentResModel> stuassignmentresData = StudentAssignmentResModel().obs;
  TextEditingController nameController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController lastsubmitdateController = TextEditingController();
  TextEditingController assignmentdesController = TextEditingController();
  TextEditingController videoController = TextEditingController();
  RxString images = "".obs;
  RxString classsubjectidContoller = "".obs;
  RxList<StudentAssignmentData> filterdata = <StudentAssignmentData>[].obs;
  RxBool isBlock = false.obs;


  @override
  Future<void> onInit() async {
    super.onInit();
    await getStudentAssignmentData(refresh: true);
  }

  //get student assignment data
  Future getStudentAssignmentData({required refresh}) async {
    var input = {"operation": "StudentAssignment"};
    var response = await NetworkManager.instance.getDio().post(Endpoints.studentassignment, data: input);
    stuassignmentresData.value = StudentAssignmentResModel.fromJson(response.data);
    filterdata.value = stuassignmentresData.value.data!;
    update();
  }

  // add student assignment
  Future addstudentAssignment({required refresh, var classsectionid,
    var classsubectid, var fileimage, var audioimage, var pdfimage, var video, imagename, var subj}) async {
    String? fileName;
    fileName != null? fileimage != null ? fileimage.path.split('/').last: null: null;
    String? audioName;
    audioName != null?  audioimage != null ? audioimage.path.split('/').last: null: null;
    String? pddfName;
    pddfName != null ? pdfimage != null ? pdfimage.path.split('/').last: null: null;
    var input = dio.FormData.fromMap({
      "operation":"StudentAddAssignment",
      "ClassSectionID":classsectionid,
       "Description": assignmentdesController.text,
       "Video": videoController.text,
      "FileImage": fileimage != null ? await dio.MultipartFile.fromFile(fileimage.path, filename: fileName): null,
      "AudioImage": audioimage != null ? await dio.MultipartFile.fromFile(audioimage.path, filename: audioName) : null,
      "PDFImage":pdfimage != null ? await dio.MultipartFile.fromFile(pdfimage.path, filename: pddfName): null,
       "Name": nameController.text,
       "Date": dateController.text,
       "LastSubmitDate": lastsubmitdateController.text,
       "ClassSubjectID": classsubjectidContoller.value.isEmpty? classsubectid == null?subj:classsubectid:classsubjectidContoller.value
    });
    var response = await NetworkManager.instance.getDio().post(Endpoints.addstudentassignment, data: input);
    print(response);
    if(response.data['result'] == "success"){
      Fluttertoast.showToast(
          msg: "Saved",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: AppColors.notfuntextcolor,
          textColor: Colors.white,
          fontSize: 16.0
      );
      assignmentdesController.clear();
      nameController.clear();
      dateController.clear();
      lastsubmitdateController.clear();
      await getStudentAssignmentData(refresh: true);
   // Get.back();
      //Get.off(()=> AssignmentScreen());
    }
    update();
  }
  void onRefresh() async {
    await getStudentAssignmentData(refresh: true);
    await addstudentAssignment(refresh: true);
    refreshController.refreshCompleted();
  }
}