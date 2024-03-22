import 'dart:async';

import 'package:apex/entitties/helpers/constants.dart';
import 'package:apex/entitties/helpers/custom_loader.dart';
import 'package:apex/view/auth/create_account.dart';
import 'package:apex/view/auth/recover_password.dart';
import 'package:apex/view/auth/register.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_field_style.dart';
import 'package:otp_text_field/style.dart';
import 'package:provider/provider.dart';

import '../../data_source/api_clients.dart';
import '../../entitties/models/request/signup_req.dart';
import '../../entitties/models/request/verify_otp_req.dart';
import '../../entitties/providers/auth_providers.dart';


class VerifyOtp extends StatefulWidget {
  const VerifyOtp({super.key, required this.email});
  final String email;

  @override
  State<VerifyOtp> createState() => _VerifyOtpState();
}

class _VerifyOtpState extends State<VerifyOtp> {

  int start = 30;
  bool wait = false;
  bool buttonIsActive = false;
  String _pin = '';


  @override
  void initState() {
    startTimer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthNotifier>(
      builder: (BuildContext context, authNotifier, child) {
        return Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(56.h),
            child: const CustomAppBar(),
          ),
          body: !authNotifier.loader ?
          Padding(padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
            child: Form(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Verify i\'ts you', style: appstyle(24.sp, Color(kDarkText.value), FontWeight.w600, -0.2.sp),),
                      SizedBox(height: 8.h,),
                      Text('We send a code to ( *****@mail.com ). Enter it here to verify your identity', maxLines: 2, style: appstyle(16.sp, Color(kGreyText.value), FontWeight.w400, 0.3.sp),),
                    ],
                  ),
                  SizedBox(height: 32.h,),
                  otpField(),
                  SizedBox(height: 32.h,),
                  !wait ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Resend code', style: TextStyle(color: const Color(0xFF727272),
                          fontSize: 16.sp
                      ),),
                      Text(' $start secs',
                          style: TextStyle(color: const Color(0xFF727272),
                              fontSize: 16.sp
                          )),
                    ],
                  )
                      :
                  Align(
                    alignment: Alignment.center,
                    child: GestureDetector(
                      onTap: (){
                        startTimer();
                        setState(() {
                          start= 30;
                          wait= false;
                          SendCodeModel model = SendCodeModel(email: widget.email,);
                          String newModel = sendCodeModelToJson(model);
                          AuthHelper.sendCode(newModel).then((response){
                            if(response==true){
                              authNotifier.loader=false;
                              Get.snackbar('Email Token', code,
                                  backgroundColor: Color(kTeal.value),
                                  colorText: Color(kLight.value), icon: const Icon(Icons.add_alert)
                              );
                            } else{
                              authNotifier.loader=false;
                              Get.snackbar('Failed to send code', 'Please check email',
                                  backgroundColor: Color(kTeal.value),
                                  colorText: Color(kLight.value), icon: const Icon(Icons.add_alert)
                              );
                            }
                          });
                        });
                      },
                      child: Text('Resend code', style: TextStyle(color: Color(kTeal.value),
                          fontSize: 16.sp
                      ),),
                    ),
                  ),
                  SizedBox(height: 67.h,),
                  CustomButton(
                    color: buttonIsActive ? Color(kDarkText.value) : Color(kDarkText.value).withOpacity(0.7),
                    text: 'Confirm', onTap: (){
                    authNotifier.loader = true;
                    VerifyCodeModel model = VerifyCodeModel(email: widget.email, token: _pin, );
                    String newModel = verifyCodeModelToJson(model);

                    !buttonIsActive? null :

                    AuthHelper.verifyCode(newModel).then((response){
                      if(response==true){
                        authNotifier.loader = false;
                        Get.to(()=> Register(email: widget.email,));
                      } else{
                        authNotifier.loader = false;
                        Get.snackbar('Failed to verify code', 'Try again',
                            backgroundColor: Color(kTeal.value),
                            colorText: Color(kLight.value), icon: const Icon(Icons.add_alert)
                        );
                      }
                    });
                  }, height: 56.h, width: 327.w,
                  ),

                ],
              ),
            ),
          )
              : const CustomLoader()
        );
      },
    );
  }

  void startTimer (){
    const onSec = Duration(seconds: 1);
    Timer timer = Timer.periodic(onSec, (timer){
      if (start == 0){
        setState(() {
          timer.cancel();
          wait = true;
        });
      } else {
        setState(() {
          start--;
        });
      }
    });
  }

  Widget otpField (){
    return OTPTextField(
      length: 5,
      width: 56.w,
      fieldWidth: 45,
      keyboardType: TextInputType.number,
      otpFieldStyle: OtpFieldStyle(
        backgroundColor: const Color(0xFFF9FAFB),
        borderColor: Colors.transparent,
      ),
      outlineBorderRadius: 12.r,
      style: const TextStyle(
          fontSize: 18
      ),
      textFieldAlignment: MainAxisAlignment.spaceAround,
      fieldStyle: FieldStyle.box,
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
