import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:quickalert/quickalert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:we_coin/splash_screen.dart';
import 'package:we_coin/utils/image_manager.dart';
import 'package:we_coin/view/dashboard/navigation_pages/profile/profile_page.dart';
import 'package:we_coin/view/dashboard/privacy/privacy.dart';
import 'package:we_coin/view/dashboard/settings/settings.dart';

import '../../utils/color_manager.dart';
import 'about_us/about_us.dart';
import 'navbar.dart';
import 'navigation_pages/deposit/deposit.dart';
import 'navigation_pages/dispute/dispute.dart';
import 'navigation_pages/notification/notification.dart';
import 'navigation_pages/tickets/tickets.dart';

class DrawerItem {
  String? title;
  Widget? icon;
  DrawerItem(this.title, this.icon);
}

class Dashboard extends StatefulWidget {
  final drawerItems = [
    new DrawerItem(
        "Home",
        Icon(
          Icons.home,
          color: ColorsManager.COLOR_BLACK,
          size: 20,
        )),
    new DrawerItem(
        "My Profiles",
        Image.asset(
          ImageManager.drawer_one,
          height: 20,
          width: 20,
        )),
    new DrawerItem(
        "Notification",
        Icon(
          Icons.search,
          color: ColorsManager.COLOR_BLACK,
          size: 20,
        )),
    /*new DrawerItem(
        "Send Money",
        Image.asset(
          ImageManager.drawer_four,
          height: 20,
          width: 20,
        )),
    new DrawerItem(
        "Recive Money",
        Image.asset(
          ImageManager.drawer_two,
          height: 20,
          width: 20,
        )),*/
    new DrawerItem(
        "Tickets",
        Image.asset(
          ImageManager.drawer_five,
          height: 20,
          width: 20,
        )),
    new DrawerItem(
        "Deposit",
        Icon(
          Icons.error_outline_outlined,
          color: ColorsManager.COLOR_BLACK,
          size: 20,
        )),
    new DrawerItem(
        "Dispute",
        Image.asset(
          ImageManager.bottom_black_four,
          color: ColorsManager.COLOR_BLACK,
          height: 20,
          width: 20,
        )),
    /*new DrawerItem(
        "Setting",
        Icon(
          Icons.settings,
          color: ColorsManager.COLOR_BLACK,
          size: 20,
        )),
    new DrawerItem(
        "Privacy",
        Icon(
          Icons.privacy_tip,
          color: ColorsManager.COLOR_BLACK,
          size: 20,
        )),
    new DrawerItem(
        "About Us",
        Icon(
          Icons.add_circle_outline,
          color: ColorsManager.COLOR_BLACK,
          size: 20,
        )),*/
  ];

  @override
  State<StatefulWidget> createState() {
    return new DashboardState();
  }
}

class DashboardState extends State<Dashboard> {
  int _selectedDrawerIndex = 0;

  _getDrawerItemWidget(int pos) {
    switch (pos) {
      case 0:
        return MyNavigationBar();
      case 1:
        return new ProfilePageScreen();
      case 2:
        return new NotificationPageScreen();
      /*case 3:
        return new SendMoneyPageScreen();
      case 4:
        return new RecivedMoneyPageScreen();*/
      case 3:
        return new TicketsPageScreen();
      case 4:
        return new DepositPageScreen();
      case 5:
        return new DisputedPageScreen();
        break;
      /*case 6:
        return new SettingScreen();
      case 7:
        return new PrivacyScreen();
      case 8:
        return new AboutUsScreen();*/

      default:
        return new Text("Error");
    }
  }

  _onSelectItem(int index) {
    setState(() => _selectedDrawerIndex = index);
    Navigator.of(context).pop(); // close the drawer
  }

