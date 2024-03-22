import 'package:apex/entitties/helpers/constants.dart';
import 'package:apex/view/auth/new_password.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class VerifyIdentity extends StatefulWidget {
  const VerifyIdentity({super.key});

  @override
  State<VerifyIdentity> createState() => _VerifyIdentityState();
}

class _VerifyIdentityState extends State<VerifyIdentity> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 84.h),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset('assets/png/icon - illustration (1).png', height: 77.23.h, width: 84.23.w,),
                SizedBox(height: 18.h,),
                Text('Verify your identity', style: appstyle(24.sp, Color(kDarkText.value), FontWeight.w600, -0.2.sp),),
                SizedBox(height: 12.h,),
                Text('Where would you like Smartpay to send your security code?',
                  maxLines: 2,
                  style: appstyle(16.sp, Color(kGreyText.value), FontWeight.w400, 0.3.sp),),
              ],
            ),
            SizedBox(height: 32.h,),
            Container(
              height: 88.h, width: 327.w,
              decoration: BoxDecoration(
                  color: Color(kTextField.value),
                  borderRadius: BorderRadius.all(Radius.circular(16.r))
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 21.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Image.asset('assets/png/check.png', height: 20.h, width: 20.h,),
                        SizedBox(width: 18.w,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Email', style: appstyle(16.sp, Color(kDarkText.value), FontWeight.w600, 0.3.sp),),
                            SizedBox(height: 4.h,),
                            Text('*******@mail.com', style: appstyle(12.sp, Color(kGreyText.value), FontWeight.w500, 0.3.sp),),
                          ],
                        )
                      ],
                    ),
                    Icon(Icons.mail_outline_rounded, size: 16.sp, color: const Color(0xFF9CA3AF),)
                  ],
                ),
              ),
            ),
            SizedBox(height: 315.h,),
            CustomButton(
              text: 'Continue', onTap: (){
                Get.to(()=> const NewPassword());
            }, height: 56.h, width: 327.w,
            )
          ],
        ),
      ),
    );
  }
}
