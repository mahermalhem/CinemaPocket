import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:project2/Components/ToastLong.dart';
import 'package:project2/Constant/API.dart';
import 'package:project2/Datatype/movie.dart';
import 'package:project2/Screens/SignIn.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:project2/RouteGenerator.dart';

	Movie movie=Movie(movie_id: 'dasd',
		timeline_id:'fsafa',
		movie_type:'gfaf' ,
		movie_rank: 'dasdsa',
		movie_photo_url:'dsada',
		movie_name: 'dasd',
		movie_desc:'dasda' ,
		movie_duration: 'dasd',);

	Future<Movie> getMovieDetail() async {
		SharedPreferences prefs = await SharedPreferences.getInstance();
		String movieId=prefs.getString('movieId');
		var uri = getMovieDetailById;
		uri=uri+movieId;

		var response = await http.get(uri);
		print(uri);
		List items = jsonDecode(response.body)['items'];
		var message = response.statusCode;
		print(message);
		if (message == 200) {
			movie=Movie(
				movie_id: items[0]['movie_id'],
				timeline_id:items[0]['timeline_id'],
				movie_type:items[0]['movie_type'] ,
				movie_rank: items[0]['movie_rank'],
				movie_photo_url: items[0]['movie_photo_url'],
				movie_name: items[0]['movie_name'],
				movie_desc:items[0]['movie_desc'] ,
				movie_duration: items[0]['movie_duration'],
				movie_trailer: items[0]['movie_trailer'],
			);
		}
		else {
			showLongToast("check you internet connection");
		}
		return movie;
	}