  @override
  Widget build(BuildContext context) {
    var drawerOptions = <Widget>[];
    for (var i = 0; i < widget.drawerItems.length; i++) {
      var d = widget.drawerItems[i];

      drawerOptions.add(ListTile(
        visualDensity: VisualDensity(horizontal: 0, vertical: -4),
        dense: true,
        minLeadingWidth: 20,
        leading: d.icon ?? null,
        title: new Text(
          d.title!,
          style: TextStyle(fontSize: 16.sp),
        ),
        selected: i == _selectedDrawerIndex,
        onTap: () => _onSelectItem(i),
      ));
    }

    final GlobalKey<ScaffoldState> _scaffoldKey =
        new GlobalKey<ScaffoldState>();
    return Scaffold(
        drawer: new Drawer(
          child: new Column(
            children: <Widget>[
              Container(
                height: 230,
                width: double.infinity,
                color: ColorsManager.APP_MAIN_COLOR,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 50),
                    SizedBox(
                      height: 50,
                      child: IconButton(
                        icon: Icon(Icons.arrow_back_ios,
                            color: ColorsManager.WHITE_COLOR),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: SvgPicture.asset(ImageManager.app_name),
                    ),
                  ],
                ),
              ),
              new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(children: drawerOptions),
                    SizedBox(height: 20),
                    Divider(height: 10),
                    SizedBox(height: 10),
                    ListTile(
                      dense: true,
                      onTap: () async {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SettingScreen()));
                      },
                      minLeadingWidth: 20,
                      visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                      leading: Text("Setting",
                          style: TextStyle(
                              fontSize: 16.sp,
                              color: ColorsManager.DRAWER_COLOR_GRAY)),
                    ),
                    SizedBox(height: 10),
                    ListTile(
                      dense: true,
                      onTap: () async {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PrivacyScreen()));
                      },
                      minLeadingWidth: 20,
                      visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                      leading: Text("Privacy",
                          style: TextStyle(
                              fontSize: 16.sp,
                              color: ColorsManager.DRAWER_COLOR_GRAY)),
                    ),
                    SizedBox(height: 10),
                    ListTile(
                      dense: true,
                      onTap: () async {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AboutUsScreen()));
                      },
                      minLeadingWidth: 20,
                      visualDensity: VisualDensity(horizontal: 4, vertical: -4),
                      leading: Text("About Us",
                          style: TextStyle(
                              fontSize: 16.sp,
                              color: ColorsManager.DRAWER_COLOR_GRAY)),
                    ),
                    SizedBox(height: 10),
                    ListTile(
                      dense: true,
                      onTap: () async {
                        showAlertDialog(context);
                      },
                      minLeadingWidth: 20,
                      visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                      leading: Text("Logout",
                          style: TextStyle(
                              fontSize: 16.sp,
                              color: ColorsManager.DRAWER_COLOR_GRAY)),
                    ),
                  ])
            ],
          ),
        ),

        // body: pages[activeIndex],
        body: _getDrawerItemWidget(_selectedDrawerIndex));
  }

  showAlertDialog(BuildContext context) {
    QuickAlert.show(
        context: context,
        type: QuickAlertType.warning,
        cancelBtnText: "Cancel",
        title: "Are You Sure",
        text: "Are you sure to delete this",
        confirmBtnText: "Confirm",
        backgroundColor: Colors.transparent,
        barrierColor: Colors.transparent,
        showCancelBtn: true,
        onCancelBtnTap: () {
          Navigator.pop(context);
        },
        confirmBtnColor: ColorsManager.YELLOWBUTTON_COLOR,
        onConfirmBtnTap: () async {
          SharedPreferences preferences = await SharedPreferences.getInstance();
          await preferences.remove('token');
          await preferences.clear();
          print(preferences.getString('token'));
          print("===> Remove ${preferences.remove('token')}");
          Hive.box('viewProfile').clear();
          Hive.box('viewDispute').clear();
          Hive.box('viewTickets').clear();

          final pro = Hive.box('viewProfile');
          print(pro);

          Get.to(SplashScreen());
        });
  }

  Future<void> _deleteCacheDir() async {
    Directory tempDir = await getTemporaryDirectory();
    if (tempDir.existsSync()) {
      tempDir.deleteSync(recursive: true);
    }
  }

  Future<void> _deleteAppDir() async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    if (appDocDir.existsSync()) {
      appDocDir.deleteSync(recursive: true);
    }
  }
}
