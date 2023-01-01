import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:getwidget/components/checkbox/gf_checkbox.dart';
import 'package:getwidget/size/gf_size.dart';
import 'package:getwidget/types/gf_checkbox_type.dart';
import 'package:provider/provider.dart';
import 'package:we_coin/common_widget/my_custom_button.dart';
import 'package:we_coin/common_widget/my_custom_textfield.dart';
import 'package:we_coin/view/dashboard/settings/widget/card_four.dart';
import 'package:we_coin/view/dashboard/settings/widget/card_three.dart';

import '../../../data/model/setting_activity_model.dart';
import '../../../data/model/setting_notification_model.dart';
import '../../../data/repositry/settings_repo.dart';
import '../../../utils/color_manager.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  bool? isChecked;
  var data = [
    'I receive marketing options for my account',
    'I send or receive crypto',
    'I receive merchant orders',
    'There are recommended actions for my account'
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final viewProfile = Provider.of<SettingsProvider>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    final viewProfile = Provider.of<SettingsProvider>(context, listen: false);
    return Scaffold(
      body: Column(
        children: [
          Container(
              height: MediaQuery.of(context).size.height * 0.17,
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
                              /*Scaffold.of(context).openDrawer(),*/
                              icon: Icon(
                                Icons.arrow_back_ios,
                                color: ColorsManager.WHITE_COLOR,
                              ),
                            ),
                            Text('Settings',
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
                      SizedBox(height: 20.h),
                    ],
                  ))),
          SizedBox(height: 10),
          Expanded(
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 12),
              children: [
                /// notification Button
                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: ExpansionTile(
                      title: const Text('Notifications'),
                      children: [
                        Container(
                            padding: EdgeInsets.symmetric(horizontal: 12),
                            child: Column(
                              children: [
                                Container(
                                  height: 250,
                                  child: FutureBuilder<SettingNotificationModel?>(
                                      future: viewProfile.getNotification(),
                                      builder: (context, snapshot) {
                                        return ListView.builder(
                                          itemBuilder: (builder, index) {
                                            Map data = snapshot.data!.data![index].toJson();
                                            selectedFlag[index] = selectedFlag[index] ?? false;
                                            bool? isSelected = selectedFlag[index];
                                            return ListTile(
                                              dense: true,
                                              minLeadingWidth: 10,
                                              minVerticalPadding: 2,
                                              visualDensity: VisualDensity(vertical: -4,horizontal: -4),
                                              // onLongPress: () => onLongPress(isSelected, index),
                                              onTap: () {
                                                print("Please long Press");
                                                onTap(isSelected, index);
                                                selectedFlag[index] = !isSelected;
                                                isSelectionMode = selectedFlag.containsValue(true);
                                              },
                                              title: Text(snapshot.data!.data![index].name.toString()),
                                              leading: _buildSelectIcon(isSelected!, data),
                                            );
                                          },
                                          itemCount: snapshot.data!.data!.length,
                                        );
                                      }
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    MyCustomButton(
                                      onPressedbtn: (){

                                      },
                                      text: "Save",
                                      height: 40,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(30.r),
                                      ),
                                      mergin: EdgeInsets.symmetric(vertical: 12),
                                      width: 144,
                                    ),
                                    _buildSelectAllButton(),
                                  ],
                                ),

                              ],
                              crossAxisAlignment: CrossAxisAlignment.start,
                            )),
                      ]),
                ),

                /// security button
                SizedBox(height: 10),
                CardTwo(phoneNo: "+xx xxxxxxxx12",description: "Keep your primary phone number up-to-date",onPressed: (){},required: "Required"),
                /// payment methode button
                SizedBox(height: 10),

                /// payments Settings
                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: ExpansionTile(
                      title: const Text('Payment Methods'),
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Name on card"),
                              SizedBox(height: 10),
                              MyCustomTextField(hint: 'John Deo'),
                              SizedBox(height: 10),
                              Text("Card number"),
                              SizedBox(height: 10),
                              MyCustomTextField(hint: 'John Deo'),
                              SizedBox(height: 10),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text("Expire date"),
                                        SizedBox(height: 10),
                                        MyCustomTextField(hint: 'MM/YY'),
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text("Expire date"),
                                        SizedBox(height: 10),
                                        MyCustomTextField(hint: '1234'),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10),
                              Text("Postal code"),
                              SizedBox(height: 10),
                              MyCustomTextField(hint: '2134'),
                            ],
                          ),
                        ),
                      ]),
                ),
                SizedBox(height: 10),

                /// payment methode button
                CardFour(),

              ],
            ),
          )
        ],
      ),
    );
  }
  bool isSelectionMode = true;
  Map<int, bool> selectedFlag = {};
  void onTap(bool isSelected, int index) {
    if (isSelectionMode) {
      setState(() {
        selectedFlag[index] = !isSelected;
        isSelectionMode = selectedFlag.containsValue(true);
      });
    } else {
      // Open Detail Page
    }
  }
  // void onLongPress(bool isSelected, int index) {
  //   setState(() {
  //     selectedFlag[index] = !isSelected;
  //     isSelectionMode = selectedFlag.containsValue(true);
  //   });
  // }
  Widget _buildSelectIcon(bool isSelected, Map data) {
    if (isSelectionMode) {
      return Icon(
        isSelected ? Icons.check_box : Icons.check_box_outline_blank,
        color: Theme.of(context).primaryColor,
      );
    } else {
      return Icon(
        isSelected ? Icons.check_box : Icons.check_box_outline_blank,
        color: Theme.of(context).primaryColor,
      );
    }
  }
  Widget _buildSelectAllButton() {
    bool isFalseAvailable = selectedFlag.containsValue(false);
    if (isSelectionMode) {
      return FloatingActionButton(
        mini: true,
        onPressed: _selectAll,
        child: Icon(
          isFalseAvailable ? Icons.done_all : Icons.remove_done,
        ),
      );
    } else {
      print("klskldskl");
      return Icon(
        isFalseAvailable ? Icons.done_all : Icons.remove_done,
      );
    }
  }
  void _selectAll() {
    bool isFalseAvailable = selectedFlag.containsValue(false);
    // If false will be available then it will select all the checkbox
    // If there will be no false then it will de-select all
    selectedFlag.updateAll((key, value) => isFalseAvailable);
    setState(() {
      isSelectionMode = selectedFlag.containsValue(true);
     var SelectionMode = selectedFlag.containsValue(true);
     print("SelectionMode$SelectionMode");

    });
  }
}

final styleHead = TextStyle(fontWeight: FontWeight.w700, fontSize: 14.sp);
