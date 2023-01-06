
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../utils/api_constant.dart';
import '../model/recent_transaction_model.dart';
import '../model/wallets_model.dart';

class HomeProvider with ChangeNotifier{
  Future<RecentTransactionsModel?> getHome() async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    print("__/Recent Home ${token}\\__");

    var response = await http.get(
        Uri.parse(
          ApiConstants.BASE_URL + ApiConstants.GET_WALLETS,
        ),
        headers: {
          "authentication": "${token}",
        });

    if (response.statusCode == 200) {
      print("__/Recent Home Response ${token}\\__");
      var jsonResponse = response.body;
      RecentTransactionsModel res = RecentTransactionsModel.fromJson(json.decode(jsonResponse));

      return res;
    }
    // }
  }
}