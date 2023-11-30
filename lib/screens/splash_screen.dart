import 'package:voicenotesapp/firebase_services/splash_services.dart';
import 'package:flutter/material.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}
class _SplashScreenState extends State<SplashScreen> {
  SplashServices splashscreen= SplashServices();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    splashscreen.islogin(context);
  }
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child:  Image(image: AssetImage('assets/logo.PNG')),),
    );
  }
}
