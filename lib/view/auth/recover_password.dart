import 'package:apex/entitties/helpers/constants.dart';
import 'package:apex/view/auth/verify_identity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class RecoverPassword extends StatefulWidget {
  const RecoverPassword({super.key});

  @override
  State<RecoverPassword> createState() => _RecoverPasswordState();
}

class _RecoverPasswordState extends State<RecoverPassword> {

  final TextEditingController email = TextEditingController();

  @override
  void dispose() {
    email.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 79.71.h),
        child: Form(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
            Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset('assets/png/icon - illustration.png', height: 76.29.h, width: 90.2.w,),
              SizedBox(height: 24.h,),
              Text('Password Recovery', style: appstyle(24.sp, Color(kDarkText.value), FontWeight.w600, -0.2.sp),),
              SizedBox(height: 12.h,),
              Text('Enter your registered email below to receive password instructions',
                maxLines: 2,
                style: appstyle(16.sp, Color(kGreyText.value), FontWeight.w400, 0.3.sp),),
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
              SizedBox(height: 82.h,),
              CustomButton(
                  text: 'Send me email', onTap: (){
                    Get.to(()=> const VerifyIdentity());
              }, height: 56.h, width: 327.w
              ),
            ],
          )
        ),
      ),
    );
  }
}
