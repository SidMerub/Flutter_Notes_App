
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:voicenotesapp/constants/constants.dart';

class Utils{
  void toasteMessage(String message){

    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
        backgroundColor: darkShadow,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }
}