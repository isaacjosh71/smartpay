
import 'package:apex/view/auth/log_in_pin.dart';
import 'package:apex/view/auth/sign_in.dart';
import 'package:apex/view/dashboard.dart';
import 'package:apex/view/onboard/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'entitties/helpers/constants.dart';
import 'entitties/providers/auth_providers.dart';
import 'entitties/providers/onboard_provider.dart';

//new user
Widget defaultHome = const SplashScreen();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //if user completed registration
  bool? done = false;
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  done = prefs.getBool('done');
  if(done == true){
    defaultHome = const LogPin();
  }

  //using Provider state management
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => OnBoardNotifier()),
    ChangeNotifierProvider(create: (context) => AuthNotifier()),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return ScreenUtilInit(
      //screen responsiveness
        useInheritedMediaQuery: true,
        designSize: Size(MediaQuery.of(context).size.width, MediaQuery.of(context).size.height),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return GetMaterialApp(
            //Get state management for easy navigation and styling
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              scaffoldBackgroundColor: Color(kLight.value),
              iconTheme: IconThemeData(color: Color(kDark.value)),
              primarySwatch: Colors.grey,
              useMaterial3: true,
            ),
            home: defaultHome,
          );
        });
  }
}
