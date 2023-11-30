import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:voicenotesapp/auth/forgot_password.dart';
import 'package:voicenotesapp/auth/signup_screen.dart';
import 'package:voicenotesapp/constants/constants.dart';
import 'package:voicenotesapp/screens/noteList.dart';
import 'package:voicenotesapp/utils/utilities.dart';
import 'package:voicenotesapp/widgtes/custom_textformfeild.dart';
import 'package:voicenotesapp/widgtes/custombuttons.dart';
import 'package:voicenotesapp/widgtes/customtext.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool loading=false;
  final _formkey= GlobalKey<FormState>();
  TextEditingController _emailcontroller= TextEditingController();
  TextEditingController _passwordcontroller= TextEditingController();
  FirebaseAuth _auth=FirebaseAuth.instance;
  bool _isPasswordVisible = false;
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailcontroller.dispose();
    _passwordcontroller.dispose();

  }
  void login(){
    setState(() {
      loading=true;
    });
    _auth.signInWithEmailAndPassword(email: _emailcontroller.text.toString(),
        password: _passwordcontroller.text.toString()).then((value) {
          Utils().toasteMessage('WELCOME back!');
          //Utils().toasteMessage(value.user!.email.toString());
          Navigator.push(context, MaterialPageRoute(builder:(context)=> const NoteList()));
          setState(() {
            loading=false;
          });
    }).onError((error, stackTrace) {

      debugPrint(error.toString());
      Utils().toasteMessage(error.toString());
      setState(() {
        loading=false;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async{
        SystemNavigator.pop();
        return true;
      },
      child: Container(
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
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.fromLTRB(15,0, 15, 10),
                  child: Image(image: AssetImage('assets/login.png')),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(5, 20, 5, 20),
                  child: Form(
                    key: _formkey,
                      child:Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: CustomTextFormField(
                              controller: _emailcontroller,
                              keyboardType: TextInputType.emailAddress,
                                prefixIcon: const Icon(Icons.email),
                                hintText: 'Enter your Email',
                                labelText: 'Email',
                              validator: (value){
                                if(value!.isEmpty){
                                  return 'Enter Email';
                                } else if (!value.contains('@')) {
                                  return 'Enter a valid email';
                                }
                                return null;
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child:CustomTextFormField(
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

                        ],
                      )),
                ),
                const SizedBox(
                  height: 20,
                ),
                RectangularButton(text: 'Sign In', press: (){
                  if (_formkey.currentState!.validate()) {
                    login();
                  }}),
                /*RoundButton(title: 'LOGIN',
                loading: loading,
                ontap: (){
                  if(_formkey.currentState!.validate()){
                    login();
                  };

                },),*/
                const SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    Align(
                      alignment: Alignment.bottomLeft,
                      child: TextButton(onPressed:(){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> const ForgotPasswordScreen()));
                      }, child: MainText(text:'Forget Password?'),
                    ))

                  ]
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MainText(
                      text:"Don't have an account? ",

                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SignUpScreen(),
                          ),
                        );
                      },
                      child: HeadingText(
                        text: 'Sign Up',

                      ),
                    ),
                  ],
                ),






              ],
            ),
          ),
        ),
      ),
    );
  }
}
