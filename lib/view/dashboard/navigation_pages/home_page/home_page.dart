import 'dart:async';
import 'dart:convert';

import 'package:avatar_view/avatar_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:we_coin/data/repositry/view_profile_get.dart';
import 'package:we_coin/utils/color_manager.dart';
import 'package:we_coin/utils/image_manager.dart';
import 'package:we_coin/view/dashboard/navigation_pages/home_page/see_all.dart';
import 'package:we_coin/view/dashboard/navigation_pages/home_page/widget/custom_coin_card.dart';

import '../../../../data/model/home_graph_model.dart';
import '../../../../data/model/view_profile_model.dart';
import '../../../../data/repositry/home_repo.dart';

class HomePageScreen extends StatefulWidget {
  static const String routeName = '/homePage';
  const HomePageScreen({Key? key}) : super(key: key);

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  List<HomeGraphModel> data1 = [];
  late TooltipBehavior _tooltip;

  bool check = true;

  getDataAgain() async {
    setState(() {
      check = false;
    });
  }

  StreamController? _postsController;
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  // int count = 1;

  loadPosts() async {
    final view = Provider.of<HomeProvider>(context, listen: false);
    view.getHome();
    Hive.openBox('GetHome').then((res) async {
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

  String? accountNo;
  String? balance;
  String? amount;
  double? percent;

  _storeBalance() async {
    setState(() {});
    SharedPreferences prefs = await SharedPreferences.getInstance();
    accountNo = prefs.getString('fromKey');
    balance = prefs.getString('balance2');
    amount = prefs.getString('amount');
    final du = double.parse(amount!);
    percent = (du / 100) * 1;
    print("Percentage ${percent}");
    print("Ac-No:${accountNo}" + "Ac-Bl:${balance}");
  }

  @override
  void initState() {
    _postsController = new StreamController();
    Hive.openBox('GetHome');
    _storeBalance();
    setState(() {
      Hive.openBox('GetHome');
      Provider.of<HomeProvider>(context, listen: false).graphData();
      final viewTicket = Provider.of<HomeProvider>(context, listen: false);
      viewTicket.getHome();
      print(viewTicket);
      _handleRefresh();
    });
    loadPosts();

    _tooltip = TooltipBehavior(enable: true);
    getDataAgain();
    super.initState();
    final Dispute = Provider.of<HomeProvider>(context, listen: false);
    Dispute.getHome();
    print(Dispute);
    loadPosts();
  }

  Future _handleRefresh() async {
    Hive.openBox('GetHome');

    Provider.of<HomeProvider>(context, listen: false).graphData();
    final viewTicket = Provider.of<HomeProvider>(context, listen: false);
    viewTicket.getHome();
    print(viewTicket);
    Hive.openBox('GetHome').then((res) async {
      _postsController!.add(res);
      showSnack();
      return null;
    });
  }

  @protected
  void didUpdateWidget(HomePageScreen oldWidget) {
    Provider.of<HomeProvider>(context, listen: false).getHome();
    super.didUpdateWidget(oldWidget);
  }

  @override
  void didChangeDependencies() {
    final view = Provider.of<HomeProvider>(context, listen: false);
    view.getHome();
  }

  @override
  Widget build(BuildContext context) {
    _storeBalance();
    final home = Provider.of<HomeProvider>(context, listen: false);
    final profile = Provider.of<ViewProfile_Provider>(context, listen: false);
    HomeGraphModel Graph = HomeGraphModel();
    home.getHome();
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
                        coinRate: "0.00 BTC",
                        coinPrice: "\$0.00",
                        coinPercent: "1"),
                  ),
                  SizedBox(width: 10.w),
                  Container(
                    width: 100,
                    height: 126,
                    child: FutureBuilder<ViewProfileModel?>(
                      future: profile.getUser1(),
                      builder: (
                        BuildContext context,
                        AsyncSnapshot<ViewProfileModel?> snapshot,
                      ) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                              child: CustomCoinCard(
                                  coinPicture: ImageManager.currency_one,
                                  cardColor: ColorsManager.COLOR_BLACK,
                                  coinName: "WeCoin",
                                  coinRate:
                                      "${balance == null ? "0 WC" : "${balance} WC"}",
                                  coinPrice:
                                      "\$${percent == null ? "\$1" : percent}",
                                  coinPercent: "1"));
                        } else if (snapshot.connectionState ==
                            ConnectionState.done) {
                          if (snapshot.hasError) {
                            return const Text('Error');
                          } else if (snapshot.hasData) {
                            ViewProfileModel? userInfo = snapshot.data;
                            return CustomCoinCard(
                                coinPicture: ImageManager.currency_one,
                                cardColor: ColorsManager.COLOR_BLACK,
                                coinName: "WeCoin",
                                coinRate:
                                    "${userInfo!.data!.wallets!.first.balance == null ? "0" : "${balance} WC"}",
                                coinPrice: "\$${percent}",
                                coinPercent: "1");
                          } else {
                            return CustomCoinCard(
                                coinPicture: ImageManager.currency_one,
                                cardColor: ColorsManager.COLOR_BLACK,
                                coinName: "WeCoin",
                                coinRate: "0 WC",
                                coinPrice: "0",
                                coinPercent: "1");
                            ;
                          }
                        } else {
                          return Text('State: ${snapshot.connectionState}');
                        }
                      },
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Container(
                    width: 100,
                    height: 126,
                    child: CustomCoinCard(
                        coinPicture: ImageManager.currency_two,
                        cardColor: ColorsManager.DASHBOARD_FIRST_COLOR,
                        coinName: "LitCoin",
                        coinRate: "0.00 LTC",
                        coinPrice: "\$0.00",
                        coinPercent: "1"),
                  ),
                  SizedBox(width: 10.w),
                  Container(
                    width: 100,
                    height: 126,
                    child: CustomCoinCard(
                        coinPicture: ImageManager.currency_four,
                        cardColor: ColorsManager.DASHBOARD_THERD_COLOR,
                        coinName: "Ethereum",
                        coinRate: "0.00 ETC",
                        coinPrice: "\$0.00",
                        coinPercent: "1"),
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
                child: FutureBuilder<HomeGraphModel?>(
                  future: home.graphData(),
                  builder: (
                    BuildContext context,
                    AsyncSnapshot<HomeGraphModel?> snapshot,
                  ) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.connectionState ==
                        ConnectionState.done) {
                      if (snapshot.hasError) {
                        return const Text('Error');
                      } else if (snapshot.hasData) {
                        HomeGraphModel? userInfo = snapshot.data;
                        return SfCartesianChart(
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
                            series: <ChartSeries<HomeGraphModel, String>>[
                              ColumnSeries<HomeGraphModel, String>(
                                  dataSource: data1,
                                  xValueMapper: (HomeGraphModel data, _) =>
                                      data.data![0].country,
                                  yValueMapper: (HomeGraphModel data, _) =>
                                      data.data![0].countryCount,
                                  color: Color.fromRGBO(8, 142, 255, 1))
                            ]);
                      } else {
                        return const Text('Empty data');
                      }
                    } else {
                      return Text('State: ${snapshot.connectionState}');
                    }
                  },
                ) /**/
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
                    InkWell(
                        onTap: () {
                          Get.to(SeeAllTransactionScreen());
                        },
                        child: Text("See All", style: TextStyle())),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
              child: StreamBuilder(
            stream: _postsController!.stream,
            builder: (context, snapshot) {
              final box = snapshot.data;
              // Get the data from the box
              final users = box!.get('name');
              if (users == null) {
                return Center(
                  child: Scrollbar(
                    child: RefreshIndicator(
                        onRefresh: _handleRefresh,
                        child: Image.asset(ImageManager.noDataFound)),
                  ),
                );
              } else if (snapshot.hasData) {
                final box = snapshot.data;
                // Get the data from the box
                final users = box!.get('name');
                final Map<String, dynamic> userMap = jsonDecode(users);
                return Scrollbar(
                  child: RefreshIndicator(
                      onRefresh: _handleRefresh,
                      child: ListView.builder(
                        itemCount: 7,
                        itemBuilder: (context, index) {
                          return ListTile(
                              leading: AvatarView(
                                  radius: 24,
                                  borderWidth: 1,
                                  borderColor: ColorsManager.YELLOWBUTTON_COLOR,
                                  avatarType: AvatarType.CIRCLE,
                                  imagePath:
                                      "${userMap['data'][index]['currencies']['logo'] == null ? ImageManager.weCoin_logo : userMap['data'][index]['currencies']['logo']}",
                                  placeHolder: Container(
                                      child:
                                          Image.asset(ImageManager.user_pro)),
                                  errorWidget: CircularProgressIndicator()),
                              title: Text(
                                  "${userMap['data'][index]['currencies']['name']}"),
                              subtitle: Text(
                                  "${userMap['data'][index]['created_at'].toString().substring(0, 10)}",
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    color: ColorsManager.COLOR_GRAY,
                                  )),
                              trailing: Column(children: [
                                Text(
                                  "\$${userMap['data'][index]['subtotal'].toString().substring(0, 5)}",
                                  style: TextStyle(fontWeight: FontWeight.w600),
                                ),
                                /*if (userMap['data'][index]
                                        ['transaction_type'] ==
                                    "null")*/
                                Text(
                                    "${userMap['data'][index]['transaction_type']}",
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: ColorsManager.COLOR_RED))
                              ]));
                        },
                      )),
                );
              }
              return Text("Loading......");
            },
          )),
          /*Expanded(child: FutureBuilder<RecentTransactionsModel?>(
            future: home.getHome(),
            builder: (
                BuildContext context,
                AsyncSnapshot<RecentTransactionsModel?> snapshot,
                ) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                  return const Text('Error');
                } else if (snapshot.hasData) {
                  RecentTransactionsModel? userInfo = snapshot.data;
                  print("Tickits=>${userInfo!.data!.first.id}");
                  return ListView.builder(
                      shrinkWrap: true,
                      itemCount: userInfo.data!.length,
                      itemBuilder: (BuildContext ctxt, int index) {
                        return ListTile(
                          leading: AvatarView(
                              radius: 24,
                              borderWidth: 1,
                              borderColor: ColorsManager.YELLOWBUTTON_COLOR,
                              avatarType: AvatarType.CIRCLE,
                              imagePath: "${userInfo.data![index].currencies!.logo==null?ImageManager.weCoin_logo:userInfo.data![index].currencies!.logo}",
                              placeHolder: Container(
                                  child: Image.asset(ImageManager.user_pro)
                              ),
                              errorWidget: CircularProgressIndicator()),
                          title: Text(userInfo.data![index].currencies!.name!),
                          subtitle: Text("${userInfo.data![index].currencies!.createdAt}",
                              style: TextStyle(
                                fontSize: 12.sp,
                                color: ColorsManager.COLOR_GRAY,
                              )),
                          trailing: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "\$${userInfo.data![index].subtotal!.substring(0,5)}",
                                style: TextStyle(fontWeight: FontWeight.w600),
                              ),
                              if(userInfo.data![index].status=="Pending")
                              Text( "${userInfo.data![index].status!}",
                                  style: TextStyle(fontSize: 12,  color: ColorsManager.COLOR_RED)),
                             */ /* if(userInfo.data![index].status=="Pending")
                                Text( "${userInfo.data![index].status!}",
                                    style: TextStyle(fontSize: 16,  color: ColorsManager.COLOR_BLACK)),*/ /*
                            ],
                          ),
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
*/
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
