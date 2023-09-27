import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../controller/dashboard_controller.dart';
import '../../controller/staff_profile_controller.dart';
import '../../utils/appcolors_theme.dart';
import '../../utils/drawer_widget.dart';

class StaffProfileScreen extends StatefulWidget {
  StaffProfileScreen({Key? key}) : super(key: key);

  @override
  State<StaffProfileScreen> createState() => _StaffProfileScreenState();
}

class _StaffProfileScreenState extends State<StaffProfileScreen> {
  DashBoardController dashBoardController = Get.find<DashBoardController>();
  StaffProfileController staffProfileController = Get.put(StaffProfileController());
  @override
  void initState() {
    super.initState();
    staffProfileController.getStaffProfileData(refresh: true);
  }
  void onRefresh() async {
    try {
      await staffProfileController.getStaffProfileData(refresh: true);
      refreshController.refreshCompleted();
    } catch (e) {
      refreshController.refreshCompleted();
    }
  }
  // void onRefresh() async {
  //   await staffProfileController.getStaffProfileData(refresh: true);
  //   refreshController.refreshCompleted();
  // }

  final GlobalKey<ScaffoldState> profilescaffoldEy = GlobalKey<ScaffoldState>();
  RefreshController refreshController = RefreshController(initialRefresh: false);
  void onLoading() async {
    await staffProfileController.getStaffProfileData(refresh: true);
    refreshController.loadComplete();
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: profilescaffoldEy,
        drawer:  DrawerElement(),
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: AppColors.darkblue,
          leading: IconButton(
              onPressed: () {
                profilescaffoldEy.currentState!.openDrawer();
                Future.delayed(const Duration(seconds: 9), () {
                  profilescaffoldEy.currentState!.closeDrawer();
                });

              },
              icon: const Icon(
                Icons.menu,
                color: AppColors.white,
              )),
          title: const Text(
            'Profile',
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: AppColors.white),
          ),
        ),
        body: GetBuilder<StaffProfileController>(
            //init: Get.put(StaffProfileController()),
            //global: false,
            builder: (staffprofileController) {
              return staffprofileController.staffprofileData.value.data == null
                  ? const Center(child: CircularProgressIndicator())
                  : SmartRefresher(
                physics:  BouncingScrollPhysics(),
                controller: refreshController,
                onRefresh: () => onRefresh(),
                onLoading: () => onLoading(),
                    child: SingleChildScrollView(
                        child: Padding(
                          padding:  EdgeInsets.only(left: Get.width*0.05, right: Get.width*0.05),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(height: Get.height*0.03,),
                              SizedBox(
                                height: Get.height*0.24,
                                //color: Colors.grey,
                                child: Stack(
                                  children: [
                                    Center(
                                      child: CircleAvatar(
                                        radius: 65,
                                        backgroundImage: NetworkImage(staffprofileController.staffprofileData.value.data?.first.photo??""),
                                      ),
                                    ),
                                    Positioned(
                                      top: Get.height*0.16,
                                        left: Get.width*0.27,
                                        child: CircleAvatar(
                                          radius: 23,
                                          child: Icon(Icons.camera_alt),
                                        )),
                                  ],
                                ),
                              ),

                              SizedBox(height: Get.height*0.06,),
                              Text('Personal Information',
                              style: TextStyle(color: AppColors.black, fontWeight: FontWeight.w900,
                              fontSize: 22),),
                              SizedBox(height: Get.height*0.04,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Name ',
                                    style: TextStyle(color: AppColors.black, fontWeight: FontWeight.w400,
                                        fontSize: 18),),
                                  Text('${staffprofileController.staffprofileData.value.data?.first.name}',
                                    style: TextStyle(color: AppColors.black, fontWeight: FontWeight.w900,
                                        fontSize: 19),)
                                ],
                              ),
                              SizedBox(height: Get.height*0.01,),
                              Divider(thickness: 1,),
                              SizedBox(height: Get.height*0.01,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Phone no. ',
                                    style: TextStyle(color: AppColors.black, fontWeight: FontWeight.w400,
                                        fontSize: 18),),
                                  Text('${staffprofileController.staffprofileData.value.data?.first.phoneNumber}',
                                    style: TextStyle(color: AppColors.black, fontWeight: FontWeight.w900,
                                        fontSize: 19),)
                                ],
                              ),

                              SizedBox(height: Get.height*0.01,),
                              Divider(thickness: 1,),
                              SizedBox(height: Get.height*0.01,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Gender',
                                    style: TextStyle(color: AppColors.black, fontWeight: FontWeight.w400,
                                        fontSize: 18),),
                                  Text('${staffprofileController.staffprofileData.value.data?[0].gender??""}',
                                    style: TextStyle(color: AppColors.black, fontWeight: FontWeight.w900,
                                        fontSize: 19),)
                                ],
                              ),

                              SizedBox(height: Get.height*0.01,),
                              Divider(thickness: 1,),
                              SizedBox(height: Get.height*0.01,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('SpouseName',
                                    style: TextStyle(color: AppColors.black, fontWeight: FontWeight.w400,
                                        fontSize: 18),),
                                  Text('${staffprofileController.staffprofileData.value.data?.first.spouseName}',
                                    style: TextStyle(color: AppColors.black, fontWeight: FontWeight.w900,
                                        fontSize: 19),)
                                ],
                              ),

                              SizedBox(height: Get.height*0.01,),
                              Divider(thickness: 1,),
                              SizedBox(height: Get.height*0.01,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('FatherName',
                                    style: TextStyle(color: AppColors.black, fontWeight: FontWeight.w400,
                                        fontSize: 18),),
                                  Text('${staffprofileController.staffprofileData.value.data?.first.fatherName}',
                                    style: TextStyle(color: AppColors.black, fontWeight: FontWeight.w900,
                                        fontSize: 19),)
                                ],
                              ),

                              SizedBox(height: Get.height*0.01,),
                              Divider(thickness: 1,),
                              SizedBox(height: Get.height*0.01,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('StaffPosition',
                                    style: TextStyle(color: AppColors.black, fontWeight: FontWeight.w400,
                                        fontSize: 18),),
                                  Text('${staffprofileController.staffprofileData.value.data?.first.staffPosition}',
                                    style: TextStyle(color: AppColors.black, fontWeight: FontWeight.w900,
                                        fontSize: 19),)
                                ],
                              ),

                              SizedBox(height: Get.height*0.01,),
                              Divider(thickness: 1,),
                              SizedBox(height: Get.height*0.01,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('StaffType',
                                    style: TextStyle(color: AppColors.black, fontWeight: FontWeight.w400,
                                        fontSize: 18),),
                                  Text('${staffprofileController.staffprofileData.value.data?.first.staffType}',
                                    style: TextStyle(color: AppColors.black, fontWeight: FontWeight.w900,
                                        fontSize: 19),)
                                ],
                              ),
                              SizedBox(height: Get.height*0.01,),
                              Divider(thickness: 1,),
                              SizedBox(height: Get.height*0.01,),
                            ],
                          ),
                        ),
                      ),
                  );
            }),
      ),
    );
  }
}
