import 'dart:async';

import 'package:avatar_view/avatar_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:provider/provider.dart';
import 'package:we_coin/view/dashboard/navigation_pages/send_money/send_money_2.dart';

import '../../../../data/model/currencies_model.dart';
import '../../../../data/repositry/currencies_get_repo.dart';
import '../../../../data/repositry/view_profile_get.dart';
import '../../../../utils/color_manager.dart';

class SendMoneyPageScreen extends StatefulWidget {
  static const String routeName = '/profilePage';
  const SendMoneyPageScreen({Key? key}) : super(key: key);

  @override
  State<SendMoneyPageScreen> createState() => _SendMoneyPageScreenState();
}

class _SendMoneyPageScreenState extends State<SendMoneyPageScreen> {
  StreamController? _postsController;
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  int count = 1;

  loadPosts() async {
    final viewProfile = Provider.of<CurrenciesProvider>(context, listen: false);
    viewProfile.getCurrencies().then((res) async {
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
    final viewProfile = Provider.of<CurrenciesProvider>(context, listen: false);
    viewProfile.getCurrencies().then((res) async {
      _postsController!.add(res);
      showSnack();
      return null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final viewProfile = Provider.of<CurrenciesProvider>(context, listen: false);
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
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
                  "\$75021311",
                  style: TextStyle(
                      fontSize: 25.sp,
                      fontWeight: FontWeight.w600,
                      color: ColorsManager.WHITE_COLOR),
                ),
                SizedBox(height: 5.h),
                Text(
                  "Cuurent Balance",
                  style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                      color: ColorsManager.COLOR_GRAY),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: Column(
              children: [
                SizedBox(height: 40.h),
                Text("Please Select Money"),
                SizedBox(height: 10.h),
                Container(
                  height: MediaQuery.of(context).size.height * 0.55,
                  child: StreamBuilder(
                    stream: _postsController!.stream,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        CurrenciesModel? userInfo = snapshot.data;
                        if (userInfo != null) {
                          return Scrollbar(
                            child: RefreshIndicator(
                              onRefresh: _handleRefresh,
                              child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: userInfo.data!.length,
                                  itemBuilder: (BuildContext ctxt, int index) {
                                    return InkWell(
                                      onTap: () {
                                        final viewProfile =
                                            Provider.of<ViewProfile_Provider>(
                                                context,
                                                listen: false);
                                        viewProfile.getUser1();
                                        Get.to(SendMoney_2Screen(coinName: userInfo.data![index].name));
                                      },
                                      child: Card(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: ListTile(
                                            visualDensity:
                                                VisualDensity(vertical: 4),
                                            leading: CircleAvatar(
                                              child: AvatarView(
                                                  radius: 24,
                                                  borderWidth: 2,
                                                  borderColor: ColorsManager
                                                      .YELLOWBUTTON_COLOR,
                                                  avatarType: AvatarType.CIRCLE,
                                                  imagePath:
                                                      "http://wecoin.pk/weCoinApp/uploads/${userInfo.data![index].logo}",
                                                  placeHolder: Container(
                                                    child: Icon(
                                                      Icons.person,
                                                    ),
                                                  ),
                                                  errorWidget:
                                                      CircularProgressIndicator()),
                                            ),
                                            title: Text(
                                                "${userInfo.data![index].name == null ? "Empty" : userInfo.data![index].name}"),
                                            trailing: Text(
                                                "${userInfo.data![index].rate.toString() + " " + userInfo.data![index].symbol!}"),
                                          )),
                                    );
                                  }),
                            ),
                          );
                        }
                      }
                      return Center(child: CircularProgressIndicator());
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
