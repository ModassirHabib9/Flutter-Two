import 'package:avatar_view/avatar_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../../data/model/get_transaction_model.dart';
import '../../../../data/repositry/currencies_get_repo.dart';
import '../../../../utils/color_manager.dart';
import '../../../../utils/image_manager.dart';

class TransactionNavigationPage extends StatefulWidget {
  const TransactionNavigationPage({Key? key}) : super(key: key);

  @override
  State<TransactionNavigationPage> createState() =>
      _TransactionNavigationPageState();
}

class _TransactionNavigationPageState extends State<TransactionNavigationPage> {
  late List<_ChartData> data1;
  late TooltipBehavior _tooltip;

  @override
  void initState() {
    data1 = [
      _ChartData('2001', 12),
      _ChartData('2002', 15),
      _ChartData('2005', 30),
      _ChartData('2007', 6.4),
      _ChartData('2015', 14),
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
  List<String> _text3 = [
    'Send',
    'Recieved',
    'Exchange',
    'complete',
  ];
  List<String> list2 = [
    ImageManager.weCoin_logo,
    ImageManager.currency_two,
    ImageManager.currency_three,
    ImageManager.currency_four,
  ];

  @override
  Widget build(BuildContext context) {
    final transactionProvider =
        Provider.of<CurrenciesProvider>(context, listen: false);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.r)),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 10),
                height: 200,
                child: SfCartesianChart(
                    plotAreaBorderWidth: 0,
                    borderWidth: 0,
                    enableSideBySideSeriesPlacement: false,
                    primaryYAxis: CategoryAxis(isVisible: false),
                    enableAxisAnimation: false,
                    primaryXAxis: CategoryAxis(
                      axisLine: AxisLine(width: 0),
                      majorGridLines: MajorGridLines(width: 0),
                    ),
                    tooltipBehavior: _tooltip,
                    series: <ChartSeries<_ChartData, String>>[
                      BarSeries<_ChartData, String>(
                          dataSource: data1,
                          xValueMapper: (_ChartData data, _) => data.x,
                          yValueMapper: (_ChartData data, _) => data.y,
                          color: Color.fromRGBO(8, 142, 255, 1))
                    ]),
              ),
            ),
            SizedBox(height: 20.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  " Transactions",
                  style: TextStyle(
                    color: ColorsManager.COLOR_GRAY,
                    fontSize: 14.sp,
                  ),
                ),
                Text("See All", style: TextStyle()),
              ],
            ),
            Expanded(
              child: FutureBuilder<TransactionModel?>(
                future: transactionProvider.viewTransaction(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasError) {
                    return Text("Error");
                  }
                  if (snapshot.hasData) {
                    TransactionModel? userInfo = snapshot.data;
                    print(userInfo!.data!.transactions!.length);
                    if (userInfo!.data!.transactions!.length == 0) {
                      return Center(
                          child: Center(
                        child: Scrollbar(
                          child: Image.asset(ImageManager.noDataFound),
                        ),
                      ));
                    }
                    return Column(
                      children: <Widget>[
                        Expanded(
                          child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: userInfo.data!.transactions!.length,
                              itemBuilder: (BuildContext ctxt, int index) {
                                return ListTile(
                                  leading: AvatarView(
                                      radius: 24,
                                      borderWidth: 2,
                                      borderColor:
                                          ColorsManager.YELLOWBUTTON_COLOR,
                                      avatarType: AvatarType.CIRCLE,
                                      imagePath: ImageManager.weCoin_logo,
                                      placeHolder: Container(
                                        child: Icon(
                                          Icons.person,
                                        ),
                                      ),
                                      errorWidget: CircularProgressIndicator()),
                                  title: Text(userInfo
                                      .data!.transactions![index].fromAccount
                                      .toString()),
                                  subtitle: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                          "${userInfo.data!.transactions![index].createdAt!.substring(0, 10)}",
                                          style: TextStyle(
                                            fontSize: 12.sp,
                                            color: ColorsManager.COLOR_GRAY,
                                          )),
                                      if (userInfo.data!.transactions![index]
                                              .note ==
                                          "Sending amount")
                                        Text(
                                            "${userInfo.data!.transactions![index].status}",
                                            style: TextStyle(
                                                fontSize: 16,
                                                color:
                                                    ColorsManager.COLOR_BLACK)),
                                      if (userInfo.data!.transactions![index]
                                              .status ==
                                          "Exchange")
                                        Text(
                                            "${userInfo.data!.transactions![index].status}",
                                            style: TextStyle(
                                                fontSize: 16,
                                                color:
                                                    ColorsManager.COLOR_BLACK)),
                                      SizedBox(height: 10.h)
                                    ],
                                  ),
                                  trailing: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        "\$${userInfo.data!.transactions![index].subtotal!.substring(0, 6)}",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600),
                                      ),
                                      Text(
                                        userInfo.status!,
                                        style: TextStyle(
                                            color: ColorsManager.COLOR_GREEN),
                                      ),
                                    ],
                                  ),
                                );
                              }),
                        ),
                      ],
                    );
                  }

                  if (snapshot.connectionState != ConnectionState.done) {
                    return Center(
                      child: Text(""),
                    );
                  }

                  if (!snapshot.hasData &&
                      snapshot.connectionState == ConnectionState.done) {
                    return Text('No Posts');
                  }
                  return Text("data");
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ChartData {
  _ChartData(this.x, this.y);

  final String x;
  final double y;
}
