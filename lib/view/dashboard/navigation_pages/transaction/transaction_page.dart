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
import 'dart:math' as math;

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
                  print('Has error: ${snapshot.hasError}');
                  print('Has data: ${snapshot.hasData}');
                  print('Snapshot Data ${snapshot.data}');

                  if (snapshot.hasError) {
                    return Text("");
                  }

                  if (snapshot.hasData) {
                    TransactionModel? userInfo = snapshot.data;
                    return Column(
                      children: <Widget>[
                        Expanded(
                          child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: userInfo!.data!.transactions!.length,
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
                                  title: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
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
                                        "\$${userInfo.data!.transactions![index].total!.substring(0, 6)}",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600),
                                      ),
                                      Text(
                                        "Completed",
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
                      child: CircularProgressIndicator(),
                    );
                  }

                  if (!snapshot.hasData &&
                      snapshot.connectionState == ConnectionState.done) {
                    return Text('No Posts');
                  }
                  return Text("data");
                },
              ),
              /* FutureBuilder<ViewTicketModel?>(
              future: viewTicket.viewTickets(),
              builder: (
                BuildContext context,
                AsyncSnapshot<ViewTicketModel?> snapshot,
              ) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasError) {
                    return const Text('Error');
                  } else if (snapshot.hasData) {
                    ViewTicketModel? userInfo = snapshot.data;
                    print("Tickits=>${userInfo!.data!.first.id}");
                    return ListView.builder(
                        shrinkWrap: true,
                        itemCount: userInfo.data!.length,
                        itemBuilder: (BuildContext ctxt, int index) {
                          return Container(
                              margin: new EdgeInsets.fromLTRB(10, 20, 10, 0),
                              width: 25.0,
                              height: MediaQuery.of(context).size.height * 0.17,
                              child: Card(
                                elevation: 7,
                                clipBehavior: Clip.antiAlias,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0)),
                                color: Colors.white,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Container(
                                      color: Colors.amber,
                                      width: 5,
                                    ),
                                    SizedBox(
                                      width: 10.0,
                                    ),
                                    Expanded(
                                      child: GestureDetector(
                                        onTap: () {
                                          print('testing');
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              right: 12, bottom: 12),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              new Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: <Widget>[
                                                  new Text(
                                                    'ID: 54545454',
                                                  ),
                                                  SizedBox(height: 30),
                                                  Text("Open"),
                                                ],
                                              ),
                                              Text(
                                                snapshot
                                                    .data!.data![index].subject
                                                    .toString(),
                                                style: TextStyle(
                                                    fontSize: 16.sp,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                              Container(
                                                height: 20,
                                                padding:
                                                    EdgeInsets.only(top: 5),
                                                child: Text(
                                                  snapshot.data!.data![index]
                                                      .priority
                                                      .toString(),
                                                  style: TextStyle(
                                                      fontSize: 12.sp,
                                                      color: ColorsManager
                                                          .COLOR_GRAY,
                                                      fontWeight:
                                                          FontWeight.w400),
                                                ),
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    snapshot.data!.data![index]
                                                        .createdAt
                                                        .toString(),
                                                    style: TextStyle(
                                                        fontSize: 12.sp,
                                                        color: ColorsManager
                                                            .APP_MAIN_COLOR,
                                                        fontWeight:
                                                            FontWeight.w400),
                                                  ),
                                                  Row(
                                                    children: [
                                                      InkWell(
                                                        onTap: () {},
                                                        // Get.to(ChatPage()),
                                                        child: CircleAvatar(
                                                            backgroundColor:
                                                                ColorsManager
                                                                    .COLOR_CONTAINER,
                                                            radius: 16,
                                                            child: Image.asset(
                                                              ImageManager
                                                                  .message_icon,
                                                              height: 20,
                                                            )),
                                                      ),
                                                      SizedBox(width: 10),
                                                      InkWell(
                                                        onTap: () => Get.to(
                                                            ViewTickitsScreen()),
                                                        child: CircleAvatar(
                                                            backgroundColor:
                                                                ColorsManager
                                                                    .COLOR_CONTAINER,
                                                            radius: 16,
                                                            child: Image.asset(
                                                              ImageManager
                                                                  .aye_icon,
                                                              height: 20,
                                                            )),
                                                      )
                                                    ],
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ));
                        });
                  } else {
                    return const Text('Empty data');
                  }
                } else {
                  return Text('State: ${snapshot.connectionState}');
                }
              },
            ),*/
            ),
            /*Expanded(
              child: Container(
                height: MediaQuery.of(context).size.height * 0.55,
                child: FutureBuilder<TransactionModel?>(
                  future: transactionProvider.viewTransaction(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      TransactionModel? userInfo = snapshot.data;
                      print("${snapshot.data!.message}");
                      print(
                          "${userInfo!.data!.transactions!.first.email.toString()}");
                      if (userInfo != null) {
                        return ListTile(
                          leading: AvatarView(
                            radius: 24,
                            borderWidth: 2,
                            borderColor: ColorsManager.YELLOWBUTTON_COLOR,
                            avatarType: AvatarType.CIRCLE,
                            imagePath:
                                "https://images.pexels.com/photos/415829/pexels-photo-415829.jpeg?cs=srgb&dl=pexels-pixabay-415829.jpg",
                            placeHolder: Container(
                              child: Icon(
                                Icons.person,
                              ),
                            ),
                            errorWidget: Container(
                              child: Icon(
                                Icons.error,
                                size: 50,
                              ),
                            ),
                          ),
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
                              Text(_text3[index],
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: ColorsManager.COLOR_BLACK)),
                              SizedBox(height: 10.h)
                            ],
                          ),
                          trailing: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "\$750.00",
                                style: TextStyle(fontWeight: FontWeight.w600),
                              ),
                              Text(
                                "Completed",
                                style:
                                    TextStyle(color: ColorsManager.COLOR_GREEN),
                              ),
                            ],
                          ),
                        );
                      }
                    }
                    return Center(child: CircularProgressIndicator());
                  },
                ),
              ),
            ),*/
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
