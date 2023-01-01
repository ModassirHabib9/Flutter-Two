import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:we_coin/common_widget/my_custom_button.dart';
import 'package:we_coin/common_widget/my_custom_textfield.dart';

import '../../../../data/repositry/add_tickets_repo.dart';
import '../../../../utils/color_manager.dart';

class OpenTicketScreen extends StatefulWidget {
  OpenTicketScreen({Key? key}) : super(key: key);

  @override
  State<OpenTicketScreen> createState() => _OpenTicketScreenState();
}

class _OpenTicketScreenState extends State<OpenTicketScreen> {
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
    final add_tickets = Provider.of<AddTickets_Provider>(context);
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.17,
            color: ColorsManager.APP_MAIN_COLOR,
            padding: EdgeInsets.symmetric(horizontal: 12.0),
            alignment: Alignment.topCenter,
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.arrow_back_ios,
                        color: ColorsManager.WHITE_COLOR,
                      )),
                  Text(
                    'Open Ticket',
                    style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w600,
                        color: ColorsManager.WHITE_COLOR),
                  ),
                  SizedBox(width: 60),
                ],
              ),
            ),
          ),
          Expanded(
              child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 12),
            children: [
              SizedBox(height: 25),
              SizedBox(height: 25, child: Text("Priority")),
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

              SizedBox(height: 25),
              SizedBox(height: 25, child: Text("Subject")),
              MyCustomTextField(hint: "Type", controller: subjectController),
              SizedBox(height: 25),
              SizedBox(height: 25, child: Text("Message")),
              MyCustomTextField(
                  hint: "Type....", maxLines: 7, controller: messageController),
              // button
            ],
          )),
          MyCustomButton(
            onPressedbtn: () {
              add_tickets.addTicket(context, dropdownvalue.toString(),
                  subjectController.text, messageController.text);
            },
            child: add_tickets.loading
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
