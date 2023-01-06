import 'dart:convert';

import 'package:avatar_view/avatar_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:we_coin/utils/image_manager.dart';

import '../../../../data/model/view_profile_model.dart';
import '../../../../data/repositry/view_profile_get.dart';
import '../../../../utils/color_manager.dart';
import '../../drawer.dart';
import 'edit_profile.dart';

class ProfilePageScreen extends StatefulWidget {
  static const String routeName = '/homePage';

  @override
  State<ProfilePageScreen> createState() => _ProfilePageScreenState();
}

class _ProfilePageScreenState extends State<ProfilePageScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final viewProfile =
        Provider.of<ViewProfile_Provider>(context, listen: false);
  }

  ViewProfileModel? profile;

  //
  @override
  Widget build(BuildContext context) {
    final viewProfile =
        Provider.of<ViewProfile_Provider>(context, listen: false);
    return Scaffold(
      body: FutureBuilder(
        future: Hive.openBox('viewProfile'),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final box = snapshot.data;
            // Get the data from the box
            final users = box!.get('name');
            final Map<String, dynamic> userMap = jsonDecode(users);
            if (userMap != null) {
              return Column(
                children: [
                  Expanded(
                    child: Stack(
                      alignment: Alignment.center,
                      children: <Widget>[
                        // background image and bottom contents
                        Container(
                          color: ColorsManager.WHITE_COLOR,
                          child: Column(
                            children: <Widget>[
                              Container(
                                  height: 160.0,
                                  color: ColorsManager.APP_MAIN_COLOR,
                                  child: Center(
                                      child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 12.w),
                                          child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                IconButton(
                                                    icon: Icon(
                                                      Icons.arrow_back_ios,
                                                      color: ColorsManager
                                                          .WHITE_COLOR,
                                                    ),
                                                    onPressed: () {
                                                      Navigator.pushReplacement(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  Dashboard()));
                                                    }
                                                    /* Scaffold.of(context)
                                                        .openDrawer(),*/
                                                    ),
                                                Text(
                                                  'My Profile',
                                                  style: TextStyle(
                                                      fontSize: 20.sp,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: ColorsManager
                                                          .WHITE_COLOR),
                                                ),
                                                InkWell(
                                                  onTap: () {
                                                    viewProfile.getUser1();
                                                    Get.to(
                                                        EditProfilePageScreen(
                                                      fullName: userMap['data']
                                                          ['full_name'],
                                                      picture: userMap['data']
                                                          ['picture'],
                                                      phone: userMap['data']
                                                          ['phone'],
                                                      email: userMap['data']
                                                          ['email'],
                                                      country: userMap['data']
                                                          ['country'],
                                                      state: userMap['data']
                                                          ['state'],
                                                      city: userMap['data']
                                                          ['city'],
                                                    ));
                                                  },
                                                  child: CircleAvatar(
                                                      child: Icon(Icons.edit,
                                                          color: ColorsManager
                                                              .WHITE_COLOR)),
                                                )
                                              ])))),
                              SizedBox(height: 25),
                              Expanded(
                                child: ListView(
                                  primary: false,
                                  children: [
                                    Container(
                                      child: Column(
                                        children: [
                                          Text(
                                            "${userMap['data']['full_name']}",
                                            style: TextStyle(
                                                fontSize: 20.sp,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          Text(
                                            "${userMap['data']['email']}",
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 10.h),
                                    Container(
                                      height: 45,
                                      width: double.infinity,
                                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),),
                                      margin: EdgeInsets.symmetric(horizontal: 10),
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 12.w),
                                      alignment: Alignment.centerLeft,

                                      child: Text("Personal Details"),
                                    ),
                                    Container(
                                        alignment: Alignment.centerLeft,
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 12.w, vertical: 10),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              height: 45,
                                              width: double.infinity,
                                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: const Color(0xFFF0F0F0),),
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 12.w),
                                              alignment: Alignment.centerLeft,

                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Text("Acount Verified"),
                                                  Text(
                                                    "Yes",
                                                    style: TextStyle(
                                                        fontSize: 12.sp,
                                                        ),
                                                  )
                                                ],
                                              ),
                                            ),
                                            SizedBox(height: 10),
                                            Container(
                                              height: 45,
                                              width: double.infinity,
                                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: const Color(0xFFF0F0F0),),
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 12.w),
                                              alignment: Alignment.centerLeft,

                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Text("State"),
                                                  Text(
                                                      "Islamabad"/*"${userMap['data']['state']}" == null
                                                          ? "Kpk"
                                                          : "${userMap['data']['state'].toString()}"*/)
                                                ],
                                              ),
                                            ),
                                            SizedBox(height: 10),
                                            Container(
                                              height: 45,
                                              width: double.infinity,
                                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: const Color(0xFFF0F0F0),),
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 12.w),
                                              alignment: Alignment.centerLeft,

                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Text("City"),
                                                  Text(
                                                    /*  "${userMap['data']['city']}" == null
                                                          ?*/ "Islamabad"
                                                          /*: "${userMap['data']['city']}"
                                                          .toString()*/)
                                                ],
                                              ),
                                            ),
                                            SizedBox(height: 10),
                                            Container(
                                              height: 45,
                                              width: double.infinity,
                                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: const Color(0xFFF0F0F0),),
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 12.w),
                                              alignment: Alignment.centerLeft,

                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Text("Country"),
                                                  Text(
                                                    "${userMap['data']['country']}")
                                                ],
                                              ),
                                            ),
                                            SizedBox(height: 10),
                                            Container(
                                              height: 45,
                                              width: double.infinity,
                                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: const Color(0xFFF0F0F0),),
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 12.w),
                                              alignment: Alignment.centerLeft,

                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Text("Phone"),
                                                  Text(
                                                      "${userMap['data']['phone']}")
                                                ],
                                              ),
                                            ),
                                            SizedBox(height: 10),
                                            Container(
                                              height: 45,
                                              width: double.infinity,
                                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: const Color(0xFFF0F0F0),),
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 12.w),
                                              alignment: Alignment.centerLeft,

                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Text("Time Zone"),
                                                  Text("GMT")
                                                ],
                                              ),
                                            ),
                                          ],
                                        )),
                                    /*Container(
                                      height: 45,
                                      width: double.infinity,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 12.w),
                                      alignment: Alignment.centerLeft,
                                      color: ColorsManager.COLOR_GRAY,
                                      child: Text("Personal Details"),
                                    ),*/
                                    /// show two identity
                                    /*Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          Container(
                                            height: 80,
                                            width: 138,
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10.r),
                                                color: ColorsManager
                                                    .COLOR_CONTAINER),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Icon(Icons.badge),
                                                Text("Identity Card"),
                                              ],
                                            ),
                                          ),
                                          SizedBox(width: 10),
                                          Container(
                                            height: 80,
                                            width: 138,
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10.r),
                                                color: ColorsManager
                                                    .COLOR_CONTAINER),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Icon(Icons.badge),
                                                Text("Identity Card"),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    )*/
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        // Profile image
                        Positioned(
                            top:
                                110.0, // (background container size) - (circle height / 2)
                            child: Container(
                                alignment: Alignment.center,
                                height: 100.0,
                                width: 100.0,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.grey[300],
                                ),
                                child: AvatarView(
                                    // radius: 24,
                                    borderWidth: 2,
                                    borderColor:
                                    ColorsManager.YELLOWBUTTON_COLOR,
                                    avatarType: AvatarType.CIRCLE,
                                    imagePath:
                                    ImageManager.user_pro,
                                    placeHolder: Container(
                                      child: Icon(
                                        Icons.person,
                                      ),
                                    ),
                                    errorWidget: CircularProgressIndicator()),/*Container(
                                  decoration: BoxDecoration(
                                      image: new DecorationImage(
                                        image: new NetworkImage(
                                            // image null check karna ha or default image set karna ha
                                            "http://wecoin.pk/weCoinApp/uploads/${userMap['data']['state']}" ==
                                                    null
                                                ? "http://wecoin.pk/weCoinApp/uploads/1670930151699_2ls56vakwfo.png"
                                                : "http://wecoin.pk/weCoinApp/uploads/${userMap['data']['state']}"),
                                        fit: BoxFit.cover,
                                      ),
                                      borderRadius:
                                          BorderRadius.circular(50.0)),
                                )*/)),
                      ],
                    ),
                  ),
                ],
              );
            }
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
