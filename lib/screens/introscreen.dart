import 'package:flutter/material.dart';
import 'package:voicenotesapp/auth/login_screen.dart';
import 'package:voicenotesapp/constants/constants.dart';
import 'package:voicenotesapp/widgtes/custombuttons.dart';


class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                lightPrimary,
                darkPrimary,
              ]
          )
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(15, 100, 15, 10),
              child: Image(image: AssetImage('assets/Intro image.png')),
            ),
            RectangularButton(text: 'Get Start', press: (){
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const LoginScreen(),
                ),
              );

             }),
          ],
        ),
      ),
    );
  }
}


