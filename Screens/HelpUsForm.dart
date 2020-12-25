
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:project2/Components/MainDrawer.dart';
import 'package:project2/Constant/Values.dart';
import 'package:project2/Components/TextInput.dart';
import 'package:project2/Components/ShowFancyDialog.dart';
import 'package:project2/MiningModels/FormBuildModel.dart';
import 'package:project2/MiningModels/buildHelpRecord.dart';
import 'package:project2/Network/SingInByEmailApi.dart';
import 'package:project2/Screens/FormResultScreen.dart';
import 'package:project2/Screens/HomeScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';


class HelpUsForm extends StatefulWidget {
	@override
	_HelpUsFormState createState() => _HelpUsFormState();
}

enum SingingCharacter { lafayette, jefferson }


class _HelpUsFormState extends State<HelpUsForm> {
	static const String id = 'PredictionForm';
	String userId;
	SharedPreferences prefs;

	String date;
	int age;
	String feeling;
	String gender;



	List movieTypes;


	final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();



	@override
	void initState() {
		getShared();
		super.initState();
	}

	void getShared()async{
		prefs=await SharedPreferences.getInstance();
		print(prefs.getString('userId'));
		print("user id from Prediction HelpUsFor screen");
	}


	List formData = [""];

// ...

	SingingCharacter _character = SingingCharacter.lafayette;

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			drawer: MainDrawer(),
			appBar: AppBar(
				centerTitle: true,
				title: Row(
					mainAxisAlignment: MainAxisAlignment.center,
					children: <Widget>[
						Row(
							children: <Widget>[
								Text(
									"Cinema Pocket",
									style: Theme.of(context).textTheme.title,
								),
							],
						)
					],
				),
				backgroundColor: textInputColor,
			),
			body: GestureDetector(
				onTap: () {
					print(prefs.getString('userId'));
					FocusScope.of(context).requestFocus(new FocusNode());
				},
				child: Container(
					decoration: BoxDecoration(
						gradient: defaultlinearGradiantDecorantion,
					),
					child: Center(
						child: SingleChildScrollView(
							child: Column(
								mainAxisSize: MainAxisSize.max,
								mainAxisAlignment: MainAxisAlignment.center,
								children: <Widget>[
									Text(
										"HELP US IMPROVE",
										style: Theme.of(context).textTheme.title,
									),
									Padding(
										padding: const EdgeInsets.all(15.0),
										child: Column(
											mainAxisAlignment: MainAxisAlignment.center,
											children: <Widget>[
												FormBuilder(
													//Link to it https://github.com/danvick/flutter_form_builder
													key: _fbKey,
													initialValue: {
														'date': DateTime.now(),
														'accept_terms': true,
													},
													autovalidate: true,
													child: Column(
														children: <Widget>[
															FormBuilderDropdown(
																attribute: "gender",
																decoration: InputDecoration(labelText: "Gender"),
																// initialValue: 'Male',
																hint: Text('Select Gender'),
																validators: [FormBuilderValidators.required()],
																items: ['Male', 'Female']
																		.map((gender) => DropdownMenuItem(
																		value: gender,
																		child: Text("$gender")
																)).toList(),
															),
															FormBuilderTextField(
																attribute: "age",
																decoration: InputDecoration(labelText: "Age"),
																validators: [
																	FormBuilderValidators.numeric(),
																	FormBuilderValidators.max(70),
																],
															),
															FormBuilderFilterChip(
																validators: [
																	FormBuilderValidators.required(),
																],
																attribute: "movieTypes",
																options: [
																	FormBuilderFieldOption(
																			child: Text("Action"),
																			value: "Action"
																	),
																	FormBuilderFieldOption(
																			child: Text("Horror"),
																			value: "Horror"
																	),
																	FormBuilderFieldOption(
																			child: Text("Romance"),
																			value: "Romance"
																	),
																	FormBuilderFieldOption(
																			child: Text("Adventure"),
																			value: "Adventure"
																	),
																	FormBuilderFieldOption(
																			child: Text("Drama"),
																			value: "Drama"
																	),
																	FormBuilderFieldOption(
																			child: Text("Cartoon"),
																			value: "Cartoon"
																	),
																	FormBuilderFieldOption(
																			child: Text("Comedy"),
																			value: "Comedy"
																	),
																],
															),
															FormBuilderRadio(
																decoration:
																InputDecoration(labelText: "Descripe how you feel right now",),
																attribute: "feeling",
																initialValue: ["Sad"],
																options: [
																	FormBuilderFieldOption(value: Sad),
																	FormBuilderFieldOption(value: Angry),
																	FormBuilderFieldOption(value: Disgust),
																	FormBuilderFieldOption(value: Scared),
																	FormBuilderFieldOption(value: Surpris),
																	FormBuilderFieldOption(value: Happy),
																],
															),
															Padding(
																padding: const EdgeInsets.all(10.0),
																child: SizedBox(
																	width: 300,
																	height: 50,
																	child: RaisedButton(
																			shape: RoundedRectangleBorder(
																					borderRadius: new BorderRadius.circular(30.0)),
																			padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
																			color: textInputColor,
																			child: Text(
																				"Send survey",
																				style: Theme.of(context).textTheme.title,
																			),
																			onPressed: () async{
																				print('hi');
																				if (_fbKey.currentState.saveAndValidate()) {
																					print(_fbKey.currentState.value);
																					Map<String,dynamic> formValues = _fbKey.currentState.value ;
																					date=formValues['date'].toString();
																					age=int.parse(formValues['age']);
																					feeling =formValues['feeling'];
																					gender=formValues['gender'];
																					movieTypes=formValues['movieTypes'];
																					buildHelpRecord(feeling,age,gender,movieTypes);
																					//then will take u to FormResultScreen
																					Navigator.push(context,
																						MaterialPageRoute(builder: (context) => HomeScreen()),
																					);
																				}
																			}),
																),
															),
														],
													),
												),

											],
										),
									),
								],
							),
						),
					),
				),
			),
		);
	}
}
