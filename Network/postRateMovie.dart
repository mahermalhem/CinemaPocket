import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:project2/Components/ToastLong.dart';
import 'package:project2/Constant/API.dart';
import 'package:project2/Datatype/movie.dart';
import 'package:project2/Network/getMovieDetail.dart';
import 'package:project2/Screens/SignIn.dart';
import 'package:shared_preferences/shared_preferences.dart';


Future<void> postRateMovie(double numOfstars) async{

	SharedPreferences prefs=await SharedPreferences.getInstance();
	String userId=prefs.getString('userId').toString();
	String movieId=prefs.getString('movieId').toString();

	var uri = postRatingMovieApi;


	var response = await http.put(uri+'?MOVIE_ID=$movieId&MOVIE_NAME=&USER_ID=$userId&USER_NAME=&stars=$numOfstars');
	print(uri);
	//print(map);
	var message=jsonDecode(response.body)['Message'];
	var statusCode=response.statusCode;

	print(message);

	if(statusCode==200){
		print(userId);
		print(movieId);
		showLongToast("$message");
	}
	else{
		showLongToast("Something wrong while posting Form Record  $message");
	}


	//return formId;
}