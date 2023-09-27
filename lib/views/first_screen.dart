import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'splash_screen.dart';
import '../utils/appcolors_theme.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({Key? key}) : super(key: key);

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 1), () {
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (_) => const SplashScreen()));
    });
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.backgroundblue,
    //     body: Center(
    //       child: Container(
    //           decoration: BoxDecoration(
    //               boxShadow: [BoxShadow(color: Colors.white, offset: Offset(0, 0), blurRadius: 40, spreadRadius: 10)]),
    //           //child: Image.asset('assets/images/logo.png')
    // ),
    //     ),
        // Container(
        //   height: Get.height*0.999,
        //   width: Get.width*0.999,
        //   child: Image.asset('assets/images/firstscreen.png', fit: BoxFit.fill,),
        // ),
      ),
    );
  }
}
