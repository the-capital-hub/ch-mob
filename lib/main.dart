import 'package:capitalhub_crm/screen/landingScreen/landing_screen_inv.dart';
import 'package:capitalhub_crm/screen/landingScreen/landing_screen.dart';
import 'package:capitalhub_crm/utils/appcolors/app_colors.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'firebase_options.dart';
import 'screen/Auth-Process/selectWhatYouAreScreen/select_role_screen.dart';
import 'utils/downloadService/download_service.dart';
import 'utils/getStore/get_store.dart';
import 'utils/notificationService/local_notification_service.dart';
import 'utils/notificationService/notification_service.dart';

@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("Handling background message: ${message.messageId}");
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  await GetStorage.init();
  await NotificationService().init();
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (e) {
    print(' Firebase initialization failed: $e');
  }
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  await Get.putAsync(() => FirebaseNotificationService().initialize());
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Capitalhub',
      debugShowCheckedModeBanner: false,
      theme: AppThemes.lightTheme,
      darkTheme: AppThemes.darkTheme,
      themeMode: ThemeMode.system,
      home: GetStoreData.getStore.read('access_token') == null
          ? const SelectRoleScreen()
          : GetStoreData.getStore.read('isInvestor')
              ? LandingScreenInvestor()
              : LandingScreen(),
      //   ? LandingScreenInvestor()
      // : LandingScreen(),
      // theme: ThemeData(useMaterial3: true, splashColor: AppColors.transparent),
    );
  }
}

class AppThemes {
  static ThemeData get lightTheme => ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        scaffoldBackgroundColor: Colors.white,
        splashColor: AppColors.transparent,
        textTheme: const TextTheme(bodyMedium: TextStyle(color: Colors.black)),
      );

  static ThemeData get darkTheme => ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Colors.black,
        splashColor: AppColors.transparent,
        textTheme: const TextTheme(bodyMedium: TextStyle(color: Colors.white)),
      );
}
