import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'controller/auth_controller.dart';
import 'controller/dashboard_controller.dart';
import 'views/first_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Get.put(AuthController(), permanent: true);
    // Get.put(DashBoardController());
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'MySchool Staff App',
        theme: ThemeData(
          primarySwatch: Colors.cyan,
        ),
        home: FirstScreen()
        //const SplashScreen(),
        );
  }
}
