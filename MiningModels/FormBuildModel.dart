import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:project2/Components/ToastLong.dart';
import 'package:project2/Constant/API.dart';
import 'package:shared_preferences/shared_preferences.dart';

	String Sad = 'Sad';
	String Angry = 'Angry';
	String Disgust = 'Disgust';
	String Scared = 'Scared';
	String Surpris = 'Surpris';
	String Happy = 'Happy';
	List<String> predictedMovieTypes;


	Future<void>buildMiningModel(String date,String  feeling,int  age, String gender) {
		predictedMovieTypes = [];
		print('from minning model $date and $feeling  and $age and  $gender');

		//Notes this model generated using MEKA
		//adult age more or equal 51
		//senior age more equal 25 to equal 50
		//1 Romance

		if (feeling == Disgust && age >= 25 && age <= 50 && gender == 'Female') {
			predictedMovieTypes.add('Romance');
		}

		//2 DRAMA
		if (feeling == Angry && age > 25 &&
				!predictedMovieTypes.contains('Romace')) {
			predictedMovieTypes.add('Drama');
		}

		if (feeling == Disgust && age >= 25 && age <= 50 && gender == 'Female') {
				predictedMovieTypes.add('Drama');
		}

		if (feeling == Surpris && age > 50) {
				predictedMovieTypes.add('Drama');
		}
		

		//3 Action
		if (gender == 'Female' && age < 25
				&& (feeling == Happy || feeling == Angry || feeling == Scared)) {
				predictedMovieTypes.add('Action');
		}
		if (gender == 'Male' && age < 25 && feeling == Disgust &&
				!predictedMovieTypes.contains('Romance')) {
				predictedMovieTypes.add('Action');
		}



		//4 Comedy
		if (feeling == Happy && age > 50 &&
				!predictedMovieTypes.contains('Romance')) {
				predictedMovieTypes.add('Comedy');
		}
		if (feeling == Sad && age < 25 && predictedMovieTypes.contains('Romance')) {
				predictedMovieTypes.add('Comedy');
		}
		if (feeling == Scared && gender == 'Male' &&
				predictedMovieTypes.contains('Romance')) {
				predictedMovieTypes.add('Comedy');
		}
		if (feeling == Scared && age > 50 &&
				!predictedMovieTypes.contains('Romance')) {
				predictedMovieTypes.add('Comedy');
		}
		if (feeling == Scared && age < 25 && gender == 'Male' &&
				!predictedMovieTypes.contains('Romance')) {
				predictedMovieTypes.add('Comedy');
		}
		if (feeling == Surpris && predictedMovieTypes.contains('Romance')) {
				predictedMovieTypes.add('Comedy');
		}



		//5 Adventure
		if (gender == 'Male' && feeling == Happy && age > 50) {
			if (!predictedMovieTypes.contains('Adventure'))
				predictedMovieTypes.add('Adventure');
		}
		if (gender == 'Male' && feeling == Surpris && age > 50) {
			if (!predictedMovieTypes.contains('Adventure'))
				predictedMovieTypes.add('Adventure');
		}


		//6 Horror
		if (gender == 'Male' && feeling == Angry && age >= 25 && age <= 50) {
			if (!predictedMovieTypes.contains('Horror'))
				predictedMovieTypes.add('Horror');
		}


		//7 Cartoon
		if (age > 50 && feeling == Scared && gender == 'Female' &&
				!predictedMovieTypes.contains('Romance')) {
				predictedMovieTypes.add('Cartoon');
		}
		if (age > 50 && feeling == Disgust) {
				predictedMovieTypes.add('Cartoon');
		}
		if (age >= 25 && age <= 50 && feeling == Scared && gender == 'Male') {
				predictedMovieTypes.add('Cartoon');
		}
		if (age >= 25 && age <= 50 && feeling == Disgust && gender == 'Male') {
			if (!predictedMovieTypes.contains('Cartoon'))
				predictedMovieTypes.add('Cartoon');
		}

		//8 if list is empty
		if (predictedMovieTypes.isEmpty || predictedMovieTypes == ['']) {
			predictedMovieTypes.add('Comedy');
			predictedMovieTypes.add('Action');
		}
		print(predictedMovieTypes);

		postRecord(date,feeling,age,gender,predictedMovieTypes);

	}

	Future<void> postRecord(String date,String  feeling,int  age, String gender,List<String> predictedMovieTypes ) async{

		//userName='mm';
		//pass='123';
		SharedPreferences prefs=await SharedPreferences.getInstance();
		String userId=prefs.getString('userId').toString();

		var uri = postPredictionFormApi;

		// paramas :     ?USER_NAME=mm& CREATION_DATE  GENDER    FEELING  AGE  PREDICTED_TYPES
		uri =uri+'?USER_ID=$userId&CREATION_DATE=$date&GENDER=$gender&AGE=$age&FEELING=$feeling&PREDICTED_TYPES=$predictedMovieTypes';

		var response = await http.post(uri);
		print(uri);
		//print(map);
		var message=jsonDecode(response.body)['Message'];
		var formId=jsonDecode(response.body)['FormId'];
		var statusCode=response.statusCode;
		print(message);
		if(statusCode==200){
		print(userId);
		print(formId);
		prefs.setString('formId', formId);
		showLongToast(message);
		}
		else{
		showLongToast("Something wrong while posting Form Record$message");
		}

		//return formId;
	}
