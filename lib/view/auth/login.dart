import 'package:firebase_messaging/firebase_messaging.dart';
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
import '../../data/repositry/auth_repo.dart';
import '../../utils/image_manager.dart';
import 'forgot.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _formValidKey = GlobalKey<FormState>();
  bool obsecureText = false;
  final textFieldFocusNode = FocusNode();

  late FirebaseMessaging messaging;
  @override
  void initState() {
    super.initState();
    messaging = FirebaseMessaging.instance;
    messaging.getToken().then((value) async {
      print("Token   $value");
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      sharedPreferences.setString('token', "$value");
      print("Store Token ${sharedPreferences.getString('token')}");
    });
  }

  @override
  Widget build(BuildContext context) {
    final _sign_in = Provider.of<Auth_Provider>(context);
    return _sign_in.loading
        ? Scaffold(
            body: Center(child: CircularProgressIndicator()),
          )
        : Scaffold(
            bottomSheet: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 10),
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                    text: 'Don\'t have an account?',
                    style: TextStyle(color: Colors.black, fontSize: 18),
                    children: <TextSpan>[
                      TextSpan(
                          text: ' SIGN UP',
                          style:
                              TextStyle(color: Colors.blueAccent, fontSize: 18),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              // navigate to desired screen
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SignUpScreen()));
                            })
                    ]),
              ),
            ),
            body: Form(
              key: _formValidKey,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                    SizedBox(height: 20.h),
                    Text(
                      "Login",
                      style: TextStyle(
                          fontSize: 24.sp, fontWeight: FontWeight.bold),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 10),
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.only(top: 15, bottom: 30),
                            alignment: Alignment.center,
                            child: Text(
                              "Lorem Ipsum is simply dummy text of the \nprinting and typesetting industry.",
                              textAlign: TextAlign.center,
                              style: TextStyle(color: ColorsManager.TEXT_COLOR),
                            ),
                          ),
                          MyCustomTextField(
                            hint: "Email",
                            controller: emailController,
                            prefixIcon: Icon(Icons.email),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please a Enter Eamil';
                              }
                              if (!RegExp(
                                      "^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                                  .hasMatch(value)) {
                                return 'Please a valid Email';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 20),
                          MyPasswordTextFormField(
                            prefixIcon: Icon(Icons.lock),
                            kry: TextInputType.visiblePassword,
                            controller: passwordController,
                            hint: "Password",
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Enter a valid phone no!';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 70.h),
                          _sign_in.loading
                              ? CircularProgressIndicator(
                                  color: Colors.black,
                                )
                              : MyCustomButton(
                                  onPressedbtn: () {
                                    if (_formValidKey.currentState!
                                        .validate()) {
                                      print("successful");
                                      _sign_in.sign_in(
                                          context,
                                          emailController.text,
                                          passwordController.text);
                                      return;
                                    } else {
                                      print("UnSuccessfull");
                                    }
                                  },
                                  child: _sign_in.loading
                                      ? CircularProgressIndicator(
                                          color: Colors.white,
                                        )
                                      : Text("Login"),
                                  mergin: EdgeInsets.symmetric(
                                      horizontal: 0, vertical: 10),
                                ),
                          InkWell(
                            onTap: () => Get.to(ForgotScreen()),
                            child: Text(
                              "Forget Password?",
                              style: TextStyle(
                                  decoration: TextDecoration.underline),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
