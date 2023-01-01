import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../common_widget/my_custom_button.dart';
import '../../../../utils/color_manager.dart';

class CardTwo extends StatelessWidget {
  final String? phoneNo;
  final String? description;
  final String? required;
  final VoidCallback? onPressed;
  CardTwo({Key? key, this.phoneNo, this.description, this.required, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10)),
      child:
      ExpansionTile(title: const Text('Security'), children: [
        Container(
          margin:
          EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: ColorsManager.COLOR_GRAY)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: 31.0, vertical: 10),
                  child: Text(
                    "Phone Number",
                    style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w700),
                  )),
              Divider(color: ColorsManager.COLOR_GRAY, height: 10),
              Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: 31.0, vertical: 10),
                  child: Text(
                    phoneNo!,
                    // "+xx xxxxxxxx12",
                    style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700),
                  )),
              Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: 31.0, vertical: 10),
                  child: Text(
                    description!,
                    // "Keep your primary phone number up-to-date",
                    style: TextStyle(fontSize: 16.sp),
                  )),
              Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: 31.0, vertical: 10),
                  child: Text(
                    required!,
                    // "Required",
                    style: TextStyle(
                        fontSize: 16.sp,
                        color: ColorsManager.COLOR_GREEN,
                        fontWeight: FontWeight.w700),
                  )),
              MyCustomButton(
                text: "Manage",
                onPressedbtn: onPressed,
                width: 140,
                height: 40,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                mergin: EdgeInsets.symmetric(
                    vertical: 20, horizontal: 31),
              )
            ],
          ),
        )
      ]),
    );
  }
}

final styleHead = TextStyle(fontWeight: FontWeight.w700, fontSize: 14.sp);

