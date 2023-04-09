import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:tirta/routes/app_pages.dart';

import 'modules/splash/splash_screen.dart';

class TirtaApp extends StatelessWidget {
  const TirtaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Tirta',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      defaultTransition: Transition.leftToRightWithFade,
      home: const SplashScreen(),
      getPages: AppPages.pages,
    );
  }
}