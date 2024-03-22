import 'package:apex/entitties/helpers/constants.dart';
import 'package:apex/entitties/helpers/custom_loader.dart';
import 'package:apex/entitties/providers/auth_providers.dart';
import 'package:apex/view/auth/sign_in.dart';
import 'package:apex/view/auth/verify_identity.dart';
import 'package:apex/view/auth/verify_otp.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../data_source/api_clients.dart';
import '../../entitties/models/request/signup_req.dart';

class CreateAccount extends StatefulWidget {
  const CreateAccount({super.key});

  @override
  State<CreateAccount> createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {

  final TextEditingController email = TextEditingController();
  bool buttonIsActive = false; //button checker

  @override
  void dispose() {
    email.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthNotifier>(builder: (context,authNotifier,child){
        return Scaffold(
          appBar: PreferredSize(preferredSize: Size.fromHeight(56.h), child: const CustomAppBar()),
          body:
          !authNotifier.loader ?
          Padding(padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 22.h),
            child: Form(
              child: ListView(
                children: [
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                          textAlign: TextAlign.start,
                          text: TextSpan(
                            children: [
                              TextSpan(text: 'Create a ',
                                style: appstyle(24.sp, Color(kDarkText.value), FontWeight.w600, -0.2.sp),),
                              TextSpan(text: 'Smartpay',
                                style: appstyle(24.sp, Color(kTeal.value), FontWeight.w600, -0.2.sp),),
                            ],
                          ),),
                        Text('account', style: appstyle(24.sp, Color(kDarkText.value), FontWeight.w600, -0.2.sp),),
                      ]),
                  SizedBox(height: 32.h,),
                  CustomTextField(controller: email,
                      hintText: 'Email',
                      keyboard: TextInputType.emailAddress,
                      validator: (email){
                        if(email!.isEmpty || !email.contains('@')){
                          return 'Please enter email';
                        } return null;
                      },// validator
                      onChanged: (value){
                        setState((){
                          buttonIsActive = value!.isNotEmpty?true:false;
                        });
                        return null;
                      }
                  ),
                  SizedBox(height: 24.h,),
                  CustomButton(
                    color: buttonIsActive ? Color(kDarkText.value) : Color(kDarkText.value).withOpacity(0.7),
                    text: 'Sign Up', onTap: (){

                    authNotifier.loader=true;
                    SendCodeModel model = SendCodeModel(email: email.text,);
                    String newModel = sendCodeModelToJson(model);

                    !buttonIsActive ? null :

                    AuthHelper.sendCode(newModel).then((response){
                      if(response==true){
                        //if response is true, commence a loading state till next page
                        authNotifier.loader=false;
                        Get.to(()=> VerifyOtp(email: email.text,));
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
                    },
                    height: 56.h, width: 327.w,
                  ),
                  SizedBox(height: 32.h,),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(height: 0.3.h, width: 142.w, color: const Color(0xFFE5E7EB),),
                      Text('OR', style: appstyle(14.sp, const Color(0xFF6B7280), FontWeight.w400, 0.3.sp),),
                      Container(height: 0.3.h, width: 142.w, color: const Color(0xFFE5E7EB),),
                    ],
                  ),
                  SizedBox(height: 24.h,),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(height: 56.h, width: 155.h,
                        decoration: BoxDecoration(
                            color: Color(kLight.value),
                            border: Border.all(width: 1.sp, color: const Color(0xFFE5E7EB)),
                            borderRadius: BorderRadius.all(Radius.circular(16.r))
                        ),
                        child: Center(
                          child: Image.asset('assets/png/search 1.png',
                            height: 23.18.h, width: 23.18.h,
                          ),
                        ),
                      ),
                      SizedBox(width: 16.w,),
                      Container(height: 56.h, width: 155.h,
                        decoration: BoxDecoration(
                            color: Color(kLight.value),
                            border: Border.all(width: 1.sp, color: const Color(0xFFE5E7EB)),
                            borderRadius: BorderRadius.all(Radius.circular(16.r))
                        ),
                        child: Center(
                          child: Image.asset('assets/png/Apple_logo_black 1.png',
                            height: 23.18.h, width: 23.18.h,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 117.h,),
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      children: [
                        TextSpan(text: 'Already have an account?',
                          style: appstyle(16.sp, Color(kDarkText.value), FontWeight.w600, 0.3.sp),),
                        TextSpan(text: ' Sign In',
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Get.to(()=> const SignIn());
                            },
                          style: appstyle(16.sp, Color(kTeal.value), FontWeight.w600, 0.3.sp),),
                      ],
                    ),),

                ],
              ),
            ),
          )
              : const CustomLoader(),
        );
      },
    );
  }
}
