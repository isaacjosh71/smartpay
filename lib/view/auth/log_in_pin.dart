import 'dart:async';

import 'package:apex/entitties/helpers/constants.dart';
import 'package:apex/view/auth/create_account.dart';
import 'package:apex/view/auth/recover_password.dart';
import 'package:apex/view/auth/register.dart';
import 'package:apex/view/auth/sign_in.dart';
import 'package:apex/view/completed.dart';
import 'package:apex/view/dashboard.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_field_style.dart';
import 'package:otp_text_field/style.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';


class LogPin extends StatefulWidget {
  const LogPin({super.key});

  @override
  State<LogPin> createState() => _LogPinState();
}

class _LogPinState extends State<LogPin> {

  bool buttonIsActive = false;
  String _pin = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
          backgroundColor: Colors.white,
          actions: [
            GestureDetector(
              onTap: () async{
                final SharedPreferences prefs = await SharedPreferences.getInstance();
                await prefs.setBool('done', false);
                await prefs.remove('token');
                Get.off(()=> const SignIn());
              },
              child: Padding(
                padding: EdgeInsets.only(right: 10.w),
                child: Text('Log Out',
                  style: appstyle(16.sp, const Color(0xFF2FA2B9), FontWeight.w600, 0.3.sp),),
              ),
            ),
          ]
      ),
      body: Padding(padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
        child: Form(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Log in your PIN code', style: appstyle(24.sp, Color(kDarkText.value), FontWeight.w600, -0.2.sp),),
                  SizedBox(height: 8.h,),
                  Text('We use state-of-the-art security measures to protect your information at all times', maxLines: 2, style: appstyle(16.sp, Color(kGreyText.value), FontWeight.w400, 0.3.sp),),
                ],
              ),
              SizedBox(height: 32.h,),
              otpField(),
              SizedBox(height: 123.h,),
              CustomButton(
                color: buttonIsActive ? Color(kDarkText.value) : Color(kDarkText.value).withOpacity(0.7),
                text: 'Continue', onTap: () async {
                final SharedPreferences prefs = await SharedPreferences.getInstance();
                pinCode = prefs.getString('pinCode') ?? '';
                print('pinCode is $pinCode');

                if(pinCode == _pin){
                  !buttonIsActive ? null :  Get.off(()=> const DashBoard());
                } else {
                  !buttonIsActive? null :
                  Get.snackbar('Pin incorrect', 'Input your correct pin',
                      backgroundColor: Color(kTeal.value),
                      colorText: Color(kLight.value), icon: const Icon(Icons.add_alert)
                  );
                }
              }, height: 56.h, width: 327.w,
              ),

            ],
          ),
        ),
      ),
    );
  }

  Widget otpField (){
    return OTPTextField(
      length: 5,
      width: 56.w,
      fieldWidth: 45,
      otpFieldStyle: OtpFieldStyle(
        backgroundColor: Color(kLight.value),
        borderColor: Colors.transparent,
      ),
      style: const TextStyle(
          fontSize: 18
      ),
      keyboardType: TextInputType.number,
      textFieldAlignment: MainAxisAlignment.spaceAround,
      fieldStyle: FieldStyle.underline,
      onCompleted: (pin) {
        print("Completed: " + pin);
        setState(() {
          (_pin = pin);
          buttonIsActive = _pin.isNotEmpty?true:false;
        });
      },
    );
  }

}
