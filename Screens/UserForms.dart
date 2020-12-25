import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project2/Components/ShowFancyDialog.dart';
import 'package:project2/Components/formCard.dart';
import 'package:project2/Constant/Values.dart';
import 'package:project2/Components/MainDrawer.dart';
import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:project2/Network/getUserForms.dart';
import 'package:project2/Screens/pickImage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'PredictionForm.dart';
import 'package:project2/Datatype/form.dart';


class UserForms extends StatefulWidget {
	@override
	_UserFormsState createState() => _UserFormsState();
}

class _UserFormsState extends State<UserForms> {
	static const String id = 'Forms';

	SharedPreferences prefs;

	@override
	void initState() {
		getShared();
		super.initState();
	}

	void getShared() async {
		prefs = await SharedPreferences.getInstance();
		print("user id from home screen");
		String us = prefs.getString('userId');
	}

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			floatingActionButton: FabCircularMenu(
					alignment: Alignment(-1, 1),
					fabMargin: EdgeInsets.all(16),
					fabColor: floatingColor,
					fabSize: 100,
					ringWidth: 60,
					fabElevation: 23,
					fabCloseColor: Colors.black38,
					fabOpenColor: floatingColor,
					fabOpenIcon: Icon(
						Icons.live_help,
						size: 35,
					),
					ringDiameter: 250.0,
					ringColor: floatingColor,
					children: <Widget>[
						IconButton(
								icon: Icon(Icons.library_books),
								iconSize: 40,
								onPressed: () {
									print(prefs.getString('userId'));
									Navigator.push(
										context,
										MaterialPageRoute(builder: (context) => PredictionForm()),
									);
								}),
						IconButton(
								icon: Icon(Icons.camera_alt),
								iconSize: 40,
								onPressed: () {
									ShowFancyDialog(
											context, 'Soon', "we will handle this", () {
										print("zero answer");
									});
								}),
					]),
			appBar: AppBar(
				centerTitle: true,
				title: Row(
					mainAxisAlignment: MainAxisAlignment.center,
					children: <Widget>[
						Row(
							children: <Widget>[
								Text(
									"Cienma Pocket",
									style: Theme
											.of(context)
											.textTheme
											.title,
								),
							],
						)
					],
				),
				backgroundColor: textInputColor,
			),
			body: Container(
				decoration: BoxDecoration(
					gradient: defaultlinearGradiantDecorantion,
				),
				child: FormsFutureBuilder(),
			),
		);
	}

	 FormsFutureBuilder() {
		//ScrollController _scrollController = new ScrollController();
		return FutureBuilder(
			future: getUserForms(),
			builder: (BuildContext context, snapshot) {
				if (snapshot.hasData)
					switch (snapshot.connectionState) {
						case ConnectionState.none:
							return Center(child: CircularProgressIndicator());
						case ConnectionState.active:
							return Center(child: CircularProgressIndicator());
						case ConnectionState.waiting:
							return Center(child: CircularProgressIndicator());
						case ConnectionState.done:
							return Center(
								child: Padding(
									padding: const EdgeInsets.all(12.0),
									child: GridView.builder(
										itemCount: snapshot.data.length,
										gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
												crossAxisCount: 2,
												crossAxisSpacing: 4.0,
												mainAxisSpacing: 25.0),
										itemBuilder: (BuildContext context, int index) {
											return InkWell(
												splashColor: Colors.blueGrey,
												onTap: () {
												},
												child:formCard(
													age: snapshot.data[index].age,
													feeling: snapshot.data[index].feeling,
													predicted_types:snapshot.data[index].predicted_types ,
													gender:snapshot.data[index].gender ,
													creation_date: snapshot.data[index].creation_date,
												),
											);// formCard();
										},
									),
								),
							);
						default:
							return Text("Sorry No data Retrived");
					}
				else if (snapshot.hasError) {
					return Text("please check your internet connection");
				}
				return Center(child: CircularProgressIndicator());
			},
		);
	}



}


