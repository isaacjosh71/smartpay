import 'dart:io';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:apex/entitties/providers/auth_providers.dart';
import 'package:apex/view/auth/log_in_pin.dart';
import 'package:apex/view/auth/set_pin.dart';
import 'package:apex/view/auth/sign_in.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data_source/api_clients.dart';
import '../entitties/helpers/constants.dart';
import '../entitties/models/response/dashboard_res.dart';


class DashBoard extends StatefulWidget {
  const DashBoard({super.key});

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {


  late Future<DashboardResponse> getMessage;
  DashboardResponse? message;

  getSecretMessage(){
    getMessage = AuthHelper.getSecret();
  }

  @override
  void initState(){
    super.initState();
    getSecretMessage();
  }

  Future refresh() async{
    getMessage = AuthHelper.getSecret();
  }


  @override
  Widget build(BuildContext context) {
    var authNotifier = Provider.of<AuthNotifier>(context);
    authNotifier.getPref();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          Padding(
            padding: EdgeInsets.all(12.h),
            child: GestureDetector(
                onTap: () async{
                  final SharedPreferences prefs = await SharedPreferences.getInstance();
                  await prefs.setBool('loggedIn', false);
                  // await prefs.remove('token');
                  Get.off(()=> const LogPin());
                },
                child:
                Icon(Icons.logout_rounded, size: 22.sp, color: Color(kDarkText.value),)
            ),
          )
        ],
      ),
      body: RefreshIndicator(
        onRefresh: refresh,
        child: buildStyleContainer(
          context,
            Padding(padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 25.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  AnimatedTextKit(
                    animatedTexts: [
                      WavyAnimatedText(
                          'Secret Message Revealed!',
                          textAlign: TextAlign.justify,
                          textStyle: appstyle(24.sp, Color(kDarkText.value), FontWeight.w500, 0.3.sp),
                      ),
                    ],
                    isRepeatingAnimation: false,
                  ),
                  SizedBox(height: 50.h,),
                  Align(
                    alignment: Alignment.center,
                    child: SizedBox(
                      height: 300.h, width: 310.w,
                      child: FutureBuilder(
                        future: getMessage,
                        builder: (context, snapshot) {
                          if(snapshot.connectionState == ConnectionState.waiting){
                            return buildPopularShimmer();
                          } else if(snapshot.hasError){
                            return Text('Error: ${snapshot.error}');
                          }else{
                            message = snapshot.data;
                            return Container(
                                width: 300,
                                height: 310,
                                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                                decoration: BoxDecoration(
                                    color: const Color(0xFFF3F4F6),
                                    borderRadius: BorderRadius.all(Radius.circular(16.r)),
                                    border: Border.all(
                                      color: Colors.teal, // Border color
                                      width: 2.0, // Border width
                                      style: BorderStyle.solid, // Border style
                                    )
                                ),
                              child: Center(
                                child: Text(message!.data!.secret,
                                  textAlign: TextAlign.center,
                                  style: appstyle(18.sp, Color(kTeal.value), FontWeight.w600, 0.3.sp),),
                              ),
                            );
                          }
                        },
                      ),
                    ),
                  )
                ],
              ),
            )
        ),
      ),
    );
  }

  Widget buildPopularShimmer()=> ShimmerWidget.rectangular(height: 300.h, width: 310.w);
}