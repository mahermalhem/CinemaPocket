import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:project2/Components/ToastLong.dart';
import 'package:project2/Constant/API.dart';
import 'package:project2/Screens/HomeScreen.dart';
import 'package:project2/Screens/SignIn.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:project2/RouteGenerator.dart';


Future<void> SingInByEmailApi(String userName,String pass) async {
	String userId;
	//userName='mm';
	//pass='123';

	SharedPreferences prefs=await SharedPreferences.getInstance();

	var uri = loginByUserNameAndPass;


	// paramas :     ?USER_NAME=mm&PASSWORD=123
	uri =uri+'?USER_NAME=$userName&PASSWORD=$pass';

	var response = await http.get(uri);

	print(uri);
	//print(map);
	var itemsCount=jsonDecode(response.body)['count'];
	var item=jsonDecode(response.body)['items'];
	var message=response.statusCode;


	print(message);
	print(itemsCount);


	if(message==200 && itemsCount!=0){
		userId=item[0]['id'];
		prefs.setString('userId',userId);
		prefs.setBool('isLogged', true);
	}
	else{
		showLongToast("Please check username or pass both are casesensitive");
	}

}


