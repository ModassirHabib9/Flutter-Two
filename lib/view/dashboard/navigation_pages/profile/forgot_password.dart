import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:provider/provider.dart';
import 'package:we_coin/common_widget/my_custom_button.dart';
import 'package:we_coin/common_widget/my_custom_textfield.dart';
import 'package:we_coin/utils/color_manager.dart';

import '../../../../common_widget/my_custom_passwordfield.dart';
import '../../../../data/repositry/otp_verification.dart';

class ForgotPasswordPageScreen extends StatelessWidget {
  ForgotPasswordPageScreen({Key? key}) : super(key: key);

  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController newConfirmpasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final _resetPassword = Provider.of<OtpVerified_Provider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorsManager.APP_MAIN_COLOR,
        toolbarHeight: 118,
        elevation: 0,
        centerTitle: true,
        automaticallyImplyLeading: false,
        backwardsCompatibility: false,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () => Get.back(),
        ),
        title: Text("Update Password"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 40.h),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              MyPasswordTextFormField(
                hint: "Current Password",
                controller: oldPasswordController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Enter a valid password!';
                  }
                  return null;
                },
              ),
              SizedBox(height: 15.h),
              MyPasswordTextFormField(
                hint: "New Password",
                controller: newPasswordController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please a Enter Password';
                  }
                  return null;
                },
              ),
              SizedBox(height: 15.h),
              MyPasswordTextFormField(
                controller: newConfirmpasswordController,
                suffixIcon: Icon(Icons.visibility_outlined),
                prefixIcon: Icon(Icons.lock_outlined),
                hint: "Confirm New Password",
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please re-enter password';
                  }
                  // print(password.text);
                  // print(confirmpassword.text);
                  if (newPasswordController.text !=
                      newConfirmpasswordController.text) {
                    return "Password Does Not Match";
                  }
                  return null;
                },
              ),
              SizedBox(height: 130.h),
              MyCustomButton(
                mergin: EdgeInsets.zero,
                onPressedbtn: () async {
                  if (_formKey.currentState!.validate()) {
                    print("successful");
                    _resetPassword.reset_password(
                      context,
                      oldPasswordController.text,
                      newPasswordController.text,
                    );
                    return;
                  } else {
                    print("UnSuccessfull");
                  }
                },
                child: _resetPassword.loading
                    ? CircularProgressIndicator(
                        color: Colors.white,
                      )
                    : Text("Update Now"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
