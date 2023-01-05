import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:we_coin/utils/api_constant.dart';
import 'package:http/http.dart' as http;
import '../model/currencies_model.dart';
import '../model/get_transaction_model.dart';
import '../model/get_wallet_model.dart';
import '../model/setting_activity_model.dart';
import '../model/setting_notification_model.dart';
import '../model/wallets_model.dart';

class CurrenciesProvider extends ChangeNotifier {
  Future<CurrenciesModel?> getCurrencies() async {
    String fileName = "getCurrencies.json";
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    print("===> Currenies Profile ${token}");

    var dir = await getTemporaryDirectory();

    File file = new File(dir.path + "/" + fileName);
    if (file.existsSync()) {
      print("Loading from cache");
      var jsonData = file.readAsStringSync();
      CurrenciesModel response =
          CurrenciesModel.fromJson(json.decode(jsonData));
      return response;
    } else {
      print("Loading from API");
      var response = await http.get(
          Uri.parse(
            ApiConstants.BASE_URL + ApiConstants.GET_CURRENCIES,
          ),
          headers: {
            "authentication": "${token}",
          });

      if (response.statusCode == 200) {
        var jsonResponse = response.body;
        CurrenciesModel res =
            CurrenciesModel.fromJson(json.decode(jsonResponse));
        //save json in local file
        file.writeAsStringSync(jsonResponse, flush: true, mode: FileMode.write);

        return res;
      }
    }
  }

  Future<WalletsModel?> getWallets() async {
    // String fileName = "getWallets.json";
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    print("===> Profile ${token}");

    // var dir = await getTemporaryDirectory();
    //
    // File file = new File(dir.path + "/" + fileName);
    // if (file.existsSync()) {
    //   print("Loading from cache");
    //   var jsonData = file.readAsStringSync();
    //   WalletsModel response = WalletsModel.fromJson(json.decode(jsonData));
    //   return response;
    // } else {
    //   print("Loading from API");
      var response = await http.get(
          Uri.parse(
            ApiConstants.BASE_URL + ApiConstants.GET_WALLETS,
          ),
          headers: {
            "authentication": "${token}",
          });

      if (response.statusCode == 200) {
        var jsonResponse = response.body;
        WalletsModel res = WalletsModel.fromJson(json.decode(jsonResponse));
        //save json in local file
        // file.writeAsStringSync(jsonResponse, flush: true, mode: FileMode.write);

        return res;
      }
    // }
  }
  ///// get transaction
  Future<TransactionModel?> viewTransaction() async {
    // String fileName = "getTransaction.json";
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    print("===> ge transaction token ${token}");

    // var dir = await getTemporaryDirectory();

    // File file = new File(dir.path + "/" + fileName);
    // if (file.existsSync()) {
    //   print("Loading from cache");
    //   var jsonData = file.readAsStringSync();
    //   TransactionModel response =
    //       TransactionModel.fromJson(json.decode(jsonData));
    //   return response;
    // } else {
    //   print("Loading from API");
      var response = await http.get(
          Uri.parse(
            ApiConstants.BASE_URL + ApiConstants.GET_TRANSACTION,
          ),
          headers: {
            "authentication": "${token}",
          });

      print("Transaction Response");
      print(response.body);

      if (response.statusCode == 200) {
        var jsonResponse = response.body;
        TransactionModel res =
            TransactionModel.fromJson(json.decode(jsonResponse));
        //save json in local file
        // file.writeAsStringSync(jsonResponse, flush: true, mode: FileMode.write);

        return res;
      // }
    }
  }
}
