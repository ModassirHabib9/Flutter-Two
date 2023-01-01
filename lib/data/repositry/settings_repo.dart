import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:we_coin/utils/api_constant.dart';

import '../model/setting_activity_model.dart';
import '../model/setting_notification_model.dart';
import 'package:http/http.dart' as http;

class SettingsProvider extends ChangeNotifier {
  Future<SettingNotificationModel?> getNotification() async {
    String fileName = "getNotification.json";
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    print("===> Currenies Profile ${token}");

    var dir = await getTemporaryDirectory();

    File file = new File(dir.path + "/" + fileName);
    if (file.existsSync()) {
      print("Loading from cache");
      var jsonData = file.readAsStringSync();
      SettingNotificationModel response =
          SettingNotificationModel.fromJson(json.decode(jsonData));
      return response;
    } else {
      print("Loading from API");
      var response = await http.get(
          Uri.parse(
            ApiConstants.BASE_URL + ApiConstants.SETTING_NOTIFICATION,
          ),
          headers: {
            "authentication": "${token}",
          });

      if (response.statusCode == 200) {
        var jsonResponse = response.body;
        SettingNotificationModel res =
            SettingNotificationModel.fromJson(json.decode(jsonResponse));
        //save json in local file
        file.writeAsStringSync(jsonResponse, flush: true, mode: FileMode.write);

        return res;
      }
    }
  }

  // listing activity
  Future<SettingActivityModel?> getActivity() async {
    String fileName = "getActivity.json";
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    print("===> Currenies Profile ${token}");

    var dir = await getTemporaryDirectory();

    File file = new File(dir.path + "/" + fileName);
    if (file.existsSync()) {
      print("Loading from cache");
      var jsonData = file.readAsStringSync();
      SettingActivityModel response =
          SettingActivityModel.fromJson(json.decode(jsonData));
      return response;
    } else {
      print("Loading from API");
      var response = await http.get(
          Uri.parse(
            ApiConstants.BASE_URL + ApiConstants.SETTING_ACTIVITY_LIST,
          ),
          headers: {
            "authentication": "${token}",
          });

      if (response.statusCode == 200) {
        var jsonResponse = response.body;
        SettingActivityModel res =
            SettingActivityModel.fromJson(json.decode(jsonResponse));
        //save json in local file
        file.writeAsStringSync(jsonResponse, flush: true, mode: FileMode.write);

        return res;
      }
    }
  }
}
