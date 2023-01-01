import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_picker_dropdown.dart';
import 'package:country_pickers/utils/utils.dart';
import 'package:csc_picker/csc_picker.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:cupertino_icons/cupertino_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:we_coin/common_widget/my_custom_button.dart';
import 'package:we_coin/utils/color_manager.dart';
import 'package:we_coin/view/auth/login.dart';

import '../../common_widget/my_custom_passwordfield.dart';
import '../../common_widget/my_custom_textfield.dart';
import '../../data/repositry/auth_repo.dart';
import '../../utils/image_manager.dart';

class SignUpScreen extends StatefulWidget {
  SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  String countryValue = "";
  String stateValue = "";
  String cityValue = "";
  String address = "";

  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    GlobalKey<CSCPickerState> _cscPickerKey = GlobalKey();
    final _sign_up = Provider.of<Auth_Provider>(context);
    return _sign_up.loading
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
                    text: 'Already have account?',
                    style: TextStyle(color: Colors.black, fontSize: 18),
                    children: <TextSpan>[
                      TextSpan(
                          text: ' SIGN IN',
                          style:
                              TextStyle(color: Colors.blueAccent, fontSize: 18),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              // navigate to desired screen
                              Get.to(LoginScreen());
                            })
                    ]),
              ),
            ),
            body: SingleChildScrollView(
              padding: EdgeInsets.symmetric(vertical: 40),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Text(
                      "Create new account",
                      style: TextStyle(
                          fontSize: 24.sp, fontWeight: FontWeight.bold),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 15, bottom: 40),
                      alignment: Alignment.center,
                      child: Text(
                        "Lorem Ipsum is simply dummy text of the \nprinting and typesetting industry.",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: ColorsManager.TEXT_COLOR),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Column(
                        children: [
                          MyCustomTextField(
                            hint: "Full Name",
                            controller: fullNameController,
                            prefixIcon: Icon(Icons.person),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Enter a valid name!';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 25),
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
                          SizedBox(height: 25),
                          MyPasswordTextFormField(
                            controller: passwordController,
                            prefixIcon: Icon(Icons.lock),
                            hint: "Password",
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Enter a valid password!';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 25),
                          Row(
                            children: [
                              Expanded(
                                  child: Container(
                                      decoration: BoxDecoration(
                                          color: Color(0xFFF0F0F0),
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(10),
                                              bottomLeft: Radius.circular(10))),
                                      child: CountryPickerDropdown(
                                        initialValue: 'Pk',
                                        iconSize: 0,
                                        itemBuilder: _buildDropdownItem,
                                        // itemFilter: ['AR', 'DE', 'GB', 'CN'].contains(c.isoCode),
                                        priorityList: [
                                          CountryPickerUtils
                                              .getCountryByIsoCode('GB'),
                                          CountryPickerUtils
                                              .getCountryByIsoCode('CN'),
                                        ],
                                        sortComparator:
                                            (Country? a, Country b) =>
                                                a!.isoCode.compareTo(b.isoCode),
                                        onValuePicked: (Country country) {
                                          print("${country.name}");
                                        },
                                      ))),
                              Expanded(
                                  flex: 2,
                                  child: MyCustomTextField(
                                    controller: phoneController,
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(10),
                                      bottomRight: Radius.circular(10),
                                    ),
                                    // prefixIcon: Icon(Icons.phone),
                                    hint: "33515117171",
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Enter a valid phone no!';
                                      }
                                      return null;
                                    },
                                  )),
                            ],
                          ),
                          SizedBox(height: 25),
                          Container(
                            child: CSCPicker(
                              showStates: false,
                              showCities: false,
                              flagState: CountryFlag.ENABLE,
                              defaultCountry: DefaultCountry.Pakistan,

                              ///Dropdown box decoration to style your dropdown selector [OPTIONAL PARAMETER] (USE with disabledDropdownDecoration)
                              dropdownDecoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  color: const Color(0xFFF0F0F0),
                                  border: Border.all(
                                      color: const Color(0xFFF0F0F0),
                                      width: 4.5)),

                              ///Disabled Dropdown box decoration to style your dropdown selector [OPTIONAL PARAMETER]  (USE with disabled dropdownDecoration)
                              disabledDropdownDecoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  color: const Color(0xFFF0F0F0),
                                  border: Border.all(
                                      color: const Color(0xFFF0F0F0),
                                      width: 4.5)),

                              ///placeholders for dropdown search field
                              countrySearchPlaceholder: "$countryValue",

                              ///labels for dropdown
                              countryDropdownLabel: "$countryValue",

                              selectedItemStyle: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                              ),

                              ///DropdownDialog Heading style [OPTIONAL PARAMETER]
                              dropdownHeadingStyle: TextStyle(
                                  color: Colors.black,
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold),

                              ///DropdownDialog Item style [OPTIONAL PARAMETER]
                              dropdownItemStyle: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                              ),
                              dropdownDialogRadius: 10.0,
                              searchBarRadius: 10.0,

                              onCountryChanged: (value) {
                                setState(() async {
                                  ///store value in country variable
                                  // store country value in shared Prefrence
                                  SharedPreferences sp =
                                      await SharedPreferences.getInstance();

                                  countryValue = value;
                                  sp.setString('country', countryValue);
                                  print(
                                      "Store Country value ${sp.getString('country')}");
                                });
                              },
                            ),
                          ),
                          SizedBox(height: 25),
                          SizedBox(height: 40.h),
                          MyCustomButton(
                            onPressedbtn: () {
                              if (_formKey.currentState!.validate()) {
                                print("successful");
                                _sign_up.sign_up(
                                    context,
                                    fullNameController.text,
                                    emailController.text,
                                    phoneController.text,
                                    passwordController.text,
                                    countryValue);

                                return;
                              } else {
                                print("UnSuccessfull");
                              }
                            },
                            child: Text("Register"),
                            mergin: EdgeInsets.symmetric(
                                horizontal: 0, vertical: 10),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10.h),
                    SizedBox(height: 10.h),
                  ],
                ),
              ),
            ),
          );
  }
}

Widget _buildDropdownItem(Country country) => Container(
      child: Padding(
          padding: EdgeInsets.only(left: 5),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CountryPickerUtils.getDefaultFlagImage(country),
              Text(
                "+${country.phoneCode}",
                textAlign: TextAlign.center,
              ),
            ],
          )),
    );
