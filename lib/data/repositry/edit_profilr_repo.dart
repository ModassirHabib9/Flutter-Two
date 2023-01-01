import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/api_constant.dart';

///////////////////////////////////////////////////////////////////////
class EditProfile_Provider with ChangeNotifier {
  bool _loading = false;
  bool get loading => _loading;
  setloading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future editeProfile(
      BuildContext context,
      String full_name,
      String phone,
      String email,
      // String password,
      // String old_password,
      String country,
      String state,
      String city,
      String image) async {
    setloading(true);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    print("===> Profile ${token}");
    print('working');
    http.Response response = await http.post(
        Uri.parse(ApiConstants.BASE_URL + ApiConstants.EDIT_PROFILE),
        headers: {
          'authentication': "$token",
          'Content-Type': 'application/x-www-form-urlencoded'
        },
        body: {
          "full_name": full_name,
          "email": email,
          'phone': phone,
          // "password": password,
          // "old_password": old_password,
          "country": country,
          "state": state,
          "city": city,
          "image": "http://wecoin.pk/weCoinApp/uploads/${image}",
        });
    print("===> Profile ${full_name + country + image}");
    print("====Response ${response}");
    setloading(false);
    print(response.statusCode);
    Map<String, dynamic> data = jsonDecode(response.body);
    String success = data["status"].toString();
    if (success == "success") {
      setloading(false);
      // Get.to(MyNavigationBar());
      print('done');
      Progress(context, Text(data["message"]), Colors.green);
    } else {
      print("Sorry we have an error");
      setloading(false);
      print(response.statusCode);
      Progress(context, Text(data["message"]), Colors.red);
    }

    return response.body;
  }
}

Saveuserid(String id) async {
  final prefs = await SharedPreferences.getInstance();
  prefs.setString('userid', id);
}

Progress(BuildContext context, Widget widget, Color color) {
  return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: color,
      duration: Duration(seconds: 2),
      behavior: SnackBarBehavior.floating,
      width: MediaQuery.of(context).size.width * 0.90,
      content: widget));
}
