import 'package:fancy_dialog/FancyAnimation.dart';
import 'package:fancy_dialog/FancyGif.dart';
import 'package:fancy_dialog/FancyTheme.dart';
import 'package:fancy_dialog/fancy_dialog.dart';
import 'package:flutter/material.dart';


	void ShowFancyDialog (BuildContext context,title,desc,Function){
		showDialog(
				context: context,
				builder: (BuildContext context) => FancyDialog(
					title: title,
					descreption:desc,
					animationType: FancyAnimation.LEFT_RIGHT,
					theme: FancyTheme.FANCY,
					gifPath: FancyGif.MOVE_FORWARD, //'./assets/walp.png',
					okFun: () async {

					}
					)
		);
	}