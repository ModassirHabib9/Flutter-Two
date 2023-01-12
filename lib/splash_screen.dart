import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:we_coin/common_widget/my_custom_button.dart';
import 'package:we_coin/data/repositry/view_profile_get.dart';
import 'package:we_coin/utils/color_manager.dart';
import 'package:we_coin/utils/image_manager.dart';
import 'package:we_coin/view/auth/login.dart';
import 'package:we_coin/view/dashboard/drawer.dart';

import 'data/repositry/view_tickets_repo.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    Provider.of<ViewProfile_Provider>(context, listen: false).getUser1();
    return Scaffold(
      backgroundColor: ColorsManager.APP_MAIN_COLOR,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.40,
              width: double.infinity,
              alignment: Alignment.bottomCenter,
              decoration: new BoxDecoration(
                  image: new DecorationImage(
                image: new AssetImage(ImageManager.splash_bar),
                fit: BoxFit.fill,
              )),
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: Image.asset(ImageManager.splash_logo),
              ),
            ),
            SizedBox(height: 70),
            SvgPicture.asset(ImageManager.app_name),

            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "Lorem Ipsum is simply dummy text of the \nprinting and typesetting industry.",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: ColorsManager.WHITE_COLOR, fontSize: 16.sp),
              ),
            ),
            Spacer(),
            MyCustomButton(
              onPressedbtn: () async {
                final tikets =
                    Provider.of<ViewTickets_Provider>(context, listen: false);
                tikets.viewTickets();
                tikets.viewDispute();
                SharedPreferences prefs = await SharedPreferences.getInstance();
                print('Auth ID: ${prefs.getInt('id')}');
                Get.to(
                    prefs.getInt('id') == null ? LoginScreen() : Dashboard());
              },
              text: "Get Started",
            ),
            SizedBox(height: 30),
            // Image.asset(ImageManager.splash_logo),
          ],
        ),
      ),
    );
  }
}
