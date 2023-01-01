import 'package:avatar_view/avatar_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:line_chart/charts/line-chart.widget.dart';
import 'package:line_chart/model/line-chart.model.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:we_coin/utils/color_manager.dart';
import 'package:we_coin/utils/image_manager.dart';
import 'package:we_coin/view/dashboard/drawer.dart';
import 'package:we_coin/view/dashboard/navigation_pages/home_page/widget/custom_coin_card.dart';
import 'package:we_coin/view/dashboard/navigation_pages/profile/profile_page.dart';

import '../../../../data/model/collection_modl.dart';
import '../../../../data/repositry/collection.dart';
import '../../navbar.dart';
import 'package:dio/dio.dart';

class HomePageScreen extends StatefulWidget {
  static const String routeName = '/homePage';
  const HomePageScreen({Key? key}) : super(key: key);

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  var _client = Dio();
  List<LineChartModel> data = [
    LineChartModel(amount: 100, date: DateTime(2020, 1, 1)),
    LineChartModel(amount: 200, date: DateTime(2020, 1, 2)),
    LineChartModel(amount: 300, date: DateTime(2020, 1, 3)),
    LineChartModel(amount: 400, date: DateTime(2020, 1, 4)),
    LineChartModel(amount: 800, date: DateTime(2020, 1, 5)),
    LineChartModel(amount: 200, date: DateTime(2020, 1, 6)),
    LineChartModel(amount: 140, date: DateTime(2020, 1, 8)),
    LineChartModel(amount: 110, date: DateTime(2020, 1, 9)),
    LineChartModel(amount: 250, date: DateTime(2020, 1, 10)),
    LineChartModel(amount: 390, date: DateTime(2020, 1, 11)),
    LineChartModel(amount: 900, date: DateTime(2020, 1, 12)),
  ];

  int _counter = 0;

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

  ///bottom Grid
  List<String> _text2 = [
    'WeCoin',
    'LiteCoin',
    'BitCoin',
    'Ethereum',
  ];
  List<String> list2 = [
    ImageManager.weCoin_logo,
    ImageManager.currency_two,
    ImageManager.currency_three,
    ImageManager.currency_four,
  ];

  bool check = true;

  getDataAgain() async {
    setState(() {
      check = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    Paint circlePaint = Paint()..color = Colors.black;

    Paint insideCirclePaint = Paint()..color = Colors.white;

    Paint linePaint = Paint()
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke
      ..color = ColorsManager.WHITE_COLOR;

    return Scaffold(
        body: Padding(
      padding: EdgeInsets.only(left: 8.0, right: 8.0, top: 20),
      child: Column(
        children: [
          Container(
              height: 126,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  Container(
                    width: 100,
                    height: 126,
                    child: CustomCoinCard(
                        coinPicture: ImageManager.currency_three,
                        cardColor: ColorsManager.YELLOWBUTTON_COLOR,
                        coinName: "BitCoin",
                        coinRate: "4,351 BC",
                        coinPrice: "\$124,0",
                        coinPercent: "40"),
                  ),
                  SizedBox(width: 10.w),
                  Container(
                    width: 100,
                    height: 126,
                    child: CustomCoinCard(
                        coinPicture: ImageManager.currency_one,
                        cardColor: ColorsManager.COLOR_BLACK,
                        coinName: "WeCoin",
                        coinRate: "5,451 WC",
                        coinPrice: "\$124,0",
                        coinPercent: "40"),
                  ),
                  SizedBox(width: 10.w),
                  Container(
                    width: 100,
                    height: 126,
                    child: CustomCoinCard(
                        coinPicture: ImageManager.currency_two,
                        cardColor: ColorsManager.DASHBOARD_FIRST_COLOR,
                        coinName: "LitCoin",
                        coinRate: "3,951 LC",
                        coinPrice: "\$124,0",
                        coinPercent: "40"),
                  ),
                  SizedBox(width: 10.w),
                  Container(
                    width: 100,
                    height: 126,
                    child: CustomCoinCard(
                        coinPicture: ImageManager.currency_four,
                        cardColor: ColorsManager.DASHBOARD_THERD_COLOR,
                        coinName: "Ethereum",
                        coinRate: "6,391 EC",
                        coinPrice: "\$124,0",
                        coinPercent: "40"),
                  ),
                ],
              )),
          /////// new design graphs
          /*charts.Barchart(series, animate: true)*/
          //// new column start
          SizedBox(height: 20.h),
          Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.r)),
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 10),
              height: 170,
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
                        xValueMapper: (_ChartData data, _) => data.x,
                        yValueMapper: (_ChartData data, _) => data.y,
                        color: Color.fromRGBO(8, 142, 255, 1))
                  ]),
            ),
          ),
          SizedBox(height: 20.h),
          Container(
            padding: EdgeInsets.all(12),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Recent Transactions",
                      style: TextStyle(
                        color: ColorsManager.COLOR_GRAY,
                        fontSize: 14.sp,
                      ),
                    ),
                    Text("See All", style: TextStyle()),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              shrinkWrap: false,
              children: List.generate(
                list2.length,
                (index) => ListTile(
                  leading: AvatarView(
                      radius: 24,
                      borderWidth: 1,
                      borderColor: ColorsManager.YELLOWBUTTON_COLOR,
                      avatarType: AvatarType.CIRCLE,
                      imagePath: list2[index],
                      // placeHolder: Container(
                      //   child: Icon(
                      //     Icons.person,
                      //   ),
                      // ),
                      errorWidget: CircularProgressIndicator()),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(_text2[index]),
                      Text("Type",
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              color: ColorsManager.COLOR_GRAY)),
                      SizedBox(height: 10.h)
                    ],
                  ),
                  subtitle: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("12/02/22",
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: ColorsManager.COLOR_GRAY,
                          )),
                      Text("Send",
                          style: TextStyle(
                              fontSize: 16, color: ColorsManager.COLOR_BLACK)),
                      SizedBox(height: 10.h)
                    ],
                  ),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "\$00.00",
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    ));
  }
}

class _ChartData {
  _ChartData(this.x, this.y);

  final String x;
  final double y;
}
