import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:getwidget/components/checkbox/gf_checkbox.dart';
import 'package:getwidget/size/gf_size.dart';
import 'package:getwidget/types/gf_checkbox_type.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

import '../../../../common_widget/my_custom_textfield.dart';
import '../../../../data/model/view_dispute_model.dart';
import '../../../../data/repositry/view_tickets_repo.dart';
import '../../../../utils/color_manager.dart';
import '../../../../utils/image_manager.dart';
import '../profile/forgot_password.dart';
import 'open_dispute.dart';

class DisputedPageScreen extends StatefulWidget {
  static const String routeName = '/notificationPage';

  const DisputedPageScreen({Key? key}) : super(key: key);

  @override
  State<DisputedPageScreen> createState() => _DisputedPageScreenState();
}

class _DisputedPageScreenState extends State<DisputedPageScreen> {
  StreamController? _postsController;
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  // int count = 1;

  loadPosts() async {
    final view =Provider.of<ViewTickets_Provider>(context, listen: false);
    view.viewDispute();
    print(view.viewDispute());
    Hive.openBox('viewDispute').then((res) async {
      _postsController!.add(res);
      return res;
    });
  }

  showSnack() {
    return scaffoldKey.currentState ==
        SnackBar(
          content: Text('New content loaded'),
        );
  }

  @override
  void initState() {
    _postsController = new StreamController();
    setState(() {
      Hive.openBox('viewDispute');
      final Dispute =
      Provider.of<ViewTickets_Provider>(context, listen: false);
      Dispute.viewDispute();
      print(Dispute);
    });
    loadPosts();
    super.initState();
  }

  Future _handleRefresh() async {
    Hive.openBox('viewDispute');
    print("${Hive.openBox('viewDispute')}");
    final view =Provider.of<ViewTickets_Provider>(context, listen: false);
    view.viewDispute();
    print(view.viewDispute());
    setState(() {
      Hive.openBox('viewDispute').then((res) async {
        _postsController!.add(res);
        showSnack();
        return null;
      });
    });

  }
  @protected
  void didUpdateWidget(DisputedPageScreen oldWidget) {
    final view =Provider.of<ViewTickets_Provider>(context, listen: false);
    view.viewDispute();
    print(view.viewDispute());
    super.didUpdateWidget(oldWidget);

  }
  @override
  void didChangeDependencies() {
    final view =Provider.of<ViewTickets_Provider>(context, listen: false);
    view.viewDispute();
    print(view.viewDispute());
    print(view.viewTickets());
  }

