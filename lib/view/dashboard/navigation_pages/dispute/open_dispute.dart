import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:we_coin/common_widget/my_custom_button.dart';
import 'package:we_coin/common_widget/my_custom_textfield.dart';

import '../../../../data/repositry/add_tickets_repo.dart';

class OpenDisputeScreen extends StatefulWidget {
  OpenDisputeScreen({Key? key}) : super(key: key);

  @override
  State<OpenDisputeScreen> createState() => _OpenDisputeScreenState();
}

class _OpenDisputeScreenState extends State<OpenDisputeScreen> {
  TextEditingController priorityController = TextEditingController();

  TextEditingController subjectController = TextEditingController();

  TextEditingController messageController = TextEditingController();

  String? selectedName;
  List data = [];
  String? dropdownvalue;
  List<String> _items = ["Low","Medium","Large"];
  String? accountNo;

  @override
  Widget build(BuildContext context) {
    final add_dipute = Provider.of<AddTickets_Provider>(context);
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 90.h,
        title: Text("open Dispute"),
        centerTitle: true,
        automaticallyImplyLeading: false,
        backwardsCompatibility: false,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 16.h),
        children: [
          SizedBox(height: 40.h),
          SizedBox(height: 30, child: Text("Type")),
          Container(
            height: 50,
            // width: MediaQuery.of(context).size.width * 0.70,
            decoration: BoxDecoration(
              color: const Color(0xFFF0F0F0),
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(10),
            ),
            child: DropdownButtonHideUnderline(
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 3.0, right: 12.0),
                child: DropdownButton(
                  isExpanded: true,
                  icon: Icon(Icons.expand_more),
                  hint: Text("\t\tPlease Select Option"),
                  value: selectedName,
                  items: _items.map((location) {
                    return DropdownMenuItem(

                      value: location.toString(),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(location.toString()),
                      ),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    setState(() {
                      selectedName = newValue;
                      print(dropdownvalue =
                          newValue.toString());
                    });
                  },
                ),
              ),
            ),
          ),
          SizedBox(height: 20.h),
          SizedBox(height: 30, child: Text("Subject")),
          MyCustomTextField(hint: 'Type', controller: subjectController),
          SizedBox(height: 20.h),
          SizedBox(height: 30, child: Text("Description")),
          MyCustomTextField(
            controller: messageController,
            hint: 'Type',
            maxLines: 6,
          ),
          SizedBox(height: 40.h),
          MyCustomButton(
            mergin: EdgeInsets.zero,
            onPressedbtn: () {
              add_dipute.addDispute(context, dropdownvalue.toString(),
                  subjectController.text, messageController.text);
            },
            child: add_dipute.loading
                ? CircularProgressIndicator(
                    color: Colors.white,
                  )
                : Text("Confirm"),
          )
        ],
      ),
    );
  }
}
