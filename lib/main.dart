import 'package:capitalhub_crm/screen/01-Investor-Section/landingScreen/landing_screen_inv.dart';
import 'package:capitalhub_crm/screen/landingScreen/landing_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'firebase_options.dart';
import 'screen/Auth-Process/selectWhatYouAreScreen/select_role_screen.dart';
import 'utils/getStore/get_store.dart';
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
      home: GetStoreData.getStore.read('access_token') == null
          ? const SelectRoleScreen()
          : GetStoreData.getStore.read('isInvestor')
              ? LandingScreenInvestor()
              : LandingScreen(),
      //   ? LandingScreenInvestor()
      // : LandingScreen(),
      theme: ThemeData(useMaterial3: true),
    );
  }
}
