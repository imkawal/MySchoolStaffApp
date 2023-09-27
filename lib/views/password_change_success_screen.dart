import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:staffapp/views/login_screen.dart';

import '../utils/app_button.dart';
import '../utils/appcolors_theme.dart';
import '../utils/appstrings.dart';

class PasswordChangeScreen extends StatelessWidget {
  const PasswordChangeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            child: Container(
              height: Get.height*0.99,
              width: Get.width*0.999,
              child: Stack(
                children: [
                  Positioned(
                      top: Get.height*0.78,
                      child: Image.asset('assets/images/lower_corner.png')),
                  Positioned(
                      left: Get.width*0.65,
                      child: Image.asset('assets/images/upper_corner.png')),
                  SizedBox(
                    child: Padding(
                      padding:  EdgeInsets.only(top: Get.height*0.2, left: Get.width*0.065,right: Get.width*0.12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: 90,
                            backgroundImage: AssetImage('assets/images/passwordcircle.png'),
                            child: Image.asset('assets/images/password.png',fit: BoxFit.fill,
                              height: Get.height*0.13,),
                          ),
                          SizedBox(
                            height: Get.height*0.04,
                          ),
                          Text('Create New Password',
                              style: TextStyle(fontSize: 23, fontWeight: FontWeight.w700, color: AppColors.black)),
                          SizedBox(
                            height: Get.height*0.02,
                          ),
                          Text('Your new Passeord must be different from previously used one',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: AppColors.black),),
                          // Text('Sign in Now',
                          //     style: TextStyle(fontSize: 22, fontWeight: FontWeight.w400, color: AppColors.black)),
                          SizedBox(
                            height: Get.height*0.06,
                          ),
                          AppButton(
                              buttonName: AppStrings.login,
                              onTap: (){
                                Get.to(()=> LoginScreen());
                              },
                              isIconShow: false,
                              height: Get.height*0.071,
                              fontSize: 18,
                              fontweight: FontWeight.w600,
                              width: Get.width* 0.65,
                              backgroundColor: AppColors.backgroundpurple,
                              //iconColor: AppColors.bluishBlack,
                              textColor: const Color(0xffFFFFFF)),

                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
    );
  }
}
