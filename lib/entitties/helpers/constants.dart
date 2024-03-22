import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

//responsive height n width
class Dimensions{
  static double height = Get.context!.height;
  static double width = Get.context!.width;
}

//colors
const kDark = Color(0xFF000000);
const kLight = Color(0xFFFFFFFF);
const kTeal = Color(0xFF0A6375);
const kTextField = Color(0xFFF9FAFB);
const kGreyText = Color(0xFF6B7280);
const kDarkText = Color(0xFF111827);
const customColor = Color(0xFFE5E7EB);


//
class ReusableText extends StatelessWidget {
  const ReusableText({super.key, required this.text, required this.style});

  final String text;
  final TextStyle style;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: 1,
      softWrap: false,
      textAlign: TextAlign.left,
      overflow: TextOverflow.fade,
      style: style,
    );
  }
}


//style
TextStyle appstyle(double size, Color color, FontWeight fw, double ls) {
  return TextStyle(fontSize: size.sp, color: color, fontWeight: fw, fontFamily: 'SF Pro Display', letterSpacing: ls);
}

//app bar
class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key, this.actions, this.color, this.text});
  final String? text;
  final Color? color;
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      iconTheme: const IconThemeData(),
      backgroundColor: Color(kLight.value),
      elevation: 0,
      automaticallyImplyLeading: false,
      leading: GestureDetector(
        onTap: (){
          Get.back();
        },
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(12.r)),
                border: Border.all(width: 1.sp, color: const Color(0xFFE5E7EB))
            ),
            child: Center(child: Icon(Icons.arrow_back_ios, size: 14.sp, color: Color(kDarkText.value),)),
          ),
        ),
      ),
    );
  }
}

class CustomTextField extends StatelessWidget {
  const CustomTextField({super.key, this.controller, required this.hintText, this.keyboard, this.validator, this.suffixIcon, this.onEditingComplete, this.obscureText, this.onChanged, this.readOnly});
  final TextEditingController? controller;
  final String hintText;
  final TextInputType? keyboard;
  final String? Function(String?)? validator;
  final String? Function(String?)? onChanged;
  final Widget? suffixIcon;
  final void Function()? onEditingComplete;
  final bool? obscureText;
  final bool? readOnly;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56.h, width: 327.w,
      decoration: BoxDecoration(
          color: Color(kTextField.value),
          borderRadius: BorderRadius.all(Radius.circular(16.r))
      ),
      child: TextFormField(
        keyboardType: keyboard,
        obscureText: obscureText??false,
        readOnly: readOnly??false,
        decoration: InputDecoration(
            hintText: hintText,
            suffixIcon: suffixIcon,
            hintStyle: appstyle(16.sp, const Color(0xFF9CA3AF), FontWeight.w400, 0.3.sp),
            errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.zero,
                borderSide: BorderSide(color: Colors.transparent, width: 0.w)
            ),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(16.r)),
                borderSide: BorderSide(color: const Color(0xff2FA2B9), width: 1.w)
            ),
            focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.zero,
                borderSide: BorderSide(color: Colors.transparent, width: 0.w)
            ),
            disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.zero,
                borderSide: BorderSide(color: Colors.transparent, width: 0.w)
            ),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.zero,
                borderSide: BorderSide(color: Colors.transparent, width: 0.w)
            ),
            border: InputBorder.none
        ),
        controller: controller,
        cursorHeight: 25.h,
        validator: validator,
          onChanged: onChanged,
      ),
    );
  }
}


class CustomButton extends StatelessWidget {
  const CustomButton({super.key, required this.text, this.onTap, required this.height, required this.width, this.color});
  final String text;
  final double height;
  final double width;
  final Color? color;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height, width: width,
        decoration: BoxDecoration(
            color: color??Color(kDarkText.value),
            borderRadius: BorderRadius.all(Radius.circular(16.r))
        ),
        child: Center(
          child: Text(text, style: appstyle(16.sp, Color(kLight.value), FontWeight.w600, 0.3.sp),),
        ),
      ),
    );
  }
}

Widget buildStyleContainer(BuildContext context, Widget child,){
  return Container(
    decoration: BoxDecoration(
        image: const DecorationImage(image: AssetImage('assets/png/m.png'),
            fit: BoxFit.contain, opacity: 0.35
        ), borderRadius: BorderRadius.all(Radius.circular(9.r))
    ),
    child: child,
  );
}

class ShimmerWidget extends StatelessWidget {
  const ShimmerWidget.rectangular({
    Key? key, required this.height, required this.width,
  }) : super(key: key);
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) => Shimmer.fromColors(
    baseColor: Colors.grey[300]!,
    highlightColor: Colors.grey[100]!,
    child: Container(
        width: width,
        height: height,
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
        decoration: BoxDecoration(
            color: const Color(0x95D1CECE),
            borderRadius: BorderRadius.all(Radius.circular(16.r))
        )
    ),
  );
}

String token = '';
String code = '';
String pinCode = '';
String name = '';

