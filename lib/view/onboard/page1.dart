import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../entitties/helpers/constants.dart';

class Page1 extends StatelessWidget {
  const Page1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      body: Container(
        height: Dimensions.height,
        width: Dimensions.width,
        color: Color(kLight.value),
        child: Stack(
                  children: [
                    Positioned(
                      left: 86.w, right: 86.32.w, top: 175.h,
                      child: Image.asset('assets/png/device.png',
                          width: 202.68.w, height: 407.26.h,
                      ),
                    ),
                    Positioned(
                      left: 46.w, right: 37.w, top: 213.44.h,
                      child: Image.asset('assets/png/illustration.png',
                          width: 292.w, height: 241.56.h,
                      ),
                    ),
                    Positioned(
                      top: 455.h,
                      child: Container(
                        width: Dimensions.width,
                        height: 357.h,
                        decoration: BoxDecoration(
                          color: Color(kLight.value),
                          ),
                        child: Padding(
                          padding: EdgeInsets.only(left: 44.w, right: 44.w, top: 46.h),
                          child: Column(
                            children: [
                              Text('Finance app the safest and most trusted',
                                textAlign: TextAlign.center,
                                style: appstyle(24.sp, Color(kDarkText.value), FontWeight.w600, -0.2.sp),),
                              SizedBox(height: 16.h,),
                              Text('Your finance work starts here. Our here to help you track and deal with speeding up your transactions.',
                                textAlign: TextAlign.center,
                                style: appstyle(14.sp, Color(kGreyText.value), FontWeight.w400, 0.3.sp),),
                            ],
                          ),
                        ),
                        ),
                      )
                  ],
                ),
      ),
    );
  }
}