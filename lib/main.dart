import 'dart:async';
import 'dart:developer' as developer;

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:provider/provider.dart';
import 'package:we_coin/splash_screen.dart';
import 'package:we_coin/utils/api_constant.dart';
import 'package:we_coin/view/dashboard/navigation_pages/notification/PushNotifications.dart';
import 'package:hive/hive.dart';
import 'package:we_coin/view/dashboard/navigation_pages/transaction/transaction.dart';
import 'data/repositry/add_tickets_repo.dart';
import 'data/repositry/auth_repo.dart';
import 'data/repositry/currencies_get_repo.dart';
import 'data/repositry/edit_profilr_repo.dart';
import 'data/repositry/home_repo.dart';
import 'data/repositry/identity_verification.dart';
import 'data/repositry/image_pick_provider.dart';
import 'data/repositry/otp_verification.dart';
import 'data/repositry/send_money_repo.dart';
import 'data/repositry/settings_repo.dart';
import 'data/repositry/view_profile_get.dart';
import 'data/repositry/view_tickets_repo.dart';
import 'package:path_provider/path_provider.dart';

// import 'firebase_options.dart';

// final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
// FlutterLocalNotificationsPlugin();
/*Future<void> backgroundHandler(RemoteMessage message) async {
  print(message.data.toString());
  print(message.notification.title);
}*/
Future<void> backgroundHandler(RemoteMessage message) async {
  print(message.data.toString());
  print(message.notification!.title);
}

void main() {
  runZonedGuarded(() async {
    runApp(const MyApp());
    WidgetsFlutterBinding.ensureInitialized();
    var directory= await getApplicationDocumentsDirectory();
    Hive.init(directory.path);
    await Firebase.initializeApp(
      // options: DefaultFirebaseOptions.currentPlatform,
    );
    FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
    PushNotificationService(firebaseMessaging).initialise();
  }, (dynamic error, dynamic stack) {
    developer.log("Something went wrong!", error: error, stackTrace: stack);
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => Auth_Provider()),
        ChangeNotifierProvider(create: (context) => IdentityVerification()),
        ChangeNotifierProvider(create: (context) => EditProfile_Provider()),
        ChangeNotifierProvider(create: (context) => OtpVerified_Provider()),
        ChangeNotifierProvider(create: (context) => ViewProfile_Provider()),
        ChangeNotifierProvider(create: (context) => SettingsProvider()),
        ChangeNotifierProvider(create: (context) => AddTickets_Provider()),
        ChangeNotifierProvider(create: (context) => ViewTickets_Provider()),
        ChangeNotifierProvider(create: (context) => SendMoney_Provider()),
        ChangeNotifierProvider(create: (context) => CurrenciesProvider()),
        ChangeNotifierProvider(create: (context) => ProfileImageController()),
        ChangeNotifierProvider(create: (context) => HomeProvider()),
      ],
      child: ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            title: ApiConstants.APP_NAME,
            // You can use the library anywhere in the app even in theme
            theme: ThemeData(
              primarySwatch: Colors.blue,
              textTheme: Typography.englishLike2018.apply(fontSizeFactor: 1.sp),
            ),
            home: child,
          );
        },
        // child: HomePage(),
        child: SplashScreen(),
      ),
    );
  }
}
