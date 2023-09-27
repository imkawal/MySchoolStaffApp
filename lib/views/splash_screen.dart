import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:staffapp/views/login_screen.dart';

import '../controller/dashboard_controller.dart';
import '../helpers/app_manager.dart';
import '../utils/appcolors_theme.dart';
import 'app_screen/staff_dashboard_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (_) => AppManager.statusHelper.getLoginStatus ? StaffDashboardScreen() :  LoginScreen(),
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: AppColors.backgroundblue,
      body: Container(
        width: Get.width*0.999,
        child: Stack(
          //mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Container(
                width: Get.width*0.999,
                // decoration: BoxDecoration(
                //     boxShadow: [BoxShadow(color: Colors.white, offset: Offset(0, 0), blurRadius: 40, spreadRadius: 10)]),
                child: Image.asset('assets/images/Rectangle 531.png',fit: BoxFit.fitWidth,)),
            Container(
                width: Get.width*0.999,
                // decoration: BoxDecoration(
                //     boxShadow: [BoxShadow(color: Colors.white, offset: Offset(0, 0), blurRadius: 40, spreadRadius: 10)]),
                child: Image.asset('assets/images/Rectangle 532.png',fit: BoxFit.fitWidth,)),
            Padding(
              padding:  EdgeInsets.only(left: Get.width*0.185, top: Get.height*0.14),
              child: Container(
                width: Get.width*0.6,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/Ellipse 134.png"),
                      scale: 0.7
                    ),
                      //boxShadow: [BoxShadow(color: Colors.white, offset: Offset(0, 0), blurRadius: 40, spreadRadius: 10)]
                  ),
                  child: Image.asset('assets/images/schoollogo.png')),
            ),
            Padding(
              padding:  EdgeInsets.only(left: Get.width*0.25, top: Get.height*0.64),
              child: Container(
                  child: Image.asset('assets/images/Group 34.png',fit: BoxFit.fitWidth,)),
            ),
            Padding(
              padding:  EdgeInsets.only(left: Get.width*0.43, top: Get.height*0.78),
              child: Container(
                  child: CircularProgressIndicator()
              ),
            ),
            // SizedBox(
            //   height: Get.height * 0.062,
            // ),
            // SizedBox(
            //   width: Get.width * 0.5,
            //   child: Text(
            //     'My School Staff App',
            //     maxLines: 2,
            //     textAlign: TextAlign.center,
            //     style: TextStyle(fontSize: 36, fontWeight: FontWeight.w500, color: AppColors.white),
            //   ),
            // ),
            // SizedBox(
            //   height: Get.height * 0.26,
            // ),
            // SizedBox(
            //     child: Padding(
            //   padding: EdgeInsets.only(right: Get.width * 0.08, left: Get.width * 0.08),
            //   child: ClipRRect(
            //     borderRadius: BorderRadius.all(Radius.circular(10)),
            //     child: LinearProgressIndicator(
            //         backgroundColor: AppColors.yellow,
            //         valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            //         minHeight: Get.height * 0.009),
            //   ),
            // )),
          ],
        ),
      ),
    ));
  }
}
