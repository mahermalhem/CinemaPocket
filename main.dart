import 'package:flutter/material.dart';
import 'package:project2/RouteGenerator.dart';
import 'package:project2/Screens/SignIn.dart';
import 'NavigationService.dart';
import 'Screens/SignIn.dart';
import 'Screens/HomeScreen.dart';
import 'LandingPage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: key,
      theme: ThemeData(
        // Define the default brightness and colors.
        brightness: Brightness.dark,
        primaryColor: Colors.lightBlue[800],
        accentColor: Colors.cyan[600],
        // Define the default font family.
        fontFamily: 'Georgia',
        // Define the default TextTheme. Use this to specify the default
        // text styling for headlines, titles, bodies of text, and more.
        textTheme: TextTheme(
          headline: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold,),
          title: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic,),
          body1: TextStyle(fontSize: 14.0, fontFamily: 'Hind',),
          body2: TextStyle(fontSize: 17.0, fontFamily: 'Lato',),
        ),
      ),
      title: 'Welcome to Cinema pocket',
      initialRoute:'/',
      onGenerateRoute: RouteGenerator.generateRoute,
      //home: LandingPage(),
    );
  }

}
