import 'package:avatar_view/avatar_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:we_coin/view/dashboard/navigation_pages/home_page/home_page.dart';

import '../../data/model/view_profile_model.dart';
import '../../data/repositry/view_profile_get.dart';
import '../../utils/color_manager.dart';
import '../../utils/image_manager.dart';
import 'navigation_pages/profile/profile_page.dart';
import 'navigation_pages/recived_money/recived_money.dart';
import 'navigation_pages/send_money/send_money.dart';
import 'navigation_pages/transaction/transaction_page.dart';

class DrawerItem {
  String? title;
  Widget? icon;
  DrawerItem(this.title, this.icon);
}

class MyNavigationBar extends StatefulWidget {
  MyNavigationBar({Key? key}) : super(key: key);

  @override
  _MyNavigationBarState createState() => _MyNavigationBarState();
}

class _MyNavigationBarState extends State<MyNavigationBar> {
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    HomePageScreen(),
    TransactionNavigationPage(),
    SendMoneyPageScreen(),
    RecivedMoneyPageScreen(),
    // WallatPageScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  ViewProfile_Provider provider = ViewProfile_Provider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _selectedIndex == 0 || _selectedIndex == 1
          ? AppBar(
              backgroundColor: Colors.transparent,
              automaticallyImplyLeading: false,
              elevation: 0,
              backwardsCompatibility: false,
              foregroundColor: ColorsManager.COLOR_BLACK,
              centerTitle: true,
              leading: InkWell(
                  onTap: () => Scaffold.of(context).openDrawer(),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(ImageManager.drawer_icon),
                  )),
              title: Text(_selectedIndex == 1 || _selectedIndex == 2
                  ? "Transactions"
                  : "Dashboard"),
              actions: [
                  FutureBuilder<ViewProfileModel?>(
                    future: provider.getUser1(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        ViewProfileModel? userInfo = snapshot.data;
                        if (userInfo != null) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: InkWell(
                              onTap: () => Get.to(ProfilePageScreen()),
                              child: Container(
                                height: 40,
                                width: 40,
                                decoration:
                                    BoxDecoration(shape: BoxShape.circle),
                                child: AvatarView(
                                    radius: 24,
                                    borderWidth: 2,
                                    borderColor:
                                        ColorsManager.YELLOWBUTTON_COLOR,
                                    avatarType: AvatarType.CIRCLE,
                                    imagePath:
                                        "http://wecoin.pk/weCoinApp/uploads/${userInfo.data!.picture}",
                                    placeHolder: Container(
                                      child: Icon(
                                        Icons.person,
                                      ),
                                    ),
                                    errorWidget: CircularProgressIndicator()),
                              ),
                            ),
                          );
                        }
                      }
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CircleAvatar(
                          child: Image.asset(ImageManager.user_pro),
                        ),
                      );
                    },
                  ),
                ])
          : AppBar(
              backgroundColor: ColorsManager.APP_MAIN_COLOR,
              automaticallyImplyLeading: false,
              elevation: 0,
              backwardsCompatibility: false,
              foregroundColor: ColorsManager.WHITE_COLOR,
              centerTitle: true,
              leading: InkWell(
                  onTap: () => Scaffold.of(context).openDrawer(),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(
                      ImageManager.drawer_icon,
                      color: ColorsManager.WHITE_COLOR,
                    ),
                  )),
              title: Text(_selectedIndex == 3 ? "Wallets" : "Send Money"),
              actions: [
                  FutureBuilder<ViewProfileModel?>(
                    future: provider.getUser1(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        ViewProfileModel? userInfo = snapshot.data;
                        if (userInfo != null) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: InkWell(
                              onTap: () => Get.to(ProfilePageScreen()),
                              child: Container(
                                height: 40,
                                width: 40,
                                decoration:
                                    BoxDecoration(shape: BoxShape.circle),
                                child: AvatarView(
                                    radius: 24,
                                    borderWidth: 2,
                                    borderColor:
                                        ColorsManager.YELLOWBUTTON_COLOR,
                                    avatarType: AvatarType.CIRCLE,
                                    imagePath:
                                        "http://wecoin.pk/weCoinApp/uploads/${userInfo.data!.picture}",
                                    placeHolder: Container(
                                      child: Icon(
                                        Icons.person,
                                      ),
                                    ),
                                    errorWidget: CircularProgressIndicator()),
                              ),
                            ),
                          );
                        }
                      }
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                            onTap: () => Get.to(ProfilePageScreen()),
                            child: CircleAvatar(
                              child: Image.asset(ImageManager.user_pro),
                            )),
                      );
                    },
                  ),
                ]),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
          showUnselectedLabels: false,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Image.asset(
                  _selectedIndex == 0
                      ? ImageManager.bottom_black_one
                      : ImageManager.bottom_one,
                  height: 25),
              label: _selectedIndex == 0 ? 'Home' : '',
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                  _selectedIndex == 1
                      ? ImageManager.bottom_black_two
                      : ImageManager.bottom_two,
                  height: 25),
              label: _selectedIndex == 1 ? 'Transaction' : '',
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                  _selectedIndex == 2
                      ? ImageManager.bottom_black_three
                      : ImageManager.bottom_three,
                  height: 25),
              label: _selectedIndex == 2 ? 'Send' : '',
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                  _selectedIndex == 3
                      ? ImageManager.bottom_black_four
                      : ImageManager.bottom_four,
                  height: 25),
              label: _selectedIndex == 3 ? 'Wallets' : '',
            ),
            /*BottomNavigationBarItem(
              icon: Image.asset(
                  _selectedIndex == 4
                      ? ImageManager.bottom_black_five
                      : ImageManager.bottom_five,
                  height: 25),
              label: _selectedIndex == 4 ? 'Wallets ' : '',
            ),*/
          ],
          type: BottomNavigationBarType.fixed,
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.black,
          iconSize: 20,
          onTap: _onItemTapped,
          elevation: 5),
    );
  }
}
