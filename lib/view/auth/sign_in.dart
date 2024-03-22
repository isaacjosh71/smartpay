import 'package:apex/entitties/helpers/constants.dart';
import 'package:apex/entitties/helpers/custom_loader.dart';
import 'package:apex/view/auth/create_account.dart';
import 'package:apex/view/auth/recover_password.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../entitties/models/request/login_req.dart';
import '../../entitties/providers/auth_providers.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final String device = 'phone';

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthNotifier>(builder: (context,authNotifier,child){
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
                    Text('Hi There!👋', style: appstyle(24.sp, Color(kDarkText.value), FontWeight.w600, -0.2.sp),),
                    SizedBox(height: 8.h,),
                    Text('Welcome back, Sign in to your account', style: appstyle(16.sp, Color(kGreyText.value), FontWeight.w400, 0.3.sp),),
                    ]),
                    SizedBox(height: 32.h,),
                    CustomTextField(controller: email,
                      hintText: 'Email',
                      keyboard: TextInputType.emailAddress,
                      validator: (email){
                        if(email!.isEmpty || !email.contains('@')){
                          return 'Please enter email';
                        } return null;
                      },
                    ),
                    SizedBox(height: 16.h,),
                    CustomTextField(controller: password,
                      hintText: 'Password',
                      obscureText: authNotifier.obscureText,
                      keyboard: TextInputType.text,
                      suffixIcon: GestureDetector(
                        onTap: (){authNotifier.obscureText=!authNotifier.obscureText;},
                        child: Icon(
                            authNotifier.obscureText ? Icons.visibility_off : Icons.visibility
                        ),
                      ),
                      validator: (password){
                        if(password!.isEmpty || password.length < 6){
                          return 'Please enter password';
                        } return null;
                      },
                    ),
                    SizedBox(height: 24.h,),
                    GestureDetector(
                        onTap: (){
                          Get.to(()=> const RecoverPassword());
                        },
                        child: Text('Forgot Password?', style: appstyle(16.sp, Color(kTeal.value), FontWeight.w600, 0.3.sp),)),
                    SizedBox(height: 24.h,),
                    CustomButton(
                        text: 'Sign In', onTap: (){
                      authNotifier.loader = true;
                      LoginModel model = LoginModel(email: email.text, password: password.text, device: device);
                      String newModel = loginModelToJson(model);
                      print(newModel);
                      authNotifier.login(newModel, context);
                    }, height: 56.h, width: 327.w,
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
                    SizedBox(height: 138.h,),
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        children: [
                          TextSpan(text: 'Don\'t have an account?',
                            style: appstyle(16.sp, Color(kDarkText.value), FontWeight.w600, 0.3.sp),),
                          TextSpan(text: ' Sign Up',
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Get.to(()=> const CreateAccount());
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
