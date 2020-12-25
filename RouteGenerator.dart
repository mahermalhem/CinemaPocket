import 'package:flutter/material.dart';
import 'package:project2/LandingPage.dart';
import 'package:project2/Screens/HomeScreen.dart';
import 'package:project2/Screens/SignIn.dart';
import 'MyHomePage.dart';
import 'Screens/FormResultScreen.dart';
import 'Screens/PredictionForm.dart';
import 'main.dart';


class RouteGenerator{
	static Route<dynamic> generateRoute(RouteSettings settings){
		final args=settings.arguments;

		switch(settings.name){
			/*case "/" :
				return MaterialPageRoute(builder: (_) =>LandingPage() );*/
			case "/" :
				return MaterialPageRoute(builder: (_) =>MyHomePage() );
			case '/HomeScreen':
				return MaterialPageRoute(builder: (_) =>HomeScreen() );
			case '/SignIn':
				return MaterialPageRoute(builder: (_) =>SignIn() );
			case '/PredictionForm':
				return MaterialPageRoute(builder: (_) =>PredictionForm() );
			case '/FormResultScreen':
				return MaterialPageRoute(builder: (_) =>FormResultScreen() );

			default:return MaterialPageRoute(builder: (_) =>LandingPage() );
		}

	}
}
