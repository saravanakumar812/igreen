import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:igreen_flutter/provider/menuProvider.dart';

import 'package:igreen_flutter/routes/app_pages.dart';
import 'UI/BottomNavBarScreen.dart';

import 'UI/Screens/LoginScreen.dart';
import 'Utils/AppPreference.dart';
import 'forms/theme.dart';
import 'routes/app_routes.dart';
import 'package:provider/provider.dart';
import 'dart:io';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppPreference().init();

  ByteData data = await PlatformAssetBundle().load('assets/certificate/ApacheJMeterTemporaryRootCA.crt');
  SecurityContext.defaultContext.setTrustedCertificatesBytes(data.buffer.asUint8List());

  runApp(
    ChangeNotifierProvider<menuDataProvider>(
      create: (_) => menuDataProvider(),
      child: MyApp(),
    ),


  );

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: AppTheme.secondaryColor,
    ));

    final ThemeData appTheme = ThemeData(
      appBarTheme: AppBarTheme(
        elevation: 4,
        systemOverlayStyle: SystemUiOverlayStyle.light,
        backgroundColor: AppTheme.white,
      ),
    );

    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return GetMaterialApp(
          builder: (BuildContext context, Widget? child) {
            final mediaQueryData = MediaQuery.of(context);
            final scale = mediaQueryData.textScaleFactor.clamp(1.0, 1.3);
            return MediaQuery(
              data: mediaQueryData.copyWith(textScaleFactor: 1.0),
              child: child!,
            );
          },
          home:
              AppPreference().getEmpId == null || AppPreference().getEmpId == 0
                  ? LoginScreen()
                  : BottomNavBar(),
          debugShowCheckedModeBanner: false,
          title: 'IGreen',
          theme: ThemeData.light().copyWith(
            // Set the white theme

            textSelectionTheme: TextSelectionThemeData(
                selectionHandleColor: Colors.transparent),

            primaryColor: Colors.white,
            scaffoldBackgroundColor: Colors.white,
            textButtonTheme: TextButtonThemeData(
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
              ),
            ),
            textTheme: GoogleFonts.latoTextTheme(Theme.of(context)
                .textTheme
                .apply(
                  bodyColor: Colors.white,
                  displayColor: Colors.white,
                )
                .copyWith(
                  titleLarge: const TextStyle(
                    color: Color(0xff252525),
                    fontWeight: FontWeight.bold,
                  ),
                  titleMedium: const TextStyle(color: Color(0xffA4A4A4)),
                  bodyLarge: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                )),
          ),
          initialRoute:
              AppPreference().getEmpId == null || AppPreference().getEmpId == 0
                  ? AppRoutes.root.toName
                  : AppRoutes.bottomNavBar.toName,
          getPages: AppPages.list,
        );
      },
    );
  }
}
