import 'package:avatar_view/avatar_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:provider/provider.dart';

import '../../../../data/model/recent_transaction_model.dart';
import '../../../../data/repositry/home_repo.dart';
import '../../../../utils/color_manager.dart';
import '../../../../utils/image_manager.dart';

class SeeAllTransactionScreen extends StatelessWidget {
  const SeeAllTransactionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final home= Provider.of<HomeProvider>(context, listen: false);
    home.getHome();
    return Scaffold(body: Column(children: [
      AppBar(toolbarHeight: 120,backgroundColor: ColorsManager.APP_MAIN_COLOR,
      backwardsCompatibility: false,
        automaticallyImplyLeading: false,
        title: Text("See All Transactions"),
        centerTitle: true,
        leading: IconButton(onPressed: ()=>Get.back(),icon: Icon(Icons.arrow_back_ios,color: ColorsManager.WHITE_COLOR),),
      ),
      Expanded(child: FutureBuilder<RecentTransactionsModel?>(
        future: home.getHome(),
        builder: (
            BuildContext context,
            AsyncSnapshot<RecentTransactionsModel?> snapshot,
            ) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return const Text('Error');
            } else if (snapshot.hasData) {
              RecentTransactionsModel? userInfo = snapshot.data;
              print("Tickits=>${userInfo!.data!.first.id}");
              return ListView.builder(
                  shrinkWrap: true,
                  itemCount: userInfo.data!.length,
                  itemBuilder: (BuildContext ctxt, int index) {
                    return ListTile(
                      leading: AvatarView(
                          radius: 24,
                          borderWidth: 1,
                          borderColor: ColorsManager.YELLOWBUTTON_COLOR,
                          avatarType: AvatarType.CIRCLE,
                          imagePath: "${userInfo.data![index].currencies!.logo==null?ImageManager.weCoin_logo:userInfo.data![index].currencies!.logo}",
                          placeHolder: Container(
                              child: Image.asset(ImageManager.user_pro)
                          ),
                          errorWidget: CircularProgressIndicator()),
                      title: Text(userInfo.data![index].currencies!.name!),
                      subtitle: Text("${userInfo.data![index].currencies!.createdAt}",
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: ColorsManager.COLOR_GRAY,
                          )),
                      trailing: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                      Text(
                      "\$${userInfo.data![index].subtotal!.substring(0,5)}",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    if(userInfo.data![index].status=="Pending")
                    Text( "${userInfo.data![index].status!}",
                    style: TextStyle(fontSize: 12,  color: ColorsManager.COLOR_RED)),
                    /* if(userInfo.data![index].status=="Pending")
                    Text( "${userInfo.data![index].status!}",
                    style: TextStyle(fontSize: 16,  color: ColorsManager.COLOR_BLACK)),*/
                    ],
                    ),
                    );
                  });
            } else {
              return const Text('Empty data');
            }
          } else {
            return Text('State: ${snapshot.connectionState}');
          }
        },
      ))
    ],),);
  }
}
