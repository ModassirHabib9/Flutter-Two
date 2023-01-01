import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:we_coin/utils/api_constant.dart';

import '../model/view_dispute_model.dart';
import '../model/view_ticket_model.dart';

class ViewTickets_Provider extends ChangeNotifier {
  Future<ViewTicketModel?> viewTickets() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    print("===> Currenies Profile ${token}");

    var response = await http.get(
        Uri.parse(
          ApiConstants.BASE_URL + ApiConstants.GET_TICKETS,
        ),
        headers: {
          "authentication": "${token}",
        });

    if (response.statusCode == 200) {
      var jsonResponse = response.body;
      var box = await Hive.openBox('viewTickets');
      box.put('name', response.body);
      print(box.get('name'));
      notifyListeners();
      ViewTicketModel res = ViewTicketModel.fromJson(json.decode(jsonResponse));
      return res;
    }
  }

  //// view Dispute Repo
  Future<ViewDisputeModel?> viewDispute() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    print("===> Currenies Profile ${token}");

    var response = await http.get(
        Uri.parse(
          ApiConstants.BASE_URL + ApiConstants.GET_DISPUTES,
        ),
        headers: {
          "authentication": "${token}",
        });

    if (response.statusCode == 200) {
      var jsonResponse = response.body;
      var box = await Hive.openBox('viewDispute');
      box.put('name', response.body);
      print("print dispute ${box.get('name')}");
      ViewDisputeModel res =
          ViewDisputeModel.fromJson(json.decode(jsonResponse));
      notifyListeners();
      return res;
    }
  }
}
