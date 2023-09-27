import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:staffapp/views/login_screen.dart';
import 'package:staffapp/views/password_change_success_screen.dart';

import '../utils/app_button.dart';
import '../utils/appcolors_theme.dart';
import '../utils/appstrings.dart';
import '../utils/apptext_field.dart';

class CreateNewPasswordScreen extends StatelessWidget {
  const CreateNewPasswordScreen({Key? key}) : super(key: key);

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
                          const Text('Create New \nPassword!',
                              style: TextStyle(fontSize: 34, fontWeight: FontWeight.w700, color: AppColors.welcomecolor)),
                          SizedBox(
                            height: Get.height*0.2,
                          ),
                          Text('Your password must be different from previously used one.',
                            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: AppColors.textcolor),),
                          // Text('Sign in Now',
                          //     style: TextStyle(fontSize: 22, fontWeight: FontWeight.w400, color: AppColors.black)),
                          SizedBox(
                            height: Get.height*0.02,
                          ),
                          AppTextField(
                            hintText: AppStrings.newpassword,
                            prefix: Icon(Icons.lock_open,color: Color(0xff005460),),
                            obscureText: true,
                            //controller: registercon.emailController,
                            // validator: validateEmail,
                          ),
                          SizedBox(
                            height: Get.height*0.04,
                          ),
                          AppTextField(
                            prefix: Icon(Icons.lock_open,color: Color(0xff005460),),
                            hintText: AppStrings.repeatpassword,
                            obscureText: true,
                            //controller: registercon.emailController,
                            // validator: validateEmail,
                          ),
                          SizedBox(
                            height: Get.height*0.06,
                          ),
                          AppButton(
                              buttonName: AppStrings.submit,
                              onTap: (){
                                showDialog(
                                    context: context,
                                    builder: (_) => AlertDialog(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      actionsAlignment: MainAxisAlignment.center,
                                      alignment: Alignment.center,
                                      actions: [
                                        Center(
                                          child: Column(
                                            children: [
                                              SizedBox(height: 20,),
                                              Image.asset("assets/images/key.png"),
                                              SizedBox(height: 20,),
                                              Text('Your Password Changed \nSuccessfully!',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: AppColors.textcolor)),
                                              SizedBox(height: 13,),
                                              SizedBox(
                                                width: Get.width*0.6,
                                                child: Text('You’ve changed your password. Proceed to login into your account.',
                                                    maxLines: 2,
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: AppColors.textcolor)),
                                              ),
                                              SizedBox(height: 20,),
                                              GestureDetector(
                                                onTap: () {
                                                  Get.off(()=> LoginScreen());
                                                },
                                                child: Container(
                                                  width: Get.width*0.6,
                                                  height: Get.width * 0.13,
                                                  decoration: ShapeDecoration(
                                                    color: AppColors.darkblue,
                                                    shape: RoundedRectangleBorder(
                                                        borderRadius: BorderRadius.circular(13.0)
                                                    ),
                                                  ),
                                                  alignment: Alignment.center,
                                                  child: Text(
                                                    "Login",
                                                    style: TextStyle(
                                                      fontSize: Get.width * 0.045,
                                                      color: AppColors.white,
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(height: 15,),
                                            ],
                                          ),
                                        ),

                                      ],
                                    )
                                );
                                //Get.to(()=> PasswordChangeScreen());
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
                  ),
                ],
              ),
            ),
          ),
        )
    );
  }
}
