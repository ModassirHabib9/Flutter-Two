import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:we_coin/utils/api_constant.dart';

import '../model/view_profile_model.dart';

class ViewProfile_Provider extends ChangeNotifier {
  Future<ViewProfileModel?> getUser1() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    print("===> Profile ${token}");

    var response = await http.get(
        Uri.parse(
          ApiConstants.BASE_URL + ApiConstants.VIEW_PROFILE,
        ),
        headers: {
          "authentication": "${token}",
        });

    if (response.statusCode == 200) {
      var jsonResponse = response.body;
      var box = await Hive.openBox('viewProfile');
      box.put('name', response.body);
      final users = box.get('name');
      final Map<String, dynamic> userMap = jsonDecode(users);
      print("print dispute $userMap");
      ViewProfileModel res =
          ViewProfileModel.fromJson(json.decode(jsonResponse));
      prefs.setString('fromKey', "${res.data!.wallets!.first.accountAddress}");
      prefs.setString('balance2', "${res.data!.wallets!.first.balance}");
      final accountNo = prefs.getString('fromKey');
      final balance = prefs.getString('balance2');
      print("accountNo  ${accountNo}");
      print("balance2  ${balance}");
      notifyListeners();
      return res;
    }
  }
}
