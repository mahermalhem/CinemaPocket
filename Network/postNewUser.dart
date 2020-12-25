import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:project2/Components/ToastLong.dart';
import 'package:project2/Constant/API.dart';
import 'package:project2/Datatype/movie.dart';
import 'package:project2/Network/getMovieDetail.dart';
import 'package:project2/Screens/SignIn.dart';
import 'package:shared_preferences/shared_preferences.dart';


Future<void> postNewUser({
	String gender,
	String username,
	String password,
	String birthdate,
	String address,
	String email,
	String preferredTypes,
}) async{

	SharedPreferences prefs=await SharedPreferences.getInstance();


	var uri = postNewUserAccount;
	// paramas :     ?USER_NAME=mm& CREATION_DATE  GENDER    FEELING  AGE  PREDICTED_TYPES
	uri =uri+'?NAME=$username&USER_NAME=$username&PASSWORD=$password&EMAIL=$email&BIRTH_DATE=$birthdate&GENDER=$gender&CITY=$address&ADDRESS=$address&PREFERRED_TYPES=$preferredTypes';
	var response = await http.post(uri);
	print(uri);
	//print(map);
	var message=jsonDecode(response.body)['Message'];
	var statusCode=response.statusCode;

	print(message);

	if(statusCode==200){

		prefs.setBool('isLogged', true);
		showLongToast(message);
	}
	else{
		showLongToast("Something wrong while posting Form Record  $message");
	}

}