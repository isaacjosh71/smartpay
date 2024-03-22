
import 'dart:async';
import 'package:apex/view/onboard/onboarding.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../entitties/helpers/constants.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}
class _SplashState extends State<SplashScreen> with TickerProviderStateMixin {

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )
      ..repeat(reverse: true);
    _offsetAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(1.5, 0.0),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.elasticIn,
    ));
    Timer(const Duration(seconds: 3), ()=>Get.off(()=> const OnBoardingScreen()));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  late final AnimationController _controller;
  late final Animation<Offset> _offsetAnimation;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(kLight.value),
      body:
      SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            color: Color(kLight.value),
          ),
          child: SlideTransition(
            position: _offsetAnimation,
            child: Center(
              child: Image.asset('assets/png/logo.png',
                height: 130.h,
                width: 148.w,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
