import 'dart:async';
import 'dart:convert';
import 'dart:wasm';
import 'package:http/http.dart' as http;
import 'package:project2/Components/ToastLong.dart';
import 'package:project2/Constant/API.dart';
import 'package:project2/Datatype/movie.dart';
import 'package:project2/Screens/SignIn.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:project2/RouteGenerator.dart';
import 'package:project2/Datatype/comment.dart';

Comment comment ;


Future<List<Comment>> getMovieComments() async {
	List<Comment> commentsList = [];
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String movieId = prefs.getString('movieId');
  var uri = getMovieCommentsById;
  uri=uri+movieId;
  print(uri);
  var response = await http.get(uri);
  List items = jsonDecode(response.body)['items'];
  var message = response.statusCode;
  print('comment api status $message');
  if (message == 200) {
    for (int i = 0; i < items.length; i++) {
      commentsList.add(Comment(
          comment_id: items[i]['comment_id'],
          email: items[i]['email'],
          user_name: items[i]['user_name'],
          name: items[i]['name'],
          comment_desc: items[i]['comment_desc'],
          comment_date: items[i]['comment_date'],
          city: items[i]['city'],
          birth_date: items[i]['birth_date'],
          address: items[i]['address'],
          gender: items[i]['gender'],
          user_id: items[i]['user_id'],
          movie_id: items[i]['movie_id']));
    }
  } else {
    showLongToast("check you internet connection");
  }
  return commentsList;
}
