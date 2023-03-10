import 'dart:async';

import 'package:avatar_view/avatar_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:we_coin/data/repositry/view_profile_get.dart';
import 'package:we_coin/view/dashboard/navigation_pages/wallats/qr_code/recieved_btc.dart';

import '../../../../data/model/wallets_model.dart';
import '../../../../data/repositry/currencies_get_repo.dart';
import '../../../../utils/color_manager.dart';
import '../../../../utils/image_manager.dart';

class RecivedMoneyPageScreen extends StatefulWidget {
  const RecivedMoneyPageScreen({Key? key}) : super(key: key);

  @override
  State<RecivedMoneyPageScreen> createState() => _RecivedMoneyPageScreenState();
}

class _RecivedMoneyPageScreenState extends State<RecivedMoneyPageScreen> {
  List<String> _text2 = ['WeCoin', 'LiteCoin', 'BitCoin', 'Ethereum'];
  List<String> _text3 = ['00.00 BC', '00.00 WC', '00.00 LC', '00.00 EC'];
  List<String> list2 = [
    ImageManager.weCoin_logo,
    ImageManager.currency_two,
    ImageManager.currency_three,
    ImageManager.currency_four,
  ];
  List<String> qr_list = [
    ImageManager.qr_1,
    ImageManager.qr_1,
    ImageManager.qr_1,
    ImageManager.qr_1,
  ];
  List<Widget> pages = [
    RecievedBtcScreen(),
    RecievedBtcScreen(),
    RecievedBtcScreen(),
    RecievedBtcScreen(),
  ];
  StreamController? _postsController;
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  int count = 1;

  loadPosts() async {
    final viewProfile = Provider.of<CurrenciesProvider>(context, listen: false);
    viewProfile.getWallets().then((res) async {
      _postsController!.add(res);
      return res;
    });
  }

  showSnack() {
    return scaffoldKey.currentState ==
        SnackBar(
          content: Text('New content loaded'),
        );
  }

  @override
  void initState() {
    _postsController = new StreamController();
    loadPosts();
    super.initState();
    _storeBalance();
  }

  Future<Null> _handleRefresh() async {
    count++;
    print(count);
    final viewProfile = Provider.of<CurrenciesProvider>(context, listen: false);
    viewProfile.getWallets().then((res) async {
      _postsController!.add(res);
      showSnack();
      return null;
    });
  }

  String? accountNo;
  String? balance;
  double? amount;
  double? percent;
  _storeBalance() async {
    setState(() {});
    SharedPreferences prefs = await SharedPreferences.getInstance();
    accountNo = prefs.getString('fromKey');
    balance = prefs.getString('balance2');
    amount = prefs.getDouble('amount');
    percent = (amount! / amount!) * 100;
    print("Percentage ${percent}");
    print("Ac-No:${accountNo}" + "Ac-Bl:${balance}");
  }

  @override
  Widget build(BuildContext context) {
    final wallet = Provider.of<CurrenciesProvider>(context, listen: false);
    final profile = Provider.of<ViewProfile_Provider>(context, listen: false);
    wallet.getWallets();
    return Scaffold(
      body: Column(
        children: [
          Container(
            color: ColorsManager.APP_MAIN_COLOR,
            height: MediaQuery.of(context).size.height * 0.13,
            alignment: Alignment.center,
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 12.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FutureBuilder<WalletsModel?>(
                  future: wallet.getWallets(),
                  builder: (
                    BuildContext context,
                    AsyncSnapshot<WalletsModel?> snapshot,
                  ) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Text(
                        "Total: ${balance == null ? "0.00" : balance}\$",
                        style: TextStyle(
                            fontSize: 25.sp,
                            fontWeight: FontWeight.w600,
                            color: ColorsManager.WHITE_COLOR),
                      );
                    } else if (snapshot.connectionState ==
                        ConnectionState.done) {
                      if (snapshot.hasError) {
                        return const Text('Error');
                      } else if (snapshot.hasData) {
                        WalletsModel? userInfo = snapshot.data;
                        return Text(
                          "Total: ${userInfo!.data!.first.balance}\$",
                          style: TextStyle(
                              fontSize: 25.sp,
                              fontWeight: FontWeight.w600,
                              color: ColorsManager.WHITE_COLOR),
                        );
                      } else {
                        return Text(
                          "Total: 00\$",
                          style: TextStyle(
                              fontSize: 25.sp,
                              fontWeight: FontWeight.w600,
                              color: ColorsManager.WHITE_COLOR),
                        );
                      }
                    } else {
                      return Text('State: ${snapshot.connectionState}');
                    }
                  },
                ),
                SizedBox(height: 5.h),
                /*Text(
                  "Cuurent Balance",
                  style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                      color: ColorsManager.COLOR_GRAY),
                ),*/
              ],
            ),
          ),
          Expanded(
              child: FutureBuilder<WalletsModel?>(
            future: wallet.getWallets(),
            builder: (
              BuildContext context,
              AsyncSnapshot<WalletsModel?> snapshot,
            ) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                  return const Text('Error');
                } else if (snapshot.hasData) {
                  WalletsModel? userInfo = snapshot.data;

                  return ListView.builder(
                      shrinkWrap: true,
                      itemCount: userInfo!.data!.length,
                      itemBuilder: (BuildContext ctxt, int index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          child: InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => RecievedBtcScreen(
                                            AccountBalance: userInfo
                                                .data![index].balance
                                                .toString(),
                                            accountNo: userInfo
                                                .data![index].accountAddress
                                                .toString())));
                              },
                              child: Card(
                                elevation: 10,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                child: ListTile(
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 12.0, vertical: 10),
                                  leading: AvatarView(
                                      radius: 24,
                                      borderWidth: 2,
                                      borderColor:
                                          ColorsManager.YELLOWBUTTON_COLOR,
                                      avatarType: AvatarType.CIRCLE,
                                      imagePath:
                                          "http://wecoin.pk/weCoinApp/uploads/${userInfo.data![index].currencies!.logo == null ? ImageManager.weCoin_logo : userInfo.data![index].currencies!.logo}",
                                      placeHolder: Container(
                                        child: Icon(
                                          Icons.person,
                                        ),
                                      ),
                                      errorWidget: Image.asset(
                                          ImageManager.weCoin_logo)),
                                  /*CircleAvatar(
                                    radius: 20,
                                    backgroundImage: NetworkImage(
                                        "http://wecoin.pk/weCoinApp/uploads/${userInfo.data![index].currencies!.logo}"),
                                  ),*/
                                  title: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "${userInfo.data![index].currencies!.name}",
                                        textDirection: TextDirection.rtl,
                                        softWrap: true,
                                        style: TextStyle(
                                            fontSize: 15.sp,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            "${userInfo.data![index].balance.toString()}",
                                            textDirection: TextDirection.rtl,
                                            softWrap: true,
                                            style: TextStyle(
                                                fontSize: 15.sp,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          SizedBox(width: 60),
                                          Image.asset(
                                            "${ImageManager.qr_1}",
                                            /*"http://wecoin.pk/weCoinApp/uploads/${userInfo.data![index].currencies!.logo}",*/
                                            height: 40,
                                            width: 40,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              )),
                        );
                      });
                } else {
                  return const Text('Empty data');
                }
              } else {
                return Text('State: ${snapshot.connectionState}');
              }
            },
          ))
        ],
      ),
    );
  }
}

/*
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
*/
