import 'package:capitalhub_crm/screen/01-Investor-Section/landingScreen/landing_screen_inv.dart';
import 'package:capitalhub_crm/screen/landingScreen/landing_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'screen/Auth-Process/selectWhatYouAreScreen/select_role_screen.dart';
import 'utils/getStore/get_store.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  await GetStorage.init();
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
