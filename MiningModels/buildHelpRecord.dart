import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:project2/Components/ToastLong.dart';
import 'package:project2/Constant/API.dart';
import 'package:shared_preferences/shared_preferences.dart';




Future<void> buildHelpRecord(String  feeling,int  age, String gender,List movieTypes ) async{
	print('from minning model and $feeling  and $age and  $gender $movieTypes');

	//userName='mm';
	//pass='123';
	SharedPreferences prefs=await SharedPreferences.getInstance();
	String userId=prefs.getString('userId').toString();
	if(userId==null || userId==''){
		userId='guests';
	}
	var uri = postHelpSurvey;

	// paramas :     ?USER_NAME=mm& CREATION_DATE  GENDER    FEELING  AGE  PREDICTED_TYPES
	//uri =uri+'?USER_ID=$userId&CREATION_DATE=$date&GENDER=$gender&AGE=$age&FEELING=$feeling&PREDICTED_TYPES=$predictedMovieTypes';

	var response = await http.post(uri+'?USER_ID=$userId&AGE=$age&GENDER=$gender&FEELING=$feeling&MOVIE_TYPES=$movieTypes');
	print(uri);
	//print(map);
	var message=jsonDecode(response.body)['Message'];
	var statusCode=response.statusCode;
	print(message);
	if(statusCode==200){
		print(userId);
		showLongToast(message);
		showLongToast('Thanks for help us improve');
	}
	else{
		showLongToast("Something wrong while posting Form Record$message");
	}

	//return formId;
}
