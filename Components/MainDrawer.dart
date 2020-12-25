import 'package:flutter/material.dart';
import 'package:project2/Constant/Values.dart';
import 'package:project2/Screens/HelpUsForm.dart';
import 'package:project2/Screens/UserForms.dart';
import 'package:project2/Screens/ProfilePage.dart';
import 'package:project2/Screens/SignIn.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'custom-drawer-tile.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';



class MainDrawer extends StatefulWidget {
  @override
  _MainDrawerState createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {
	bool isLogged;
	String userId;

	@override
	void initState() {
		getShared();
		super.initState();
	}


  void getShared() async {
		SharedPreferences prefs = await SharedPreferences.getInstance();
		isLogged = prefs.getBool('isLogged');
		userId = prefs.getString('userId');
		print('in main drawer is logged$isLogged');
		print(userId);
	}
  @override
  Widget build(BuildContext context) {
			return Drawer(
				child: Container(
					decoration: BoxDecoration(
						gradient: defaultlinearGradiantDecorantion,
					),
				  child: ListView(
				  	children: <Widget>[
				  		DrawerHeader(
				  			child:Center(
				  				child: Image(
				  					image: AssetImage('images/cinemapocket.jpeg'),
				  					fit: BoxFit.fill,
				  				),
				  			)
				  		),
				  		/*CustomTile(
				  			text: "Account",
				  			icon: Icons.person,
				  			onPress: () {
				  				Navigator.push(context,
										MaterialPageRoute(builder: (context) => ProfilePage()),
									);
								}
				  		),*/
				  		/*CustomTile(
				  			text: "Fav",
				  			icon: FontAwesomeIcons.heart,
				  			onPress: () {
				  			},
				  		),*/
				  		CustomTile(
				  			text: "My forms",
				  			icon: FontAwesomeIcons.edit,
				  			onPress: () {
									Navigator.push(
										context,
										MaterialPageRoute(builder: (context) => UserForms()),
									);
				  			},
				  		),
				  		/*CustomTile(
				  			text: "My pictures",
				  			icon: FontAwesomeIcons.images,
				  			onPress: () {

				  			},
				  		),*/
				  		CustomTile(
				  			text: "Help us improve",
				  			icon: FontAwesomeIcons.whmcs,
				  			onPress: () async {
									Navigator.push(context,
									MaterialPageRoute(builder: (context) => HelpUsForm()),
									);
				  			},
				  		),
				  		CustomTile(
				  			text: "Sign out",
				  			icon: FontAwesomeIcons.signOutAlt,
				  			onPress: () async {
				  				SharedPreferences prefs = await SharedPreferences.getInstance();
				  				prefs.setBool('isLogged',false);
				  				prefs.setString('userId',null);
				  				Navigator.pushAndRemoveUntil(
				  					context,
				  					MaterialPageRoute(builder: (context) => SignIn()),
				  							(Route<dynamic> route) => false,
				  				);
				  			},
				  		),
				  	],
				  ),
				),
			);
		}
	}
