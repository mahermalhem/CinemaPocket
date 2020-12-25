import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Screens/HomeScreen.dart';
import 'Screens/SignIn.dart';



class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {

	TextEditingController nameController = TextEditingController();

	bool isLoggedIn = false;

	@override
	void initState() {
		super.initState();
		autoLogIn();
	}

	void autoLogIn() async {
		final SharedPreferences prefs = await SharedPreferences.getInstance();
		final String userId = prefs.getString('userId');

		if (userId != null) {
			setState(() {
				isLoggedIn = true;
			});
			return;
		}
	}

	@override
	Widget build(BuildContext context) {
		return isLoggedIn ? HomeScreen() : SignIn() ;
	}
}


