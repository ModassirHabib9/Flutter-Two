import 'dart:async';
import 'dart:convert';

import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:we_coin/common_widget/my_custom_textfield.dart';
import 'package:we_coin/view/dashboard/navigation_pages/tickets/view_tickets.dart';

import '../../../../data/repositry/view_tickets_repo.dart';
import '../../../../utils/color_manager.dart';
import '../../../../utils/image_manager.dart';
import '../profile/forgot_password.dart';
import 'open_ticket.dart';

class TicketsPageScreen extends StatefulWidget {
  const TicketsPageScreen({Key? key}) : super(key: key);

  @override
  State<TicketsPageScreen> createState() => _TicketsPageScreenState();
}

class _TicketsPageScreenState extends State<TicketsPageScreen> {
  StreamController? _postsController;
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  // int count = 1;

  loadPosts() async {
   final view= Provider.of<ViewTickets_Provider>(context, listen: false);
   view.viewTickets();
    Hive.openBox('viewTickets').then((res) async {
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
    Hive.openBox('viewTickets');
    setState(() {
      Hive.openBox('viewTickets');
      final viewTicket =
      Provider.of<ViewTickets_Provider>(context, listen: false);
      viewTicket.viewTickets();
      print(viewTicket);
    });
    loadPosts();
    super.initState();
  }

  Future _handleRefresh() async {
    Hive.openBox('viewTickets');
    print("${Hive.openBox('viewTickets')}");
    final viewTicket =
    Provider.of<ViewTickets_Provider>(context, listen: false);
    viewTicket.viewTickets();
    print(viewTicket);
    Hive.openBox('viewTickets').then((res) async {
      _postsController!.add(res);
      showSnack();
      return null;
    });
  }
  @protected
  void didUpdateWidget(TicketsPageScreen oldWidget) {
    Provider.of<ViewTickets_Provider>(context, listen: false);
    super.didUpdateWidget(oldWidget);

  }
  @override
  void didChangeDependencies() {
   final view= Provider.of<ViewTickets_Provider>(context, listen: false);
    view.viewTickets();
    print(view.viewTickets());
  }
  bool isChecked = false;
   final TextEditingController controller = TextEditingController();
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
    /* final viewTicket =
        Provider.of<ViewTickets_Provider>(context, listen: false);*/
    return Scaffold(
      backgroundColor: ColorsManager.WHITE_COLOR,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(OpenTicketScreen());
        },
        child: Icon(Icons.add),
      ),
      body: Column(
        children: [
          Container(
              height: MediaQuery.of(context).size.height * 0.17,
              alignment: Alignment.center,
              color: ColorsManager.APP_MAIN_COLOR,
              child: Center(
                  child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 17.w),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
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
                                  'Tickets',
                                  style: TextStyle(
                                      fontSize: 20.sp,
                                      fontWeight: FontWeight.w600,
                                      color: ColorsManager.WHITE_COLOR),
                                ),
                                InkWell(
                                  onTap: () {
                                    visibilityObs ? null : _changed(true, "obs");
                                  },
                                  child:  Icon(Icons.search,
                                      color: ColorsManager.WHITE_COLOR)
                                )
                              ]),

                        ],
                      )))),
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
                        itemCount: userMap['data'].length,
                        itemBuilder: (context, index) {
                          return Container(
                              margin: new EdgeInsets.fromLTRB(10, 0, 10, 0),
                              width: 25.0,
                              height: MediaQuery.of(context).size.height * 0.17,
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
                                      color: Colors.amber,
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
                                                  SizedBox(height: 30),
                                                  Text("Open"),
                                                ],
                                              ),
                                              Text(
                                                "${userMap['data'][index]['subject']}",
                                                style: TextStyle(
                                                    fontSize: 16.sp,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                              Container(
                                                height: 20,
                                                padding:
                                                    EdgeInsets.only(top: 5),
                                                child: Text(
                                                  "${userMap['data'][index]['priority']}",
                                                  style: TextStyle(
                                                      fontSize: 12.sp,
                                                      color: ColorsManager
                                                          .COLOR_GRAY,
                                                      fontWeight:
                                                          FontWeight.w400),
                                                ),
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                              "${DateTime.parse(userMap['data'][index]['created_at']).day}${"-"}${DateTime.parse(userMap['data'][index]['created_at']).month}${"-"}${DateTime.parse(userMap['data'][index]['created_at']).year}",
                                                    // "${userMap['data'][index]['created_at']}",
                                                    style: TextStyle(
                                                        fontSize: 12.sp,
                                                        color: ColorsManager
                                                            .APP_MAIN_COLOR,
                                                        fontWeight:
                                                            FontWeight.w400),
                                                  ),
                                                  Row(
                                                    children: [
                                                      InkWell(
                                                        onTap: () {},
                                                        // Get.to(ChatPage()),
                                                        child: CircleAvatar(
                                                            backgroundColor:
                                                                ColorsManager
                                                                    .COLOR_CONTAINER,
                                                            radius: 16,
                                                            child: Image.asset(
                                                              ImageManager
                                                                  .message_icon,
                                                              height: 20,
                                                            )),
                                                      ),
                                                      SizedBox(width: 10),
                                                      InkWell(
                                                        onTap: () => Get.to(
                                                            ViewTickitsScreen()),
                                                        child: CircleAvatar(
                                                            backgroundColor:
                                                                ColorsManager
                                                                    .COLOR_CONTAINER,
                                                            radius: 16,
                                                            child: Image.asset(
                                                              ImageManager
                                                                  .aye_icon,
                                                              height: 20,
                                                            )),
                                                      )
                                                    ],
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ));
                        },
                      )),
                );
              }
              return Text("Loading......");
            },
          ))
        ],
      ),
    );
  }
}
/*
Expanded(
child: FutureBuilder(
future: Hive.openBox('asif Taj'),
builder: (context, snapshot) {
if (snapshot.connectionState == ConnectionState.done) {
// Get the box
final box = snapshot.data;
// Get the data from the box
final users = box!.get('name');
final Map<String, dynamic> userMap = jsonDecode(users);

return ListView.builder(
itemCount: userMap['data'].length,
itemBuilder: (context, index) {

// final String name = userMap[index]['name'];
return Column(
children: [
Text(userMap['data'][index]['id'].toString()),

],
);
},
);
} else {
return Center(
child: CircularProgressIndicator(),
);
}
},
),
),*/

