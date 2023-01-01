import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:we_coin/view/dashboard/navigation_pages/wallats/view_transaction.dart';

import '../../../../utils/color_manager.dart';
import '../../../../utils/image_manager.dart';
import '../profile/edit_profile.dart';
import '../profile/profile_page.dart';
import 'dart:math' as math;

class WallatPageScreen extends StatefulWidget {
  const WallatPageScreen({Key? key}) : super(key: key);

  @override
  State<WallatPageScreen> createState() => _WallatPageScreenState();
}

class _WallatPageScreenState extends State<WallatPageScreen> {
  late List<_ChartData> data1;
  late TooltipBehavior _tooltip;

  @override
  void initState() {
    data1 = [
      _ChartData('CHN', 12),
      _ChartData('GER', 15),
      _ChartData('RUS', 30),
      _ChartData('BRZ', 6.4),
      _ChartData('IND', 14),
      _ChartData('Pak', 14),
    ];
    _tooltip = TooltipBehavior(enable: true);
    super.initState();
  }

  List<String> _text2 = [
    'WeCoin',
    'LiteCoin',
    'BitCoin',
    'Ethereum',
  ];
  List<String> _text3 = [
    'Send',
    'Recieved',
    'Exchange',
    'send',
  ];
  List<String> list2 = [
    ImageManager.weCoin_logo,
    ImageManager.currency_two,
    ImageManager.currency_three,
    ImageManager.currency_four,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Stack(
              alignment: Alignment.topCenter,
              children: <Widget>[
                // background image and bottom contents
                Column(
                  children: <Widget>[
                    Container(
                        height: MediaQuery.of(context).size.height * 0.20,
                        color: ColorsManager.APP_MAIN_COLOR,
                        alignment: Alignment.topCenter,
                        child: Padding(
                            padding: EdgeInsets.only(
                                left: 12.w, right: 12.w, top: 0.h),
                            child: Column(
                              children: [
                                SizedBox(height: 10.h),
                                Text(
                                  "Total 3.5451515151",
                                  style: TextStyle(
                                      fontSize: 25.sp,
                                      fontWeight: FontWeight.w600,
                                      color: ColorsManager.WHITE_COLOR),
                                ),
                                SizedBox(height: 5.h),
                                Text(
                                  "(\$.25,25,00)",
                                  style: TextStyle(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w600,
                                      color: ColorsManager.COLOR_GRAY),
                                ),
                              ],
                            ))),
                    SizedBox(height: 50),
                  ],
                ),
                // Profile image
                Positioned(
                  left: 0,
                  right: 0,
                  top: MediaQuery.of(context).size.height *
                      0.10, // (background container size) - (circle height / 2)
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.25,
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(horizontal: 12.0),
                    child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.r)),
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          height: 200,
                          child: SfCartesianChart(
                              plotAreaBorderWidth: 0,
                              borderWidth: 0,
                              primaryYAxis: CategoryAxis(isVisible: false),
                              enableSideBySideSeriesPlacement: false,
                              enableAxisAnimation: false,
                              primaryXAxis: CategoryAxis(
                                axisLine: AxisLine(width: 0),
                                majorGridLines: MajorGridLines(width: 0),
                              ),
                              tooltipBehavior: _tooltip,
                              series: <ChartSeries<_ChartData, String>>[
                                ColumnSeries<_ChartData, String>(
                                    dataSource: data1,
                                    xValueMapper: (_ChartData data, _) =>
                                        data.x,
                                    yValueMapper: (_ChartData data, _) =>
                                        data.y,
                                    color: Color.fromRGBO(8, 142, 255, 1))
                              ]),
                        )),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
                itemCount: _text2.length,
                itemBuilder: (BuildContext ctxt, int index) {
                  return ListTile(
                    leading: CircleAvatar(
                      radius: 20,
                      backgroundImage: AssetImage(list2[index]),
                      backgroundColor:
                          Color((math.Random().nextDouble() * 0xFFFFFF).toInt())
                              .withOpacity(1.0),
                    ),
                    title: Text(_text2[index]),
                    subtitle: Text("12/02/22",
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: ColorsManager.COLOR_GRAY,
                        )),
                    trailing: Text(
                      "\$ 00.00",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    onTap: () => Get.to(ViewTransactionScreen()),
                  );
                }),
          ),
        ],
      ),
    );
  }
}

class _ChartData {
  _ChartData(this.x, this.y);

  final String x;
  final double y;
}
