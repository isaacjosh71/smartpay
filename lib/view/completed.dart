import 'package:apex/entitties/helpers/constants.dart';
import 'package:apex/view/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Completed extends StatelessWidget {
  const Completed({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 233.h),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset('assets/png/Group 162902.png',
          height: 134.33.h, width: 140.45.h,),
          SizedBox(height: 32.h,),
          Text('Congratulations, James', style: appstyle(24.sp, Color(kDarkText.value), FontWeight.w700, -0.2.sp),),
          SizedBox(height: 12.h,),
          Text('You’ve completed the onboarding you can start using',
            textAlign: TextAlign.center,
            style: appstyle(16.sp, Color(kGreyText.value), FontWeight.w400, 0.3.sp),),
          SizedBox(height: 32.h,),
          CustomButton(text: 'Get Started', onTap: () async {
            final SharedPreferences prefs = await SharedPreferences.getInstance();
            prefs.setBool('done', true);
            Navigator.pushAndRemoveUntil(
                context,
                PageTransition(
                    child: const DashBoard(),
                    type: PageTransitionType.leftToRightWithFade), (Route<dynamic> route) => false,);
          }, height: 56.h, width: 327.w,)
        ],
      ),
      ),
    );
  }
}
