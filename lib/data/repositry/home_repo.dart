import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/api_constant.dart';
import '../model/home_graph_model.dart';
import '../model/recent_transaction_model.dart';

class HomeProvider with ChangeNotifier {
  Future<RecentTransactionsModel?> getHome() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    print(
        "________________________/ Home transaction\\_________________________");

    var response = await http.get(
        Uri.parse(
          ApiConstants.BASE_URL + ApiConstants.GET_HOME,
        ),
        headers: {
          "authentication": "${token}",
        });

    if (response.statusCode == 200) {
      var jsonResponse = response.body;
      var box = await Hive.openBox('GetHome');
      box.put('name', response.body);
      final users = box.get('name');
      final Map<String, dynamic> userMap = jsonDecode(users);
      print("____________________//\\_______________________");
      print("$userMap");
      RecentTransactionsModel res =
          RecentTransactionsModel.fromJson(json.decode(jsonResponse));

      return res;
    }
    // }
  }

  Future<HomeGraphModel?> graphData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    print("________________________/ Graph Start\\_________________________");

    var response = await http.get(
        Uri.parse(
          ApiConstants.BASE_URL + ApiConstants.GET_HOME_GRAPH,
        ),
        headers: {
          "authentication":
              "624___e3d8c6621fb0a78888cc968df935ceab72715c782c5393e326d2da5d7c761d835d2f504624ba9959",
        });

    if (response.statusCode == 200) {
      var jsonResponse = response.body;
      print("$jsonResponse");
      print("____________________//Graph End\\_______________________");

      HomeGraphModel res = HomeGraphModel.fromJson(json.decode(jsonResponse));

      return res;
    }
    // }
  }
}
