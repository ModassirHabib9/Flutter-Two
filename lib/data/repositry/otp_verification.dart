import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../utils/api_constant.dart';

//////////////////////--| OTP VERIFICATION  |--//////////////////////////////////////////
class OtpVerified_Provider with ChangeNotifier {
  bool _loading = false;
  bool get loading => _loading;
  setloading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future otp_code(BuildContext context, String resetCode) async {
    setloading(true);
    print('working');
    http.Response response = await http.post(
        Uri.parse(ApiConstants.BASE_URL + ApiConstants.VERIFIED_OTP),
        headers: {
          'authentication': '@',
          'Content-Type': 'application/x-www-form-urlencoded'
        },
        body: {
          "resetCode": resetCode,
        });
    setloading(true);
    print(response.statusCode);
    Map<String, dynamic> data = jsonDecode(response.body);
    String success = data["status"].toString();
    if (success == "success") {
      setloading(false);
      print('done');
      Progress(context, data["message"], Colors.green);
    } else {
      print("Sorry we have an error");
      setloading(false);
      print(response.statusCode);
      Progress(context, data["message"], Colors.red);
    }
    return response.body;
  }

  /// reset password
  Future reset_password(
      BuildContext context, String old_password, String password) async {
    setloading(true);
    print('working');
    // store auth token
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    print("reset password profile:  ${token}");
    // store auth token
    http.Response response = await http.post(
        Uri.parse(ApiConstants.BASE_URL + ApiConstants.EDIT_PROFILE),
        headers: {
          'authentication': '$token',
          'Content-Type': 'application/x-www-form-urlencoded'
        },
        body: {
          "old_password": old_password,
          "password": password,
        });
    setloading(true);

    Map<String, dynamic> data = jsonDecode(response.body);
    String success = data["status"].toString();
    if (success == "success") {
      setloading(false);
      print('done');
      Progress(context, data["message"], Colors.green);
    } else {
      setloading(false);
      print("Sorry we have an error");
      print(response.statusCode);
      Progress(context, data["message"], Colors.red);
    }
    return response.body;
  }
}

Progress(BuildContext context, String widget, Color color) {
  return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: color,
      duration: Duration(seconds: 2),
      behavior: SnackBarBehavior.floating,
      width: MediaQuery.of(context).size.width * 0.90,
      content: Text(widget,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
          ))));
}
