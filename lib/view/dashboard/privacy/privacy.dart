import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:we_coin/utils/color_manager.dart';

class PrivacyScreen extends StatelessWidget {
  PrivacyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              height: MediaQuery.of(context).size.height * 0.15,
              color: ColorsManager.APP_MAIN_COLOR,
              alignment: Alignment.center,
              child: Padding(
                  padding: EdgeInsets.only(left: 12.w, right: 12.w, top: 40.h),
                  child: Column(
                    children: [
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            IconButton(
                              onPressed: () => Navigator.pop(context),
                              /*       Scaffold.of(context).openDrawer(),*/
                              icon: Icon(
                                Icons.arrow_back_ios,
                                color: ColorsManager.WHITE_COLOR,
                              ),
                            ),
                            Text('Privacy',
                                style: TextStyle(
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.w600,
                                    color: ColorsManager.WHITE_COLOR)),
                            Text(
                              "             ",
                              style: TextStyle(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w600,
                                  color: ColorsManager.COLOR_GRAY),
                            ),
                          ]),
                    ],
                  ))),
          SizedBox(height: 10),
          Expanded(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Adipiscing vitae proin sagittis nisl rhoncus mattis rhoncus urna",
                style: style,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            child: Text(
              "Log Data",
              style: heading_style,
            ),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Adipiscing vitae proin sagittis nisl rhoncus mattis rhoncus urna",
                style: style,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            child: Text(
              "Cookies",
              style: heading_style,
            ),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Adipiscing vitae proin sagittis nisl rhoncus mattis rhoncus urna",
                style: style,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            child: Text(
              "Changes to this Privacy Policy",
              style: heading_style,
            ),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Adipiscing vitae proin sagittis nisl rhoncus mattis rhoncus urna",
                style: style,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            child: Text(
              "Contact Us",
              style: heading_style,
            ),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Adipiscing vitae proin sagittis nisl rhoncus mattis rhoncus urna",
                style: style,
              ),
            ),
          ),
        ],
      ),
    );
  }

  final style = TextStyle(
      fontWeight: FontWeight.w300,
      fontSize: 16.sp,
      color: ColorsManager.APP_MAIN_COLOR);
  final heading_style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 20.sp,
      color: ColorsManager.APP_MAIN_COLOR);
}
