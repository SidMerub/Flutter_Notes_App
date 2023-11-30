import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:voicenotesapp/auth/login_screen.dart';
import 'package:voicenotesapp/constants/constants.dart';
import 'package:voicenotesapp/utils/utilities.dart';
import 'package:voicenotesapp/widgtes/custom_textformfeild.dart';
import 'package:voicenotesapp/widgtes/custombuttons.dart';
class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool loading = false;
  final _formkey = GlobalKey<FormState>();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailcontroller = TextEditingController();
  TextEditingController _passwordcontroller = TextEditingController();
  FirebaseAuth _auth = FirebaseAuth.instance;
  bool _isPasswordVisible = false;
  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _emailcontroller.dispose();
    _passwordcontroller.dispose();
  }

  void signup() {
    setState(() {
      loading = true;
    });
    _auth.createUserWithEmailAndPassword(
      email: _emailcontroller.text.toString(),
      password: _passwordcontroller.text.toString(),
    ).then((value) {
      Utils().toasteMessage('Account successfully registered!');

      setState(() {
        loading = false;
      });
    }).onError((error, stackTrace) {
      setState(() {
        loading = false;
      });
      Utils().toasteMessage(error.toString());
    });
  }

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
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            //crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.fromLTRB(15, 15, 15, 10),
                child: Image(image: AssetImage('assets/signup.png')),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(5, 0, 5, 20),
                child: Form(
                  key: _formkey,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20,),
                        child: CustomTextFormField(
                          controller: _nameController,
                          keyboardType: TextInputType.text,
                          hintText: 'Enter Your Name',
                          labelText: 'Name',
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Enter your Name';
                            }
                            return null;
                          },
                          prefixIcon: const Icon(Icons.person),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: CustomTextFormField(
                          controller: _emailcontroller,
                          keyboardType: TextInputType.emailAddress,
                          hintText: 'Enter Your Email',
                          labelText: 'Email',
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Enter your Email';
                            }
                            return null;
                          },
                          prefixIcon: const Icon(Icons.email),
                        ),
                      ),


                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: CustomTextFormField(
                          controller: _passwordcontroller,
                          keyboardType: TextInputType.text,
                          obscureText:!_isPasswordVisible,

                          prefixIcon: const Icon(Icons.key),
                          suffixIcon:  IconButton(
                            icon: Icon(_isPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off),
                            onPressed: () {
                              setState(() {
                                _isPasswordVisible = !_isPasswordVisible;
                              });
                            },
                          ),
                          hintText: 'Enter Your Password',
                          labelText: 'Password',

                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Enter Password';
                            }
                            return null;
                          },
                        ),
                      ),
                      Padding(
                        padding:  const EdgeInsets.symmetric(horizontal: 20),
                        child: CustomTextFormField(
                          keyboardType: TextInputType.text,
                          obscureText: !_isPasswordVisible,
                          prefixIcon: const Icon(Icons.lock),
                          suffixIcon: IconButton(
                            icon: Icon(_isPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off),
                            onPressed: () {
                              setState(() {
                                _isPasswordVisible = !_isPasswordVisible;
                              });
                            },
                          ),
                          hintText: 'Confirm Password',
                          labelText: 'Confirm Password',

                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Confirm your password';
                            } else if (value != _passwordcontroller.text) {
                              return 'Passwords do not match';
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              RectangularButton(text: 'Sign In', press: (){
                    if (_formkey.currentState!.validate()) {
                    signup();
              }}),


            ],
          ),
        ),
      ),
    );
  }
}





