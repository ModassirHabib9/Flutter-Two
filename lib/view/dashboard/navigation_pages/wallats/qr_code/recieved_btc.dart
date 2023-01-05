import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:we_coin/common_widget/my_custom_button.dart';
import 'package:we_coin/common_widget/my_custom_textfield.dart';

import '../../../../../utils/color_manager.dart';
import '../../../../../utils/image_manager.dart';

class RecievedBtcScreen extends StatelessWidget {
  const RecievedBtcScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            color: ColorsManager.APP_MAIN_COLOR,
            height: MediaQuery.of(context).size.height * 0.25,
            alignment: Alignment.center,
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 12.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AppBar(
                    backgroundColor: Colors.transparent,
                    automaticallyImplyLeading: false,
                    elevation: 0,
                    backwardsCompatibility: false,
                    foregroundColor: ColorsManager.WHITE_COLOR,
                    centerTitle: true,
                    leadingWidth: 30,
                    leading: InkWell(
                        onTap: () => Get.back(),
                        child: Icon(Icons.arrow_back_ios)),
                    title: Text("Recived Money"),
                    actions: []),
                SizedBox(height: 20.h),
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
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    ImageManager.Qr_View,
                    width: 202.w,
                    height: 202,
                  ),
                  SizedBox(height: 30),
                  Container(
                    height: 90,
                    child: Text(
                      "Only receive BTC to this address, receiving any other coin will result in permanent loss.",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 20.sp),
                    ),
                  ),
                  SizedBox(height: 30),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Recieving Address"),
                  ),
                  SizedBox(height: 10),
                  MyCustomTextField(
                    hint: 'asdsadsadsadsa',
                    suffixIcon: Icon(Icons.copy),
                  ),
                  MyCustomButton(
                    mergin: EdgeInsets.symmetric(
                        vertical: MediaQuery.of(context).size.height * 0.05),
                    onPressedbtn: () {},
                    text: 'Continue',
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
