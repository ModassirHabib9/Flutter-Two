// import 'dart:convert';
//
// import 'package:charts_flutter/flutter.dart' as charts;
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
//
// class NetworkHelper {
//   Future<http.Response> get(String endpoint) async {
//     var url = Uri.parse(endpoint);
//     var response = await http.get(url);
//     return response;
//   }
// }
//
// class BarChartAPI extends StatefulWidget {
//   const BarChartAPI({Key? key}) : super(key: key);
//
//   @override
//   State<BarChartAPI> createState() => _BarChartAPIState();
// }
//
// class _BarChartAPIState extends State<BarChartAPI> {
//   List<GenderModel> genders = [];
//   bool loading = true;
//   NetworkHelper _networkHelper = NetworkHelper();
//
//   @override
//   void initState() {
//     super.initState();
//     getData();
//   }
//
//   void getData() async {
//     var response = await http.get(Uri.pa"http://wecoin.pk/weCoinApp/api/enrollment/graphData");
//     List<GenderModel> tempdata = genderModelFromJson(response.body);
//     setState(() {
//       genders = tempdata;
//       loading = false;
//     });
//   }
//
//   List<charts.Series<GenderModel, String>> _createSampleData() {
//     return [
//       charts.Series<GenderModel, String>(
//         data: genders,
//         id: 'sales',
//         colorFn: (_, __) => charts.MaterialPalette.teal.shadeDefault,
//         domainFn: (GenderModel genderModel, _) => genderModel.name,
//         measureFn: (GenderModel genderModel, _) => genderModel.count,
//       )
//     ];
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Bar Chart With API"),
//       ),
//       body: Center(
//         child: loading
//             ? CircularProgressIndicator()
//             : Container(
//                 height: 300,
//                 child: charts.BarChart(
//                   _createSampleData(),
//                   animate: true,
//                 ),
//               ),
//       ),
//     );
//   }
// }
// List<GenderModel> genderModelFromJson(String str) => List<GenderModel>.from(
//     json.decode(str).map((x) => GenderModel.fromJson(x)));
//
// String genderModelToJson(List<GenderModel> data) =>
//     json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
//
// class GenderModel {
//   GenderModel({
//     required this.name,
//     required this.gender,
//     required this.probability,
//     required this.count,
//   });
//
//   String name;
//   String gender;
//   double probability;
//   int count;
//
//   factory GenderModel.fromJson(Map<String, dynamic> json) => GenderModel(
//         name: json["name"],
//         gender: json["gender"],
//         probability: json["probability"].toDouble(),
//         count: json["count"],
//       );
//
//   Map<String, dynamic> toJson() => {
//         "name": name,
//         "gender": gender,
//         "probability": probability,
//         "count": count,
//       };
// }
