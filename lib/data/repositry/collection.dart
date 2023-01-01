// import 'dart:convert';
//
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:http/http.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:dio/dio.dart';
// import '../../utils/api_constant.dart';
// import '../model/collection_modl.dart';
// import '../model/view_profile_model.dart';
//
// class Get2 {
//   //err
//   Future<Data?> fetchData() async {
//     Data? user;
//     try {
//       var dio = Dio();
//       final userData = await dio
//           .get('http://wecoin.pk/weCoinApp/api/enrollment/profileView');
//
//       print('===============> User Response: \n ${userData.data}');
//       user = Data.fromJson(userData.data);
//
//       print("==========>  ${user.firstName.toString()}");
//     } on DioError catch (e) {
//       // The request was made and the server responded with a status code
//       // that falls out of the range of 2xx and is also not 304.
//       if (e.response != null) {
//         print('Dio error!');
//         print('STATUS: ${e.response?.statusCode}');
//         print('DATA: ${e.response?.data}');
//         print('HEADERS: ${e.response?.headers}');
//       } else {
//         // Error due to setting up or sending the request
//         print('Error sending request!');
//         print(e.message);
//       }
//     }
//     return user;
//   }
// }
