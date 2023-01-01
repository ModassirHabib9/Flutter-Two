import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:cupertino_icons/cupertino_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:provider/provider.dart';
import 'package:we_coin/common_widget/my_custom_button.dart';
import 'package:we_coin/utils/color_manager.dart';
import 'package:we_coin/view/auth/sign_up.dart';

import '../../common_widget/my_custom_passwordfield.dart';
import '../../common_widget/my_custom_textfield.dart';
import '../../data/repositry/otp_verification.dart';
import '../../utils/image_manager.dart';
import 'identity_verification.dart';

class ResetPasswordScreen extends StatelessWidget {
  ResetPasswordScreen({Key? key}) : super(key: key);
  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController newConfirmpasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final _resetPassword = Provider.of<OtpVerified_Provider>(context);
    print("Build Reset password");
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.28,
                    width: double.infinity,
                    alignment: Alignment.center,
                    decoration: new BoxDecoration(
                        image: new DecorationImage(
                      image: new AssetImage(ImageManager.splash_bar),
                      fit: BoxFit.fill,
                    )),
                    child: SvgPicture.asset(ImageManager.app_name),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Reset Password",
                          style: TextStyle(
                              fontSize: 24.sp, fontWeight: FontWeight.bold),
                        ),
                        Container(
                          padding: EdgeInsets.only(top: 8, bottom: 10),
                          child: Text(
                            "Enter new password to access the account",
                            style: TextStyle(color: ColorsManager.TEXT_COLOR),
                          ),
                        ),
                        SizedBox(height: 55.h),
                        MyPasswordTextFormField(
                          prefixIcon: Icon(Icons.lock_outlined),
                          suffixIcon: Icon(Icons.visibility_outlined),
                          controller: oldPasswordController,
                          hint: "Old Password",
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Enter a valid password!';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 20.h),
                        MyPasswordTextFormField(
                          controller: newPasswordController,
                          prefixIcon: Icon(Icons.lock_outlined),
                          suffixIcon: Icon(Icons.visibility_outlined),
                          hint: "New Password",
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Enter a valid password!';
                            }
                            return null;
                          },
                        ),
                        // SizedBox(height: 20.w),
                        /*MyCustomTextField(
                          controller: newConfirmpasswordController,
                          suffixIcon: Icon(Icons.visibility_outlined),
                          prefixIcon: Icon(Icons.lock_outlined),
                          hint: "Confirm New Password",
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please re-enter Confirm Email';
                            }
                            // print(password.text);
                            // print(confirmpassword.text);
                            if (oldPasswordController !=
                                newConfirmpasswordController) {
                              return "Confirm Email Does Not Match";
                            }
                            return null;
                          },
                        ),*/
                        SizedBox(height: 70.h),
                      ],
                    ),
                  ),
                ],
              ),

              // SizedBox(height: 41.h),

              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MyCustomButton(
                    onPressedbtn: () async {
                      if (_formKey.currentState!.validate()) {
                        print("successful");
                        // _resetPassword.reset_password(
                        //   context,
                        //   oldPasswordController.text,
                        //   newPasswordController.text,
                        // );
                        Get.to(IdentityVerificationScreen());
                        return;
                      } else {
                        print("UnSuccessfull");
                      }
                    },
                    text: "Continue",
                    child: _resetPassword.loading
                        ? CircularProgressIndicator(
                            color: Colors.white,
                          )
                        : Text("Continue"),
                    mergin:
                        EdgeInsets.symmetric(horizontal: 20.w, vertical: 40.h),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
