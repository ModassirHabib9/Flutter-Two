import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';

import '../../../../utils/color_manager.dart';
import '../../../../utils/image_manager.dart';
import 'open_ticket.dart';

class ViewTickitsScreen extends StatelessWidget {
  const ViewTickitsScreen({Key? key}) : super(key: key);

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
                        height: MediaQuery.of(context).size.height * 0.25,
                        color: ColorsManager.APP_MAIN_COLOR,
                        alignment: Alignment.topCenter,
                        child: Padding(
                            padding: EdgeInsets.only(
                                left: 12.w, right: 12.w, top: 30.h),
                            child: Column(
                              children: [
                                Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      IconButton(
                                        onPressed: () => Get.back(),
                                        icon: Icon(
                                          Icons.arrow_back_ios,
                                          color: ColorsManager.WHITE_COLOR,
                                        ),
                                      ),
                                      Text(
                                        'View Ticket',
                                        style: TextStyle(
                                            fontSize: 20.sp,
                                            fontWeight: FontWeight.w600,
                                            color: ColorsManager.WHITE_COLOR),
                                      ),
                                      Text(
                                        "             ",
                                        style: TextStyle(
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.w600,
                                            color: ColorsManager.COLOR_GRAY),
                                      ),
                                    ]),
                                SizedBox(height: 20.h),
                              ],
                            ))),
                  ],
                ),
                // transaction View table
                Positioned(
                  left: 0,
                  right: 0,
                  top: MediaQuery.of(context).size.height *
                      0.15, // (background container size) - (circle height / 2)
                  child: Container(
                    // height: MediaQuery.of(context).size.height * 0.25,
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(horizontal: 12.0),
                    child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.r)),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 26.w, vertical: 30.h),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Ticket ID",
                                    style: TextStyle(
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w400,
                                        color: ColorsManager.COLOR_GRAY),
                                  ),
                                  Text(
                                    "54a5s4a5s45",
                                    style: TextStyle(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w600,
                                        color: ColorsManager.COLOR_BLACK),
                                  ),
                                ],
                              ),
                              SizedBox(height: 24.h),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Type",
                                    style: TextStyle(
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w400,
                                        color: ColorsManager.COLOR_GRAY),
                                  ),
                                  Text(
                                    "Send",
                                    style: TextStyle(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w600,
                                        color: ColorsManager.COLOR_BLACK),
                                  ),
                                ],
                              ),
                              SizedBox(height: 24.h),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "From",
                                    style: TextStyle(
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w400,
                                        color: ColorsManager.COLOR_GRAY),
                                  ),
                                  Text(
                                    "5415a1d51a5d1a",
                                    style: TextStyle(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w600,
                                        color: ColorsManager.COLOR_BLACK),
                                  ),
                                ],
                              ),
                              SizedBox(height: 24.h),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "To",
                                    style: TextStyle(
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w400,
                                        color: ColorsManager.COLOR_GRAY),
                                  ),
                                  Text(
                                    "da54ad54a5dadad",
                                    style: TextStyle(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w600,
                                        color: ColorsManager.COLOR_BLACK),
                                  ),
                                ],
                              ),
                              SizedBox(height: 24.h),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Amountt",
                                    style: TextStyle(
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w400,
                                        color: ColorsManager.COLOR_GRAY),
                                  ),
                                  Text(
                                    "0.2121515 BTC",
                                    style: TextStyle(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w600,
                                        color: ColorsManager.COLOR_BLACK),
                                  ),
                                ],
                              ),
                              SizedBox(height: 24.h),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Status",
                                    style: TextStyle(
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w400,
                                        color: ColorsManager.COLOR_GRAY),
                                  ),
                                  InkWell(
                                    onTap: () => Get.to(OpenTicketScreen()),
                                    child: Text(
                                      "Open",
                                      style: TextStyle(
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w600,
                                          color:
                                              ColorsManager.YELLOWBUTTON_COLOR),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )),
                  ),
                ),
              ],
            ),
          ),
          Image.asset(
            ImageManager.view_tickits,
            height: MediaQuery.of(context).size.height * 0.40,
          )
        ],
      ),
    );
  }
}
