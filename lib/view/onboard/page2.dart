import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../entitties/helpers/constants.dart';

class Page2 extends StatelessWidget {
  const Page2({super.key});

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
                      left: 86.w, right: 86.32.w, top: 172.h,
                      child: Image.asset('assets/png/image.png',
                        width: 202.68.w, height: 407.26.h,
                      ),
                    ),
                    Positioned(
                      left: 44.w, right: 64.w, top: 279.h,
                      child: Image.asset('assets/png/illustration2.png',
                        width: 267.w, height: 187.35.h,
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
                          padding: EdgeInsets.only(left: 51.w, right: 51.w, top: 41.h),
                          child: Column(
                            children: [
                              Text('The fastest transaction process only here',
                                textAlign: TextAlign.center,
                                style: appstyle(24.sp, Color(kDarkText.value), FontWeight.w600, -0.2.sp),),
                              SizedBox(height: 16.h,),
                              Text('Get easy to pay all your bills with just a few steps. Paying your bills become fast and efficient.',
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