import 'package:flutter/material.dart';
import 'package:cupertino_icons/cupertino_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:we_coin/utils/image_manager.dart';

import '../../../../utils/color_manager.dart';
import '../../drawer.dart';

class NotificationPageScreen extends StatefulWidget {
  static const String routeName = '/eventPage';
  const NotificationPageScreen({Key? key}) : super(key: key);

  @override
  State<NotificationPageScreen> createState() => _NotificationPageScreenState();
}

class _NotificationPageScreenState extends State<NotificationPageScreen> {
  ///bottom Grid
  List<String> _text2 = [
    'Notification Title',
    'Notification Title',
    'Notification Title'
  ];
  List<String> list2 = [
    ImageManager.notification_bill,
    ImageManager.notification_bill,
    ImageManager.notification_bill
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: ColorsManager.APP_MAIN_COLOR,
          automaticallyImplyLeading: false,
          toolbarHeight: 118,
          elevation: 0,
          backwardsCompatibility: false,
          foregroundColor: ColorsManager.WHITE_COLOR,
          centerTitle: true,
          leading: InkWell(
              onTap: () => Scaffold.of(context).openDrawer(),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(Icons.arrow_back_ios_new),
              )),
          title: Text("Notification"),
          actions: [
            Padding(
                padding: const EdgeInsets.all(8.0), child: Icon(Icons.search))
          ]),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                shrinkWrap: false,
                children: List.generate(
                  list2.length,
                  (index) => InkWell(
                      onTap: () {},
                      child: Card(
                        elevation: 10,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        child: ListTile(
                            visualDensity:
                                VisualDensity(horizontal: 4, vertical: -4),
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 8.0, vertical: 20),
                            leading: Image.asset(
                              list2[index],
                              width: 40,
                              height: 50,
                              fit: BoxFit.fitWidth,
                            ),
                            subtitle: Text(
                                "Lorem Ipsum is simply dummy text of the printing and typesetting industry."),
                            title: Container(
                                alignment: Alignment.centerLeft,
                                padding: EdgeInsets.symmetric(vertical: 6.0),
                                child: Text(
                                  _text2[index],
                                  textDirection: TextDirection.rtl,
                                  softWrap: true,
                                  style: TextStyle(
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.w600),
                                ))),
                      )),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
