import 'dart:async';

import 'package:apex/entitties/helpers/constants.dart';
import 'package:apex/view/auth/create_account.dart';
import 'package:apex/view/auth/recover_password.dart';
import 'package:apex/view/auth/register.dart';
import 'package:apex/view/completed.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_field_style.dart';
import 'package:otp_text_field/style.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';


class SetPin extends StatefulWidget {
  const SetPin({super.key});

  @override
  State<SetPin> createState() => _SetPinState();
}

class _SetPinState extends State<SetPin> {

  bool buttonIsActive = false;
  String _pin = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(56.h),
        child: const CustomAppBar(),
      ),
      body: Padding(padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
        child: Form(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Set your PIN code', style: appstyle(24.sp, Color(kDarkText.value), FontWeight.w600, -0.2.sp),),
                  SizedBox(height: 8.h,),
                  Text('We use state-of-the-art security measures to protect your information at all times', maxLines: 2, style: appstyle(16.sp, Color(kGreyText.value), FontWeight.w400, 0.3.sp),),
                ],
              ),
              SizedBox(height: 32.h,),
              otpField(),
              SizedBox(height: 123.h,),
              CustomButton(
                color: buttonIsActive ? Color(kDarkText.value) : Color(kDarkText.value).withOpacity(0.7),
                text: 'Create Pin', onTap: () async{
                final SharedPreferences prefs = await SharedPreferences.getInstance();
                await prefs.setString('pinCode', _pin);

                !buttonIsActive? null : Get.off(()=> const Completed());
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
