import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/app_button.dart';
import '../utils/appcolors_theme.dart';
import '../utils/appstrings.dart';
import '../utils/apptext_field.dart';
import 'create_new_password_screen.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

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
                  Container(
                      width: Get.width*0.999,
                      child: Image.asset('assets/images/logindesign.png',
                        fit: BoxFit.fill,)),
                  SizedBox(
                    child: Padding(
                      padding:  EdgeInsets.only(top: Get.height*0.1, left: Get.width*0.065,right: Get.width*0.1),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Forgot \nPassword?',
                              style: TextStyle(fontSize: 32, fontWeight: FontWeight.w700, color: AppColors.welcomecolor)),
                          SizedBox(
                            height: Get.height*0.2,
                          ),
                          Padding(
                            padding:  EdgeInsets.only(left: Get.width*0.046),
                            child: Text('If you need help to reset your password, we can help you by sending a link to reset it. ',
                            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: AppColors.textcolor),),
                          ),
                          SizedBox(
                            height: 12
                          ),
                          // Text('Sign in Now',
                          //     style: TextStyle(fontSize: 22, fontWeight: FontWeight.w400, color: AppColors.black)),
                          Padding(
                            padding:  EdgeInsets.only(left: Get.width*0.04,),
                            child: Column(
                              children: [
                                // SizedBox(
                                //   height: Get.height*0.04,
                                // ),
                                 AppTextField(
                                  // title:  Text(AppStrings.emailid,
                                  //   style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: AppColors.black),),
                                  hintText: AppStrings.emailid,
                                   prefix: Icon(Icons.email_outlined,color: Color(0xff005460)),
                                  //controller: registercon.emailController,
                                  // validator: validateEmail,
                                ),
                                SizedBox(
                                  height: Get.height*0.06,
                                ),
                                AppButton(
                                    buttonName: AppStrings.send,
                                    onTap: (){
                                      Get.to(()=> const CreateNewPasswordScreen());
                                    },
                                    isIconShow: false,
                                    height: Get.height*0.076,
                                    fontSize: 18,
                                    fontweight: FontWeight.w600,
                                    width: Get.width* 0.7,
                                    backgroundColor: AppColors.darkblue,
                                    //iconColor: AppColors.bluishBlack,
                                    textColor: const Color(0xffFFFFFF)),
                              ],
                            ),
                          ),

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