  bool isChecked = false;
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
    final viewTicket =
        Provider.of<ViewTickets_Provider>(context, listen: false);
    viewTicket.viewDispute();
    return Scaffold(
      backgroundColor: ColorsManager.WHITE_COLOR,
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => OpenDisputeScreen()));
          }),
      body: Column(
        children: [
          Container(
              height: MediaQuery.of(context).size.height * 0.17,
              alignment: Alignment.center,
              color: ColorsManager.APP_MAIN_COLOR,
              child: Center(
                  child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 17.w),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () => Scaffold.of(context).openDrawer(),
                              child: Icon(
                                Icons.arrow_back_ios,
                                color: ColorsManager.WHITE_COLOR,
                              ),
                            ),
                            Text(
                              'Dispute',
                              style: TextStyle(
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.w600,
                                  color: ColorsManager.WHITE_COLOR),
                            ),
                            InkWell(
                              onTap: () {
                                visibilityObs ? null : _changed(true, "obs");
                              },
                              child: Icon(Icons.search,
                                  color: ColorsManager.WHITE_COLOR),
                            )
                          ])))),
          visibilityObs ? Padding(
            padding: const EdgeInsets.only(top: 8.0,left: 12,right: 12),
            child: MyCustomTextField(hint: "search...",suffixIcon: IconButton(onPressed: (){
              _changed(false, "obs");
            },icon: Icon(Icons.close),)),
          ):Container(),
          Expanded(
              child: StreamBuilder(
                stream: _postsController!.stream,
                builder: (context, snapshot) {
                  final box = snapshot.data;
                  // Get the data from the box
                  final users = box!.get('name');
                  if (users == null) {
                    return Center(
                      child: Scrollbar(
                        child: RefreshIndicator(
                            onRefresh: _handleRefresh,
                            child: Image.asset(ImageManager.noDataFound)),
                      ),
                    );
                  } else if (snapshot.hasData) {
                    final box = snapshot.data;
                    // Get the data from the box
                    final users = box!.get('name');
                    final Map<String, dynamic> userMap = jsonDecode(users);
                    return Scrollbar(
                      child: RefreshIndicator(
                          onRefresh: _handleRefresh,
                          child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: userMap['data'].length,
                              itemBuilder: (BuildContext ctxt, int index) {
                                return Container(
                                    margin: new EdgeInsets.fromLTRB(10, 0, 10, 10),
                                    width: 25.0,
                                    height: MediaQuery.of(context).size.height * 0.21,
                                    child: Card(
                                      elevation: 7,
                                      clipBehavior: Clip.antiAlias,
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(8.0)),
                                      color: Colors.white,
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: <Widget>[
                                          Container(
                                            color: isChecked == false
                                                ? ColorsManager.YELLOWBUTTON_COLOR
                                                : ColorsManager.COLOR_GREEN,
                                            width: 5,
                                          ),
                                          SizedBox(
                                            width: 10.0,
                                          ),
                                          Expanded(
                                            child: GestureDetector(
                                              onTap: () {
                                                print('testing');
                                              },
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 12, bottom: 12),
                                                child: Column(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                                  children: [
                                                    new Row(
                                                      mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                      children: <Widget>[
                                                        new Text(
                                                          'ID: 54545454',
                                                        ),
                                                        Column(
                                                          children: [
                                                            GFCheckbox(
                                                              activeBgColor:
                                                              Colors.green,
                                                              size: GFSize.SMALL,
                                                              type: GFCheckboxType
                                                                  .circle,
                                                              onChanged: (value) {
                                                                setState(() {
                                                                  isChecked = value;
                                                                  userMap['data']
                                                                  [index]
                                                                  ['status'] =
                                                                      value;
                                                                });
                                                              },
                                                              value: isChecked,
                                                              inactiveIcon: null,
                                                            ),
                                                            userMap['data'][index]
                                                            ['status'] ==
                                                                false
                                                                ? Text(
                                                              "${userMap['data'][index]['status']}",
                                                            )
                                                                : Text("Close")
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                    Text(
                                                      "${userMap['data'][index]['title']}",
                                                      style: TextStyle(
                                                          fontSize: 16.sp,
                                                          fontWeight:
                                                          FontWeight.w600),
                                                    ),
                                                    Container(
                                                      height: 50,
                                                      padding:
                                                      EdgeInsets.only(top: 5),
                                                      child: Text(
                                                        "${userMap['data'][index]['description']}",
                                                        style: TextStyle(
                                                            fontSize: 12.sp,
                                                            color: ColorsManager
                                                                .COLOR_GRAY,
                                                            fontWeight:
                                                            FontWeight.w400),
                                                      ),
                                                    ),
                                                    Text(
                                                        "${DateTime.parse(userMap['data'][index]['created_at']).day}${"-"}${DateTime.parse(userMap['data'][index]['created_at']).month}${"-"}${DateTime.parse(userMap['data'][index]['created_at']).year}",
                                                      style: TextStyle(
                                                          fontSize: 12.sp,
                                                          color: ColorsManager
                                                              .APP_MAIN_COLOR,
                                                          fontWeight:
                                                          FontWeight.w400),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ));
                              })),
                    );
                  }
                  return Text("Loading......");
                },
              )),
          /*Expanded(
            child: FutureBuilder(
              future: Hive.openBox('viewDispute'),
              builder: (
                context,
                snapshot,
              ) {
                final box = snapshot.data;
                // Get the data from the box
                final users = box!.get('name');
                if (users == null) {
                  return Center(child: Image.asset(ImageManager.noDataFound));
                } else if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasError) {
                    return const Text('Error');
                  } else if (snapshot.hasData) {
                    final box = snapshot.data;

                    final users = box!.get('name');
                    final Map<String, dynamic> userMap = jsonDecode(users);
                    // ViewDisputeModel? userInfo = snapshot.data;
                    return ListView.builder(
                        shrinkWrap: true,
                        itemCount: userMap['data'].length,
                        itemBuilder: (BuildContext ctxt, int index) {
                          return Container(
                              margin: new EdgeInsets.fromLTRB(10, 0, 10, 10),
                              width: 25.0,
                              height: MediaQuery.of(context).size.height * 0.21,
                              child: Card(
                                elevation: 7,
                                clipBehavior: Clip.antiAlias,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0)),
                                color: Colors.white,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Container(
                                      color: isChecked == false
                                          ? ColorsManager.YELLOWBUTTON_COLOR
                                          : ColorsManager.COLOR_GREEN,
                                      width: 5,
                                    ),
                                    SizedBox(
                                      width: 10.0,
                                    ),
                                    Expanded(
                                      child: GestureDetector(
                                        onTap: () {
                                          print('testing');
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              right: 12, bottom: 12),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              new Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: <Widget>[
                                                  new Text(
                                                    'ID: 54545454',
                                                  ),
                                                  Column(
                                                    children: [
                                                      GFCheckbox(
                                                        activeBgColor:
                                                            Colors.green,
                                                        size: GFSize.SMALL,
                                                        type: GFCheckboxType
                                                            .circle,
                                                        onChanged: (value) {
                                                          setState(() {
                                                            isChecked = value;
                                                            userMap['data']
                                                                        [index]
                                                                    ['status'] =
                                                                value;
                                                          });
                                                        },
                                                        value: isChecked,
                                                        inactiveIcon: null,
                                                      ),
                                                      userMap['data'][index]
                                                                  ['status'] ==
                                                              false
                                                          ? Text(
                                                              "${userMap['data'][index]['status']}",
                                                            )
                                                          : Text("Close")
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              Text(
                                                "${userMap['data'][index]['title']}",
                                                style: TextStyle(
                                                    fontSize: 16.sp,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                              Container(
                                                height: 50,
                                                padding:
                                                    EdgeInsets.only(top: 5),
                                                child: Text(
                                                  "${userMap['data'][index]['description']}",
                                                  style: TextStyle(
                                                      fontSize: 12.sp,
                                                      color: ColorsManager
                                                          .COLOR_GRAY,
                                                      fontWeight:
                                                          FontWeight.w400),
                                                ),
                                              ),
                                              Text(
                                                "${userMap['data'][index]['created_at']}",
                                                style: TextStyle(
                                                    fontSize: 12.sp,
                                                    color: ColorsManager
                                                        .APP_MAIN_COLOR,
                                                    fontWeight:
                                                        FontWeight.w400),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ));
                        });
                  } else {
                    return const Text('Empty data');
                  }
                } else {
                  return Text('State: ${snapshot.connectionState}');
                }
              },
            ),
          )*/
        ],
      ),
    );
  }
}
// Expanded(
// child: Expanded(
// child: FutureBuilder(
// future: Hive.openBox('viewDispute'),
// builder: (context, snapshot) {
// if (snapshot.connectionState == ConnectionState.done) {
// final box = snapshot.data;
//
// final users = box!.get('name');
// final Map<String, dynamic> userMap = jsonDecode(users);
//
// return ListView.builder(
// itemCount: userMap['data'].length,
// itemBuilder: (context, index) {
// return Column(
// children: [
// Text(userMap['data'][index]['id'].toString()),
// ],
// );
// },
// );
// } else {
// return Center(
// child: CircularProgressIndicator(),
// );
// }
// },
// ),
// ),
// )
