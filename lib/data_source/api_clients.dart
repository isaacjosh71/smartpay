import 'package:apex/data_source/url_configs.dart';
import 'package:apex/entitties/models/response/dashboard_res.dart';
import 'package:apex/entitties/models/response/register_res.dart';
import 'package:apex/entitties/models/response/verify_code_response.dart';
import 'package:http/http.dart' as https;
import 'package:shared_preferences/shared_preferences.dart';
import '../entitties/helpers/constants.dart';
import '../entitties/models/response/login_res.dart';
import '../entitties/models/response/signup_res.dart';

class AuthHelper {
  static var client = https.Client();

  //getEmailToken POST
  static Future<bool> sendCode(String model) async{
    try{
      Map<String, String> requestHeaders = {
        'Content-Type':'application/json'
      };
      var url = Uri.https(Config.apiUrl, Config.getEmailToken);
      print(url);

      var response = await client.post(url, headers: requestHeaders, body: model);
      if(response.statusCode == 200){
        var user = signupResponseModelFromJson(response.body);
        print('emailCode: ${user.data!.token}');
        code = user.data!.token;
        print('Successful Registration');
        return true;
      } else {return false;}
    } catch(e){
      return false;
    }
  }

  //login POST
  static Future<bool> login(String model) async{
    Map<String, String> requestHeaders = {
      'Content-Type':'application/json'
    };
    var url = Uri.https(Config.apiUrl, Config.login);
    print(url);

    var response = await client.post(url, headers: requestHeaders, body: model);
    if(response.statusCode == 200){
      print('Successful Login');
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      var user = logInResponseModelFromJson(response.body);
      await prefs.setBool('loggedIn', true);
      await prefs.setString('token', user.data!.token);
      await prefs.setString('fullName', user.data!.user!.fullName!);
      await prefs.setString('username', user.data!.user!.username!);
      await prefs.setString('country', user.data!.user!.country!);
      await prefs.setString('email', user.data!.user!.email!);
      return true;
    } else {return false;}
  }

  //verifyOTP POST
  static Future<bool> verifyCode(String model) async{
    Map<String, String> requestHeaders = {
      'Content-Type':'application/json'
    };
    var url = Uri.https(Config.apiUrl, Config.verifyEmailToken);
    print(url);

    var response = await client.post(url, headers: requestHeaders, body: model);
    if(response.statusCode == 200){
      var user = verifyCodeResponseFromJson(response.body);
      print('verified email: ${user.data!.email}');
      print('Successful verify');
      return true;
    } else {return false;}
  }

  //register POST
  static Future<bool> register(String model) async{
    Map<String, String> requestHeaders = {
      'Content-Type':'application/json'
    };

    var url = Uri.https(Config.apiUrl, Config.register);
    print(url);

    var response = await client.post(url, headers: requestHeaders, body: model);
    if(response.statusCode == 200){
      print('Successful register');
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      var user = registerResponseFromJson(response.body);
      await prefs.setBool('loggedIn', true);
      await prefs.setString('token', user.data!.token);
      await prefs.setString('fullName', user.data!.user!.fullName!);
      await prefs.setString('username', user.data!.user!.username!);
      await prefs.setString('country', user.data!.user!.country!);
      await prefs.setString('email', user.data!.user!.email!);
      return true;
    } else {return false;}
  }

  //dashboard GET
  static Future<DashboardResponse> getSecret() async{
    final SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString('token');

    if (token==null){throw  Exception('Authentication token not found');}

    Map<String, String> requestHeaders = {
      'Content-Type':'application/json',
      'authorization':'Bearer $token',
    };
    try{
      var url = Uri.https(Config.apiUrl, Config.dashboard);
      print(url);

      var response = await client.get(url, headers: requestHeaders);
      if(response.statusCode == 200){
        var secret = dashboardResponseFromJson(response.body);
        return secret;
      } else {throw Exception('Failed to load profile');}
    } catch (e){throw Exception('Failed to load profile $e');}
  }

}