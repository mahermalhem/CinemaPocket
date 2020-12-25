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


	Future<List<Movie>> getAllMovies() async {
		List<Movie> moviesList=[];
		SharedPreferences prefs = await SharedPreferences.getInstance();

		var uri = getAllMoviesApi;
		var response = await http.get(uri);

		print(uri);
		List items = jsonDecode(response.body)['items'];
		var message = response.statusCode;
		print(message);
		if (message == 200) {
			for (int i = 0; i < items.length; i++) {
				moviesList.add(Movie(
						movie_id: items[i]['movie_id'],
						movie_duration: items[i]['movie_duration'],
						movie_desc: items[i]['movie_desc'],
						movie_name: items[i]['movie_name'],
						movie_photo_url: items[i]['movie_photo_url'],
						movie_rank: items[i]['movie_rank'],
						movie_type: items[i]['movie_type'],
						timeline_id: items[i]['timeline_id']
				));
			}


			print(moviesList.elementAt(0).movie_duration);
			print(moviesList.length);
		}


		else {
			showLongToast("check you internet connection");
		}

		return moviesList;
	}


