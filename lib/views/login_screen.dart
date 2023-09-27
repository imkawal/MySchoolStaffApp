import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:get/get.dart';
import 'package:staffapp/utils/app_button.dart';
import 'package:staffapp/views/forgot_password_screen.dart';
import 'package:staffapp/views/app_screen/staff_dashboard_screen.dart';
import '../controller/auth_controller.dart';
import '../controller/dashboard_controller.dart';
import '../utils/animated_login_button.dart';
import '../utils/appcolors_theme.dart';
import '../utils/appstrings.dart';
import '../utils/apptext_field.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController nameController = TextEditingController();

  TextEditingController passwordController = TextEditingController();
  int _toggleValue = 0;
  bool initialPosition = true;
  List<String> values = [
    '', ''
  ];
  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   DashBoardController dashBoardController = Get.put(DashBoardController());
  // }
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final AuthController con = Get.put(AuthController(), permanent: true);
    Size screenSize = MediaQuery.of(context).size;
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
                      padding:  EdgeInsets.only(top: Get.height*0.1, left: Get.width*0.065,right: Get.width*0.12),
                      child: Form(
                        key: con.formKey,
                        child: Column(
                         crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Welcome \nBack!',
                                style: TextStyle(fontSize: 32, fontWeight: FontWeight.w700, color: AppColors.welcomecolor)),
                            SizedBox(
                              height: Get.height*0.2,
                            ),
                            Padding(
                              padding:  EdgeInsets.only(left: Get.width*0.04,),
                              child: const Text('Login',
                                  style: TextStyle(fontSize: 19, fontWeight: FontWeight.w700, color: AppColors.textcolor)),
                            ),
                            SizedBox(
                              height: 6,
                            ),
                            Padding(
                              padding:  EdgeInsets.only(left: Get.width*0.04,),
                              child: const Text('Enter your email and password',
                                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: AppColors.textcolor)),
                            ),
                            Padding(
                              padding:  EdgeInsets.only(left: Get.width*0.04,),
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 7,
                                  ),
                                  AppTextField(
                                    // title:  Text(AppStrings.username,
                                    //   style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: AppColors.black),),
                                    hintText: AppStrings.username,
                                    controller: con.userNameController,
                                    prefix: Icon(Icons.person_outline_outlined,color: Color(0xff005460)),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'This user doesn’t exist.';
                                      }
                                      return null;
                                    },
                                  ),
                                  SizedBox(
                                    height: Get.height*0.015,
                                  ),
                                   AppTextField(
                                    // title:  Text(AppStrings.password,
                                    //   style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: AppColors.black),),
                                    hintText: AppStrings.password,
                                    obscureText: true,
                                     prefix: Icon(Icons.lock_open,color: Color(0xff005460),),
                                    controller: con.passwordController,
                                     validator: (value) {
                                       if (value == null || value.isEmpty) {
                                         return 'Wrong password.';
                                       }
                                       return null;
                                     },
                                  ),
                                  SizedBox(height: 8,),
                                  Align(
                                    alignment: Alignment.topRight,
                                    child: GestureDetector(
                                      onTap: (){
                                        Get.to(()=> const ForgotPasswordScreen());
                                      },
                                      child: const Text(
                                          AppStrings.forgotpassword,
                                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: AppColors.textcolor)
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: Get.height*0.04,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      if (con.formKey.currentState!.validate()) {
                                        Loader.show(context,
                                            progressIndicator: const CircularProgressIndicator());
                                        Future.delayed(const Duration(seconds: 3), () {
                                          Loader.hide();
                                          //Navigator.pop(context);
                                          con.loginUser();
                                          print("Loader is being shown after hide ${Loader.isShown}");
                                        });

                                      }
                                    },
                                    child: Container(
                                      width: screenSize.width * 0.8,
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
                                  SizedBox(
                                    height: Get.height*0.06,
                                  ),

                                ],
                              ),
                            ),

                          ],
                        ),
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

