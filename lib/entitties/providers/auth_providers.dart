
import 'package:apex/entitties/helpers/constants.dart';
import 'package:apex/view/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../data_source/api_clients.dart';



class AuthNotifier extends ChangeNotifier {

  bool _obscureText = true;

  bool get obscureText => _obscureText;

  set obscureText(bool newState) {
    _obscureText = newState;
    notifyListeners();
  }

  bool _loader = false;

  bool get loader => _loader;

  set loader(bool newState){
    _loader = newState;
    notifyListeners();
  }

  login(String model, BuildContext context){
    AuthHelper.login(model).then((response){
      if(response==true){
        loader=false;
        Navigator.pushAndRemoveUntil(
          context,
          PageTransition(
              child: const DashBoard(),
              type: PageTransitionType.leftToRightWithFade), (Route<dynamic> route) => false,);
        // Get.off(()=> const DashBoard());
      } else{
        loader=false;
        Get.snackbar('Failed to login', 'Please check credentials',
            backgroundColor: Color(kTeal.value),
            colorText: Color(kLight.value), icon: const Icon(Icons.add_alert)
        );
      }
    });
  }

  getPref() async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    // entryPoint = prefs.getBool('entryPoint') ?? false;
    // loggedIn = prefs.getBool('loggedIn') ?? false;
    token = prefs.getString('token') ?? '';
  }
}
