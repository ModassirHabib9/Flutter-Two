import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:provider/provider.dart';
import 'package:we_coin/view/dashboard/navigation_pages/recived_money/qr_code/recieved_btc.dart';

import '../../../../data/model/currencies_model.dart';
import '../../../../data/model/wallets_model.dart';
import '../../../../data/repositry/currencies_get_repo.dart';
import '../../../../utils/color_manager.dart';
import '../../../../utils/image_manager.dart';
import '../profile/profile_page.dart';

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
    final viewProfile =
    Provider.of<CurrenciesProvider>(context, listen: false);
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
  }

  Future<Null> _handleRefresh() async {
    count++;
    print(count);
    final viewProfile =
    Provider.of<CurrenciesProvider>(context, listen: false);
    viewProfile.getWallets().then((res) async {
      _postsController!.add(res);
      showSnack();
      return null;
    });
  }

  @override
  Widget build(BuildContext context) {
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
                Text(
                  "Total  75021311\$",
                  style: TextStyle(
                      fontSize: 25.sp,
                      fontWeight: FontWeight.w600,
                      color: ColorsManager.WHITE_COLOR),
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
        child: StreamBuilder(
          stream: _postsController!.stream,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            print('Has error: ${snapshot.hasError}');
            print('Has data: ${snapshot.hasData}');
            print('Snapshot Data ${snapshot.data}');

            if (snapshot.hasError) {
              return Text("");
            }

            if (snapshot.hasData) {
              WalletsModel? userInfo = snapshot.data;
              return Column(
                children: <Widget>[
                  Expanded(
                    child: Scrollbar(
                      child: RefreshIndicator(
                          onRefresh: _handleRefresh,
                          child: ListView.builder(
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
                                                builder: (context) =>RecievedBtcScreen()));
                                      },
                                      child: Card(
                                        elevation: 10,
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(10)),
                                        child: ListTile(
                                          contentPadding: EdgeInsets.symmetric(
                                              horizontal: 12.0, vertical: 10),
                                          leading: CircleAvatar(
                                            radius: 20,
                                            backgroundImage: NetworkImage( "http://wecoin.pk/weCoinApp/uploads/${userInfo.data![index].currencies!.logo}",),
                                          ),
                                          title: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                                    "${userInfo.data![index].currencies!.rate!.substring(0,5)}",
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
                              })),
                    ),
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
        ),),

        ],
      ),
    );
  }
}
