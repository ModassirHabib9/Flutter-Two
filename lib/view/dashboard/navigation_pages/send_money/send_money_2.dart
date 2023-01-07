import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:we_coin/utils/image_manager.dart';

import '../../../../common_widget/my_custom_button.dart';
import '../../../../common_widget/my_custom_textfield.dart';
import '../../../../data/model/currencies_model.dart';
import '../../../../data/repositry/currencies_get_repo.dart';
import '../../../../data/repositry/send_money_repo.dart';
import '../../../../utils/color_manager.dart';

class SendMoney_2Screen extends StatefulWidget {
  SendMoney_2Screen({Key? key,this.coinName,this.weCoin_accountNo,this.weCoin_balance}) : super(key: key);
  String? coinName;
  String? weCoin_balance;
  String? weCoin_accountNo;

  @override
  State<SendMoney_2Screen> createState() => _SendMoney_2ScreenState();
}

class _SendMoney_2ScreenState extends State<SendMoney_2Screen> {
  TextEditingController formController = TextEditingController();

  TextEditingController toController = TextEditingController();

  TextEditingController amountController = TextEditingController();

  TextEditingController notesController = TextEditingController();

  TextEditingController networks_feeController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // final get_currencies = Provider.of<CurrenciesProvider>(context);
    // print(get_currencies);
    _StoreAccountNo();
  }

  String? selectedName;
  List data = [];
  String? dropdownvalue;
  List<DropdownMenuItem> _items = [];
  String? _selectedItem;
  final _formValidKey = GlobalKey<FormState>();
  String? accountNo;
  String? account_balance;

  _StoreAccountNo() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    accountNo = sharedPreferences.getString('fromKey');
    account_balance = sharedPreferences.getString('balance2');
    print("Send Money $accountNo");
    print("Send Balance $account_balance");
  }

  bool visibilityTag = false;
  bool visibilityObs = false;

  void _changed(bool visibility, String field) {
    setState(() {
      if (field == "tag"){
        visibilityTag = visibility;
      }
      if (field == "obs"){
        visibilityObs = visibility;
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    final sendMoney = Provider.of<SendMoney_Provider>(context);
    final get_currencies = Provider.of<CurrenciesProvider>(context);
    final get_wallets = Provider.of<CurrenciesProvider>(context);
    print(widget.weCoin_accountNo);
    print(widget.weCoin_balance);
    print(widget.coinName);
    return Scaffold(
      body: Form(
        key: _formValidKey,
        child: Column(
          children: [
            Container(
                height: MediaQuery.of(context).size.height * 0.15,
                color: ColorsManager.APP_MAIN_COLOR,
                alignment: Alignment.center,
                child: Padding(
                    padding:
                        EdgeInsets.only(left: 12.w, right: 12.w, top: 40.h),
                    child: Column(
                      children: [
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              IconButton(
                                onPressed: () => Navigator.pop(context),
                                icon: Icon(
                                  Icons.arrow_back_ios,
                                  color: ColorsManager.WHITE_COLOR,
                                ),
                              ),
                              Text('Send ${widget.coinName}',
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
                      ],
                    ))),
            Expanded(
              // padding: EdgeInsetss.symmetric(horizontal: 12.w),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.w),
                child: ListView(
                  primary: false,
                  children: [
                    SizedBox(height: 30, child: Text("Currency")),
                    Container(
                      height: 50,
                      // width: MediaQuery.of(context).size.width * 0.70,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF0F0F0),
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ListTile(
                        visualDensity: VisualDensity(
                            vertical: -1, horizontal: 0),
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.asset(ImageManager.weCoin_logo,fit: BoxFit.cover,width: 30,height: 30),
                        ),
                        title: Text("WeCoin"),
                        trailing: Text(
                          "\$${widget.weCoin_balance}",
                          style: TextStyle(
                              fontWeight: FontWeight.w600),
                        ),
                      ),/*FutureBuilder<CurrenciesModel?>(
                          future: get_currencies.getCurrencies(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return DropdownButtonHideUnderline(
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 3.0, right: 12.0),
                                  child: DropdownButton(
                                    isExpanded: true,
                                    icon: Icon(Icons.expand_more),
                                    hint: ListTile(
                                      visualDensity: VisualDensity(
                                          vertical: -4, horizontal: 0),
                                      leading: ClipRRect(
                                        borderRadius: BorderRadius.circular(20),
                                        child: Image.asset(ImageManager.weCoin_logo,fit: BoxFit.cover,width: 30,height: 30),
                                      ),
                                      title: Text("WeCoin"),
                                      trailing: Text(
                                        "\$${"1000"}",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                    value: selectedName,
                                    items: snapshot.data!.data!.map((location) {
                                      return DropdownMenuItem(
                                        value: location.id.toString(),
                                        child: ListTile(
                                          visualDensity: VisualDensity(
                                              vertical: -4, horizontal: 0),
                                          leading: CircleAvatar(
                                            child: Image.network(
                                                "http://wecoin.pk/weCoinApp/uploads/${location.logo}"),
                                          ),
                                          title: Text(location.name.toString()),
                                          trailing: Text(
                                            "${location.symbol}  ${location.rate}",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                        // value: location,
                                      );
                                    }).toList(),
                                    onChanged: (newValue) {
                                      setState(() {
                                        selectedName = newValue;
                                        print(dropdownvalue =
                                            newValue.toString());
                                      });
                                      // dropdownvalue = newValue.toString();
                                      // print(
                                      //     dropdownvalue = newValue.toString());
                                    },
                                  ),
                                ),
                              );
                            }
                            return ListTile(
                              visualDensity: VisualDensity(
                                  vertical: -4, horizontal: 0),
                              leading: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Image.asset(ImageManager.weCoin_logo,fit: BoxFit.cover,width: 30,height: 30),
                              ),
                              title: Text("WeCoin"),
                              trailing: Text(
                                "\$${"1000"}",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600),
                              ),
                            );
                          }),*/
                    ),
                    /* FutureBuilder<CurrenciesModel?>(
                        future: get_currencies.getCurrencies(),
                        builder: (context, snapshot) {
                          return Container(
                            height: 35,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.horizontal(
                                left: Radius.circular(10),
                                right: Radius.circular(10),
                              ),
                              border: Border.all(color: Colors.blue),
                            ),
                            child: DropdownButtonHideUnderline(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: DropdownButton(
                                  isExpanded: true,
                                  icon: Container(
                                    height: 35,
                                    width: 32,
                                    decoration: BoxDecoration(
                                        color: Colors.blue,
                                        borderRadius: BorderRadius.circular(5)),
                                    child: Icon(
                                      Icons.arrow_drop_down,
                                      color: Colors.white,
                                    ),
                                  ),
                                  hint: Text(
                                      'Choose Option'), // Not necessary for Option 1
                                  value: selectedName,
                                  onChanged: (newValue) {
                                    setState(() {
                                      selectedName = newValue;
                                    });
                                  },
                                  items: snapshot.data!.data!.map((value) {
                                    return DropdownMenuItem(
                                      value: value.id.toString(),
                                      child: ListTile(
                                        visualDensity: VisualDensity(
                                            vertical: -4, horizontal: 0),
                                        leading: CircleAvatar(
                                          child: Image.network(
                                              "http://wecoin.pk/weCoinApp/uploads/${value.logo}"),
                                        ),
                                        title: Text(value.name.toString()),
                                        subtitle: Text("12/02/22",
                                            style: TextStyle(
                                              fontSize: 12.sp,
                                              color: ColorsManager.COLOR_GRAY,
                                            )),
                                        trailing: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "${value.symbol}  ${value.rate}",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            Text(
                                              "Completed",
                                              style: TextStyle(
                                                  color: ColorsManager
                                                      .COLOR_GREEN),
                                            ),
                                          ],
                                        ),
                                      ),
                                      // value: location,
                                    );
                                  }).toList(),
                                ),
                              ),
                            ),
                          );
                        }),*/
                    SizedBox(height: 20.h),
                    SizedBox(height: 30, child: Text("From")),
                    MyCustomTextField(
                      controller: formController..text = widget.weCoin_accountNo.toString(),
                      hint: "accountNo",
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter a valid form data!';
                        }
                        return null;
                      },
                      // suffixIcon: Icon(Icons.expand_more_outlined),
                    ),
                    SizedBox(height: 20.h),
                    SizedBox(height: 30, child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("To"),
                        MaterialButton(onPressed: (){ visibilityObs ? null : _changed(true, "obs");},child: Text("show balance"),)
                      ],
                    )),
                    MyCustomTextField(
                      controller: toController,
                      hint: "Paste scan or select destination",
                      suffixIcon: Icon(Icons.qr_code_2_rounded),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter a valid to data!';
                        }
                        return null;
                      },
                    ),
                    visibilityObs ? Text("Total Balance: ${widget.weCoin_balance}"):Container(),
                    SizedBox(height: 20.h),

                    SizedBox(height: 30, child: Text("Amount")),
                    MyCustomTextField(
                      controller: amountController,
                      hint: "0.00",
                      suffixIcon: Icon(Icons.currency_bitcoin),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter amount!';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20.h),
                    SizedBox(height: 30, child: Text("Note")),
                    MyCustomTextField(
                      controller: notesController,
                      hint: "Optional message",
                      maxLines: 4,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter message!';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20.h),
                    SizedBox(height: 30, child: Text("Network fee")),
                    MyCustomTextField(
                      controller: networks_feeController,
                      hint: "Regular",

                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter network fee!';
                        }
                        return null;
                      },
                    ),
                    MyCustomButton(
                      mergin: EdgeInsets.symmetric(vertical: 40.h),
                      onPressedbtn: () {
                        if (_formValidKey.currentState!.validate()) {
                          // showAlertDialog(context);
                          /*if(account_balance==null){
                            print("successful${dropdownvalue}");
                            try{
                              sendMoney.sendMoney(
                                  context,
                                  dropdownvalue.toString(),
                                  formController.text,
                                  toController.text,
                                  amountController.text,
                                  notesController.text,
                                  networks_feeController.text);
                              return null;
                            }
                            catch(e){
                              print(e.toString());
                              print("successful");
                            }

                          }*/
                          print("successful");
                          if(widget.weCoin_balance!=0){

                                print("This Account Balance Avaliable");
                                sendMoney.sendMoney(
                                    context,
                                    dropdownvalue.toString(),
                                    widget.weCoin_accountNo.toString(),
                                    toController.text,
                                    amountController.text,
                                    notesController.text,
                                    networks_feeController.text);
                          }
                          else{
                            print("Your Account is 0");
                          }
                          /*sendMoney.sendMoney(
                              context,
                              dropdownvalue.toString(),
                              widget.weCoin_accountNo.toString(),
                              toController.text,
                              amountController.text,
                              notesController.text,
                              networks_feeController.text);*/
                          return;
                        } else {
                          print("UnSuccessfull");
                          print("===>${dropdownvalue.toString()}");
                        }
                      },
                      child: sendMoney.loading
                          ? CircularProgressIndicator(
                              color: Colors.white,
                            )
                          : Text("Confirm"),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
  // showAlertDialog(BuildContext context) {
  //   QuickAlert.show(
  //       context: context,
  //       type: QuickAlertType.warning,
  //       cancelBtnText: "Cancel",
  //       title: "Are You Sure",
  //       text: "Are you sure to delete this",
  //       confirmBtnText: "Confirm",
  //       backgroundColor: Colors.transparent,
  //       barrierColor: Colors.transparent,
  //       showCancelBtn: true,
  //       onCancelBtnTap: () {
  //         Navigator.pop(context);
  //       },
  //       confirmBtnColor: ColorsManager.YELLOWBUTTON_COLOR,
  //       onConfirmBtnTap: () async {
  //         Provider.of<SendMoney_Provider>(context).sendMoney(
  //             context,
  //             dropdownvalue.toString(),
  //             formController.text,
  //             toController.text,
  //             amountController.text,
  //             notesController.text,
  //             networks_feeController.text);
  //       });
  // }
}
