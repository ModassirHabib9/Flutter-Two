import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../utils/api_constant.dart';

class IdentityVerification extends ChangeNotifier {
  Future identity_verification(
    BuildContext context,
    String identity_type,
    String identity_number,
    String image,
  ) async {
    print('working');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    print("===> Identity Verification  ${token}");
    http.Response response = await http.post(
        Uri.parse(ApiConstants.BASE_URL + ApiConstants.IDENTITY_VERIFICATION),
        headers: {
          'authentication': '$token',
          'Content-Type': 'application/x-www-form-urlencoded'
        },
        body: {
          "identity_type": identity_type,
          "identity_number": identity_number,
          "image": image,
        });
    print(response.statusCode);
    Map<String, dynamic> data = jsonDecode(response.body);
    String success = data["statusCode"].toString();
    if (success == "208") {
      // Get.to(MyNavigationBar());
      print('done');
      Progress(context, Text(data["message"]), Colors.green);
    } else {
      print("Sorry we have an error");
      print(response.statusCode);
      Progress(context, Text(data["message"]), Colors.red);
    }
    return response.body;
  }

  //// =======================================> ////

  Future address_verification(
    BuildContext context,
    String image,
  ) async {
    print('working');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    print("===> address Verification ${token}");
    http.Response response = await http.post(
        Uri.parse(ApiConstants.BASE_URL + ApiConstants.ADDRESS_VERIFICATION),
        headers: {
          'authentication': '$token',
          'Content-Type': 'application/x-www-form-urlencoded'
        },
        body: {
          "image": image,
        });
    print(response.statusCode);
    Map<String, dynamic> data = jsonDecode(response.body);
    String success = data["statusCode"].toString();
    if (success == "208") {
      // Get.to(MyNavigationBar());
      print('done');
      Progress(context, Text(data["message"]), Colors.green);
    } else {
      print("Sorry we have an error");
      print(response.statusCode);
      Progress(context, Text(data["message"]), Colors.red);
    }
    return response.body;
  }
}

Progress(BuildContext context, Widget widget, Color color) {
  return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: color,
      duration: Duration(seconds: 2),
      behavior: SnackBarBehavior.floating,
      width: MediaQuery.of(context).size.width * 0.90,
      content: widget));
}
