import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nft_marketplace/pages/settingpage.dart';
import 'package:nft_marketplace/services/auth.dart';
import 'package:nft_marketplace/services/database.dart';
import 'package:provider/provider.dart';
import 'pages/categorypage.dart';
import 'controllers/controller.dart';
import 'pages/homepage.dart';
import 'pages/splashscreen.dart';
import 'pages/profilepage.dart';
import 'pages/landingpage.dart';
import 'pages/authpage.dart';
import 'package:firebase_core/firebase_core.dart';

import 'wrapper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider.value(value: AuthService().user, initialData: null),
        StreamProvider.value(value: DatabaseService().nfts, initialData: null),
        Provider<AuthService>(
          create: (_) => AuthService(),
        )
      ],
      child: GetMaterialApp(
        title: 'NFT Marketplace App',
        theme: ThemeData(
            primarySwatch: Colors.teal,
            fontFamily: 'Manrope',
            appBarTheme: const AppBarTheme(
                iconTheme: IconThemeData(color: Colors.black))),
        debugShowCheckedModeBanner: false,
        initialBinding: BindingsBuilder(() => {Get.put(UserController())}),
        initialRoute: '/',
        getPages: [
          GetPage(name: '/', page: () => const SplashScreen()), //SplashScreen,
          GetPage(name: '/landingpage', page: () => const LandingPage()),
          GetPage(name: '/wrapper', page: () => const Wrapper()),
          GetPage(name: '/homepage', page: () => const HomePage()),
          GetPage(name: '/profilepage', page: () => const ViewProfile()),
          GetPage(name: '/loginpage', page: () => LoginPage()),
          GetPage(name: '/registpage', page: () => RegistPage()),
          GetPage(name: '/categorypage', page: () => const CategoryPage()),
          GetPage(name: '/settingpage', page: () => const SettingPage()),
        ],
      ),
    );
  }
}
