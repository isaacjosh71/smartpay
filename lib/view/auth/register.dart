import 'package:apex/entitties/helpers/constants.dart';
import 'package:apex/entitties/helpers/custom_loader.dart';
import 'package:apex/entitties/models/request/register_req.dart';
import 'package:apex/view/auth/set_pin.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../data_source/api_clients.dart';
import '../../entitties/providers/auth_providers.dart';

class Register extends StatefulWidget {
  const Register({super.key, required this.email});
  final String email;

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final TextEditingController fullName = TextEditingController();
  final TextEditingController userName = TextEditingController();
  final TextEditingController password = TextEditingController();
  bool buttonIsActive = false;
  String _selectedCountry = 'Country';


  @override
  void dispose() {
    userName.dispose();
    fullName.dispose();
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
        body: !authNotifier.loader ?
        Padding(padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
          child: Form(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Hey there! tell us a bit', style: appstyle(24.sp, Color(kDarkText.value), FontWeight.w600, -0.2.sp),),
                      RichText(
                        textAlign: TextAlign.start,
                        text: TextSpan(
                          children: [
                            TextSpan(text: 'about ',
                              style: appstyle(24.sp, Color(kDarkText.value), FontWeight.w600, -0.2.sp),),
                            TextSpan(text: 'yourself',
                              style: appstyle(24.sp, Color(kTeal.value), FontWeight.w600, -0.2.sp),),
                          ],
                        ),),
                    ]),
                SizedBox(height: 32.h,),
                CustomTextField(controller: fullName,
                  hintText: 'Full name',
                  validator: (name){
                    if(name!.isEmpty){
                      return 'Please enter name';
                    } return null;
                  },
                ),
                SizedBox(height: 16.h,),
                CustomTextField(controller: userName,
                  hintText: 'Username',
                  keyboard: TextInputType.text,
                  validator: (username){
                    if(username!.isEmpty){
                      return 'Please enter username';
                    } return null;
                  },
                ),
                SizedBox(height: 16.h,),
                CustomTextField(
                  hintText: _selectedCountry,
                  validator: (country){
                    if(country!.isEmpty){
                      return 'Please select country';
                    } return null;
                  },
                  suffixIcon: GestureDetector(
                      onTap: (){
                        showCountryPicker(
                          context: context,
                          countryListTheme: CountryListThemeData(
                            flagSize: 23.sp,
                            backgroundColor: Colors.white,
                            textStyle: TextStyle(fontSize: 18.sp, color: Color(kDarkText.value)),
                            bottomSheetHeight: 617.h, // Optional. Country list modal height
                            //Optional. Sets the border radius for the bottomsheet.
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(40.r),
                              topRight: Radius.circular(40.r),
                            ),
                            //Optional. Styles the search field.
                            inputDecoration: InputDecoration(
                              labelText: 'Search',
                              hintText: 'Start typing to search',
                              prefixIcon: const Icon(Icons.search),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: const Color(0xFF8C98A8).withOpacity(0.2),
                                ),
                              ),
                            ),
                          ),
                          onSelect: (Country country){
                            setState((){_selectedCountry = country.countryCode;});
                          }
                        );
                      },
                      child: const Icon(Icons.keyboard_arrow_down_rounded)),
                ),
                SizedBox(height: 16.h,),
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
                    onChanged: (value){
                      setState((){
                        buttonIsActive = value!.isNotEmpty?true:false;
                      });
                      return null;
                    }
                ),
                SizedBox(height: 24.h,),
                CustomButton(
                  text: 'Continue', onTap: (){
                  RegisterModel model = RegisterModel(email: widget.email, password: password.text, device_name: 'web',
                    full_name: fullName.text, username: userName.text, country: _selectedCountry,);
                  String newModel = registerModelToJson(model);
                  print(newModel);

                  !buttonIsActive ? null :

                  AuthHelper.register(newModel).then((response){
                    if(response==true){
                      print(response);
                      authNotifier.loader = false;
                      Get.to(()=> const SetPin());
                    } else{
                      authNotifier.loader = false;
                      Get.snackbar('Failed to register', 'Please check credentials',
                          backgroundColor: Color(kTeal.value),
                          colorText: Color(kLight.value), icon: const Icon(Icons.add_alert)
                      );
                    }
                  });
                }, height: 56.h, width: 327.w,
                  color: buttonIsActive ? Color(kDarkText.value) : Color(kDarkText.value).withOpacity(0.7),
                ),
              ],
            ),
          ),
        )
            : const CustomLoader(),
      );
    },
    );
  }
}