/// /* Expanded(
///             child: FutureBuilder(
///               future: Hive.openBox('viewTickets'),
///               builder: (context, snapshot) {
///                 if (snapshot.connectionState == ConnectionState.done) {
///                   // Get the box
///                   final box = snapshot.data;
///                   // Get the data from the box
///                   final users = box!.get('name');
///                   final Map<String, dynamic> userMap = jsonDecode(users);
///
///                   return ListView.builder(
///                     itemCount: userMap['data'].length,
///                     itemBuilder: (context, index) {
///                       return Container(
///                           margin: new EdgeInsets.fromLTRB(10, 20, 10, 0),
///                           width: 25.0,
///                           height: MediaQuery.of(context).size.height * 0.17,
///                           child: Card(
///                             elevation: 7,
///                             clipBehavior: Clip.antiAlias,
///                             shape: RoundedRectangleBorder(
///                                 borderRadius: BorderRadius.circular(8.0)),
///                             color: Colors.white,
///                             child: Row(
///                               crossAxisAlignment: CrossAxisAlignment.center,
///                               children: <Widget>[
///                                 Container(
///                                   color: Colors.amber,
///                                   width: 5,
///                                 ),
///                                 SizedBox(
///                                   width: 10.0,
///                                 ),
///                                 Expanded(
///                                   child: GestureDetector(
///                                     onTap: () {
///                                       print('testing');
///                                     },
///                                     child: Padding(
///                                       padding: const EdgeInsets.only(
///                                           right: 12, bottom: 12),
///                                       child: Column(
///                                         mainAxisAlignment:
///                                             MainAxisAlignment.center,
///                                         crossAxisAlignment:
///                                             CrossAxisAlignment.start,
///                                         children: [
///                                           new Row(
///                                             mainAxisAlignment:
///                                                 MainAxisAlignment.spaceBetween,
///                                             children: <Widget>[
///                                               new Text(
///                                                 'ID: 54545454',
///                                               ),
///                                               SizedBox(height: 30),
///                                               Text("Open"),
///                                             ],
///                                           ),
///                                           Text(
///                                             "${userMap['data'][index]['subject']}",
///                                             style: TextStyle(
///                                                 fontSize: 16.sp,
///                                                 fontWeight: FontWeight.w600),
///                                           ),
///                                           Container(
///                                             height: 20,
///                                             padding: EdgeInsets.only(top: 5),
///                                             child: Text(
///                                               "${userMap['data'][index]['priority']}",
///                                               style: TextStyle(
///                                                   fontSize: 12.sp,
///                                                   color:
///                                                       ColorsManager.COLOR_GRAY,
///                                                   fontWeight: FontWeight.w400),
///                                             ),
///                                           ),
///                                           Row(
///                                             mainAxisAlignment:
///                                                 MainAxisAlignment.spaceBetween,
///                                             children: [
///                                               Text(
///                                                 "${userMap['data'][index]['created_at']}",
///                                                 style: TextStyle(
///                                                     fontSize: 12.sp,
///                                                     color: ColorsManager
///                                                         .APP_MAIN_COLOR,
///                                                     fontWeight:
///                                                         FontWeight.w400),
///                                               ),
///                                               Row(
///                                                 children: [
///                                                   InkWell(
///                                                     onTap: () {},
///                                                     // Get.to(ChatPage()),
///                                                     child: CircleAvatar(
///                                                         backgroundColor:
///                                                             ColorsManager
///                                                                 .COLOR_CONTAINER,
///                                                         radius: 16,
///                                                         child: Image.asset(
///                                                           ImageManager
///                                                               .message_icon,
///                                                           height: 20,
///                                                         )),
///                                                   ),
///                                                   SizedBox(width: 10),
///                                                   InkWell(
//                                                     onTap: () => Get.to(
//                                                         ViewTickitsScreen()),
//                                                     child: CircleAvatar(
//                                                         backgroundColor:
//                                                             ColorsManager
//                                                                 .COLOR_CONTAINER,
//                                                         radius: 16,
//                                                         child: Image.asset(
//                                                           ImageManager.aye_icon,
//                                                           height: 20,
//                                                         )),
//                                                   )
//                                                 ],
//                                               ),
//                                             ],
//                                           )
//                                         ],
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ));
//                     },
//                   );
//                 } else {
//                   return Center(
//                     child: CircularProgressIndicator(),
//                   );
///                 }
///               },
///            ),
///          ),*/