import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void customToast({bool? isError, required String msg}) {
  Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: isError ?? false ? Colors.red : Colors.green,
      textColor: Colors.white,
      fontSize: 16.0);
}
