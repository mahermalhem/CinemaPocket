import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:project2/Components/ToastLong.dart';
import 'package:project2/Constant/API.dart';
import 'package:project2/Datatype/movie.dart';
import 'package:project2/Network/getMovieDetail.dart';
import 'package:project2/Screens/SignIn.dart';
import 'package:shared_preferences/shared_preferences.dart';


Future<void> postComment(String comment) async{


	SharedPreferences prefs=await SharedPreferences.getInstance();
	String userId=prefs.getString('userId').toString();
	String movieId=prefs.getString('movieId').toString();
	var uri = postMovieCommentByUserIdAndMovieId;
	// paramas :     ?USER_NAME=mm& CREATION_DATE  GENDER    FEELING  AGE  PREDICTED_TYPES
	uri =uri+'?MOVIE_ID=$movieId&USER_ID=$userId&COMMENT_DESC=$comment';
	var response = await http.post(uri);
	print(uri);
	//print(map);
	var message=jsonDecode(response.body)['Message'];
	var statusCode=response.statusCode;

	print(message);

	if(statusCode==200){
		print(userId);
		print(movieId);
		showLongToast(message);
	}
	else{
		showLongToast("Something wrong while posting Form Record  $message");
	}

	//return formId;
}