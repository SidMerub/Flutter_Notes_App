import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:voicenotesapp/constants/constants.dart';
import 'package:voicenotesapp/utils/utilities.dart';
import 'package:voicenotesapp/widgtes/custom_textformfeild.dart';
import 'package:voicenotesapp/widgtes/custombuttons.dart';





class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final emailController = TextEditingController();
  final auth = FirebaseAuth.instance;

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
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.fromLTRB(15,0, 15, 10),
                child: Image(image: AssetImage('assets/forget.png')),
              ),
              const Text(
                'Enter your  email below to receive a password reset link.',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              CustomTextFormField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                prefixIcon: const Icon(Icons.email),
                hintText: 'Enter your Email',
                labelText: 'Email',
              ),
              const SizedBox(height: 40),
              RectangularButton(text: 'Submit', press: (){
                auth.sendPasswordResetEmail(email: emailController.text.toString())
                    .then((value) {
                  Utils().toasteMessage(
                      'We have sent you an email to recover your password. Please check your email.');
                }).onError((error, stackTrace) {
                  Utils().toasteMessage(error.toString());
                });

                 }),

            ],
          ),
        ),
      ),
    );
  }
}

