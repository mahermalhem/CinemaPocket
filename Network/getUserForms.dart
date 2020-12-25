

import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:project2/Components/ToastLong.dart';
import 'package:project2/Constant/API.dart';
import 'package:project2/Datatype/form.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<List<Form>> getUserForms() async {
	List<Form> FormList=[];

	SharedPreferences prefs = await SharedPreferences.getInstance();
	String userId=prefs.getString('userId').toString();

	String uri = getUserFormsByUserId;


	var response = await http.get(uri+'?USER_ID=$userId');
	print(uri);
	List items = jsonDecode(response.body)['items'];
	var message = response.statusCode;
	print('status from get all form api $message');
	if (message == 200) {
		for (int i = 0; i < items.length; i++) {
			FormList.add(Form(
					user_id:items[i]['user_id'],
					gender:items[i]['gender'] ,
					movie_duration:items[i]['movie_duration'] ,
					creation_date:items[i]['creation_date'] ,
					age: items[i]['age'],
					feeling:items[i]['feeling'] ,
					form_id:items[i]['form_id'],
					predicted_types:items[i]['predicted_types'],
			));
		}
		print(FormList.length);
	}


	else {
		showLongToast("check you internet connection or somthing else in the link");
	}

	return FormList;
}


