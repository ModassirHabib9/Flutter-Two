import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../../data/model/setting_activity_model.dart';
import '../../../../data/repositry/settings_repo.dart';
import '../../../../utils/color_manager.dart';
class CardFour extends StatelessWidget {
  const CardFour({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewProfile = Provider.of<SettingsProvider>(context, listen: false);
    return  Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10)),
      child:
      ExpansionTile(title: const Text('Activity'), children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Recent activity on your account.",
                  style: styleHead),
              Divider(
                height: 20,
                color: ColorsManager.COLOR_GRAY,
              ),
              SizedBox(height: 10.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 45,
                    child: Text("Action", style: styleHead),
                  ),
                  Container(
                    child: Text("Source", style: styleHead),
                  ),
                  Container(
                    child: Text("IP Address", style: styleHead),
                  ),
                  Container(
                    child: Text("Location", style: styleHead),
                  ),
                  Container(
                    width: 60,
                    child: Text("When", style: styleHead),
                  ),
                ],
              ),
            ],
          ),
        ),
        Container(
          child: FutureBuilder<SettingActivityModel?>(
            future: viewProfile.getActivity(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                SettingActivityModel? userInfo = snapshot.data;
                if (userInfo != null) {
                  return ListView.builder(
                      shrinkWrap: true,
                      itemCount: userInfo.data!.length,
                      itemBuilder: (BuildContext ctxt, int index) {
                        return Padding(
                          padding: EdgeInsets.only(
                              left: 10.w, bottom: 12.w),
                          child: Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                  child: Container(
                                    alignment: Alignment.centerLeft,
                                    child: Text(userInfo
                                        .data![index].activityType
                                        .toString()),
                                  )),
                              Expanded(
                                  child: Container(
                                    alignment: Alignment.centerLeft,
                                    child: Text(userInfo.data![index]
                                        .browserAgent ==
                                        null
                                        ? "Web"
                                        : userInfo
                                        .data![index].browserAgent
                                        .toString()),
                                  )),
                              Expanded(
                                  flex: 2,
                                  child: Container(
                                    child: Text(userInfo
                                        .data![index]
                                        .ipAddress ==
                                        null
                                        ? "206.84.146.69"
                                        : userInfo
                                        .data![index].ipAddress
                                        .toString()),
                                  )),
                              Expanded(
                                child: Text(
                                    userInfo.data![index].location
                                        .toString(),
                                    maxLines: 1,
                                    overflow:
                                    TextOverflow.ellipsis),
                              ),
                              Expanded(
                                child: Text(
                                  userInfo.data![index].type
                                      .toString(),
                                  style: TextStyle(
                                      color: ColorsManager
                                          .APP_MAIN_COLOR),
                                ),
                              ),
                            ],
                          ),
                        );
                      });
                }
              }
              return Center(child: CircularProgressIndicator());
            },
          ),
        ),
      ]),
    );
  }
}

final styleHead = TextStyle(fontWeight: FontWeight.w700, fontSize: 14.sp);

