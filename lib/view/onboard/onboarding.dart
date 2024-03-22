import 'package:apex/entitties/helpers/constants.dart';
import 'package:apex/view/auth/create_account.dart';
import 'package:apex/view/onboard/page1.dart';
import 'package:apex/view/onboard/page2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../entitties/providers/onboard_provider.dart';


class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  PageController pageController = PageController();

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Consumer<OnBoardNotifier>(
          builder: (context, onBoardNotifier, child){
            return Stack(
              children: [
                PageView(
                  controller: pageController,
                  physics: const AlwaysScrollableScrollPhysics(),
                  onPageChanged: (page){
                    onBoardNotifier.isLastPage = page == 1;
                  },
                  children: const [
                    Page1(),
                    Page2(),
                  ],
                ),
                Positioned(
                    top: 658.h,
                    left: 0, right: 0,
                    child: Center(
                      child: SmoothPageIndicator(
                        controller: pageController,
                        count: 2,
                        effect: WormEffect(
                            dotHeight: 10.h, dotWidth: 12.w, spacing: 12.w,
                            dotColor: const Color(0xFFE5E7EB), activeDotColor: Color(kDarkText.value)
                        ),
                      ),)),
                Positioned(
                  top: 698.h, left: 44.w, right: 44.w,
                    child: Align(
                      alignment: Alignment.center,
                      child: CustomButton(
                          onTap: () async {
                            final SharedPreferences prefs = await SharedPreferences.getInstance();
                            prefs.setBool('entryPoint', true);
                            Get.to(()=> const CreateAccount());
                          },
                          text: 'Get Started', height: 56.h, width: 287.h)
                )),
                    Positioned(
                      top: 68.h, right: 24.w,
                      child: GestureDetector(
                        onTap: (){
                          Get.to(()=> const CreateAccount());
                        },
                        child: Text('Skip',
                          style: appstyle(16.sp, const Color(0xFF2FA2B9), FontWeight.w600, 0.3.sp),),
                      ),),

              ],
            );
          },
        )
    );
  }
}