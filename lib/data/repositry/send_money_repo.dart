import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:we_coin/utils/color_manager.dart';

import '../../utils/api_constant.dart';
import 'auth_repo.dart';

class SendMoney_Provider with ChangeNotifier {
  bool _loading = false;
  bool get loading => _loading;
  setloading(bool value) {
    _loading = value;
    notifyListeners();
  }

  ////////////  send money
  Future sendMoney(BuildContext context, String currency, String from,
      String to, String amount, String note, String network_fee) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    print("===> Profile ${token}");
    setloading(true);
    http.Response response = await http.post(
        Uri.parse(ApiConstants.BASE_URL + ApiConstants.SEND_MONEY),
        headers: {
          'authentication': "${token}",
          'Content-Type': 'application/x-www-form-urlencoded'
        },
        body: {
          "currency": "6", //currency,
          "from": from,
          "to": to,
          "amount": amount,
          "note": note,
          "network_fee": network_fee,
        });

    setloading(false);
    Map<String, dynamic> data = jsonDecode(response.body);
    String success = data["status"].toString();
    if (success == "success") {
      setloading(false);
      print('||========== success ==========||');
      Progress(context, Text(data["message"], textAlign: TextAlign.center),
          ColorsManager.COLOR_GREEN);
      // Get.to(LoginScreen());
    } else {
      setloading(false);
      print('||========== Sorry we have an error ==========||');
      print(response.statusCode);
      Progress(
        context,
        Text(data["message"]),
        ColorsManager.COLOR_RED,
      );
    }
    return response.body;
  }
}
