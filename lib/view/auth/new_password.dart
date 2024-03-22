import 'package:apex/entitties/helpers/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import '../../entitties/providers/auth_providers.dart';

class NewPassword extends StatefulWidget {
  const NewPassword({super.key});

  @override
  State<NewPassword> createState() => _NewPasswordState();
}

class _NewPasswordState extends State<NewPassword> {

  final TextEditingController rePassword = TextEditingController();
  final TextEditingController password = TextEditingController();

  @override
  void dispose() {
    rePassword.dispose();
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
        body: Padding(padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
          child: Form(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Create New Password', style: appstyle(24.sp, Color(kDarkText.value), FontWeight.w600, -0.2.sp),),
                    SizedBox(height: 12.h,),
                    Text('Please, enter a new password below different from the previous password',
                      maxLines: 2,
                      style: appstyle(16.sp, Color(kGreyText.value), FontWeight.w400, 0.3.sp),),
                    ]),
                    SizedBox(height: 32.h,),
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
                    SizedBox(height: 16.h,),
                    CustomTextField(controller: rePassword,
                      hintText: 'Confirm password',
                      obscureText: authNotifier.obscureText,
                      keyboard: TextInputType.text,
                      suffixIcon: GestureDetector(
                        onTap: (){authNotifier.obscureText=!authNotifier.obscureText;},
                        child: Icon(
                            authNotifier.obscureText ? Icons.visibility : Icons.visibility_off
                        ),
                      ),
                      validator: (password){
                        if(password!.isEmpty || password.length < 6){
                          return 'Please enter password';
                        } return null;
                      },
                    ),
                    SizedBox(height: 331.h,),
                    Align(
                        alignment: Alignment.center,
                        child:
                            CustomButton(
                                text: 'Create new password', onTap: (){}, height: 56.h, width: 327.w
                            ),
                    ),

                  ],
                ),
          ),
        ),
      );
    },
    );
  }
}
