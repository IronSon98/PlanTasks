import 'package:flutter/material.dart';
import 'package:plan_tasks/screens/splash_screen.dart';
import 'package:plan_tasks/utils/colors.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: primaryColorCustom,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: SplashScreen(),
    ),
  );
}
