import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:we_coin/data/repositry/view_tickets_repo.dart';
import 'package:we_coin/utils/api_constant.dart';
import 'package:we_coin/view/dashboard/navigation_pages/tickets/tickets.dart';

import 'auth_repo.dart';

class AddTickets_Provider extends ChangeNotifier {
  bool _loading = false;
  bool get loading => _loading;
  void startLoading() {
    _loading = true;
    notifyListeners();
  }

  void stopLoading() {
    _loading = false;
    notifyListeners();
  }

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  ////////////
  Future addTicket(BuildContext context, String priority, String subject,
      String message) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    print("===> Profile ${token}");
    startLoading();
    http.Response response = await http.post(
        Uri.parse(ApiConstants.BASE_URL + ApiConstants.ADD_TICKETS),
        headers: {
          'authentication': '$token',
          'Content-Type': 'application/x-www-form-urlencoded'
        },
        body: {
          "priority": priority,
          "subject": subject,
          "message": message,
        });

    print("Response ${response.body}");
    print("Tickets Parms pass: ${priority+subject+message}");
    Map<String, dynamic> data = jsonDecode(response.body);
    String success = data["status"].toString();
    if (success == "success") {
      stopLoading();
      print('||========== success ==========||');
      Progress(context, Text("Your Ticket added", textAlign: TextAlign.center),
          Colors.green);
    } else {
      stopLoading();
      print('||========== Sorry we have an error ==========||');
      print(response.statusCode);
      Progress(
        context,
        Text(data["message"]),
        Colors.red,
      );
    }
    return response.body;
  }

  //////////// ADD DISPUTE
  Future addDispute(BuildContext context, String type, String title,
      String description) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    print("===> Profile ${token}");
    startLoading();
    http.Response response = await http.post(
        Uri.parse(ApiConstants.BASE_URL + ApiConstants.ADD_DISPUTE),
        headers: {
          'authentication': '$token',
          'Content-Type': 'application/x-www-form-urlencoded'
        },
        body: {
          "type": type,
          "title": title,
          "description": description,
        });
    /*showDialog(
        context: context,
        builder: (context) {
          return Center(child: CircularProgressIndicator());
        });*/
    print("Response ${response.body}");
    Map<String, dynamic> data = jsonDecode(response.body);
    String success = data["status"].toString();
    if (success == "success") {
      stopLoading();
      print('||========== success ==========||');
      Progress(
          context,
          Text("You are successfully register in", textAlign: TextAlign.center),
          Colors.green);
    } else {
      stopLoading();
      print('||========== Sorry we have an error ==========||');
      print(response.statusCode);
      Progress(
        context,
        Text(data["message"]),
        Colors.red,
      );
    }
    return response.body;
  }
}
