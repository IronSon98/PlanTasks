import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:plan_tasks/screens/home_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIOverlays([]);
    Future.delayed(Duration(seconds: 4)).then(
      (_) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/imgs/splash.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Center(
        child: Container(
          width: 300.0,
          height: 300.0,
          child: Image.asset('assets/imgs/image2.png'),
        ),
      ),
    );
  }
}
