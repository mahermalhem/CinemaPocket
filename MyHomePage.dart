import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project2/Screens/HomeScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Screens/SignIn.dart';

class MyHomePage extends StatefulWidget {
	@override
	_MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
	TextEditingController nameController = TextEditingController();

	bool isLoggedIn = false;
	String name = '';

	@override
	void initState() {
		super.initState();
		print("hello form my home page$name");
		autoLogIn();
	}

	void autoLogIn() async {
		final SharedPreferences prefs = await SharedPreferences.getInstance();
		final String userId = prefs.getString('userId');
		print(prefs.getString('userId'));
		if (userId != null) {
			setState(() {
				isLoggedIn = true;
				name = userId;
			});
		}
	}
/*
	Future<Null> logout() async {
		final SharedPreferences prefs = await SharedPreferences.getInstance();
		prefs.setString('userId', null);

		setState(() {
			name = '';
			isLoggedIn = false;
		});
	}

	Future<Null> loginUser() async {
		final SharedPreferences prefs = await SharedPreferences.getInstance();
		prefs.setString('userId', nameController.text);

		setState(() {
			name = nameController.text;
			isLoggedIn = true;
		});

		nameController.clear();
	}
*/
	@override
	Widget build(BuildContext context) {
		return isLoggedIn ? HomeScreen() : SignIn();
	}
}