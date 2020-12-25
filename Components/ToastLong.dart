import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void showLongToast(String msg) {
	Fluttertoast.showToast(
			msg: msg,
			toastLength: Toast.LENGTH_SHORT,
			backgroundColor: Colors.purpleAccent,
			textColor: Colors.white);
}


