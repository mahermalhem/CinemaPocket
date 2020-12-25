import 'package:async/async.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:project2/MiningModels/FormBuildModel.dart';
import 'package:project2/Network/getAllMovies.dart';
import 'package:project2/Network/getTypedMovie.dart';
import 'package:quiver/core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:project2/Components/TextInput.dart';
import 'package:project2/Components/movieCard.dart';
import 'package:project2/Components/read_more_text.dart';
import 'package:project2/Constant/API.dart';
import 'package:project2/Constant/Values.dart';
import 'package:project2/Components/MainDrawer.dart';
import 'package:project2/Datatype/comment.dart';
import 'package:project2/Datatype/movie.dart';
import 'package:project2/Network/getMovieComments.dart';
import 'package:project2/Network/getMovieDetail.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/rendering.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'MovieDetails.dart';


class FormResultScreen extends StatefulWidget {
  @override
  _FormResultScreenState createState() => _FormResultScreenState();
}

class _FormResultScreenState extends State<FormResultScreen> {
  static const String id = 'FormResultScreen';

  String formId;
  String userId;
  SharedPreferences prefs;
  List<String> predictedTypes;

  @override
  void initState() {
    getShared();
    predictedTypes = predictedMovieTypes;
    super.initState();
  }

  void getShared() async {
    prefs = await SharedPreferences.getInstance();
    print("form result screen");
    userId = prefs.getString('userId').toString();
    formId = prefs.getString('formId').toString();
    print(predictedTypes);
    print('from details movie uesrid $userId and som $formId');
    print(prefs.getString('formId'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MainDrawer(),
      appBar: AppBar(
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              children: <Widget>[
                Text(
                  "Cienma Pocket",
                  style: Theme.of(context).textTheme.title,
                ),
              ],
            )
          ],
        ),
        backgroundColor: textInputColor,
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: Container(
          decoration: BoxDecoration(
            gradient: defaultlinearGradiantDecorantion,
          ),
          child: PageView(
            children: getWidgets(),
          ),
        ),
      ),
    );
  }

  FutureBuilder<List<Movie>> MoviesFutureBuilder(String movieType,int pageNumber) {
    //ScrollController _scrollController = new ScrollController();
    return FutureBuilder(
      future: getTypedMovie(movieType),
      builder: (BuildContext context, snapshot) {
        if (snapshot.hasData)
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return Center(child: CircularProgressIndicator());
            case ConnectionState.active:
              return Center(child: CircularProgressIndicator());
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator());
            case ConnectionState.done:
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
										mainAxisAlignment: MainAxisAlignment.center,
										children: <Widget>[
											Expanded(
												flex: 1,
												child: Text(movieType,style: Theme.of(context).textTheme.title,),
											),
											Expanded(
												flex: 6,
												child: GridView.builder(
													itemCount: snapshot.data.length,
													gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
															crossAxisCount: 2,
															crossAxisSpacing: 4.0,
															mainAxisSpacing: 25.0),
													itemBuilder: (BuildContext context, int index) {
														return InkWell(
															splashColor: Colors.blueGrey,
															onTap: () {
																prefs.setString(
																		'movieId', snapshot.data[index].movie_id);
																Navigator.push(
																	context,
																	MaterialPageRoute(
																			builder: (context) => MovieDetails()),
																);
															},
															child: movieCard (
																movieImgUrl:snapshot.data[index].movie_photo_url,
																movieName: snapshot.data[index].movie_name,
																movieRank: snapshot.data[index].movie_rank,
																movieType: snapshot.data[index].movie_type,
															),
														);
													},
												),
											),
											Expanded(
												flex: 1,

												child: Row(
													mainAxisAlignment: MainAxisAlignment.center,
													children: <Widget>[
														Text('$pageNumber',style: Theme.of(context).textTheme.title,),
														SizedBox(width: 20,),
														Icon(Icons.arrow_forward_ios,size: 25,),
													],
												)
											),

										],
									),
                ),
              );
            default:
              return Text("Sorry No data Retrived");
          }
        else if (snapshot.hasError) {
          return Text("please check your internet connection");
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }


  List<FutureBuilder> getWidgets() {
    List<FutureBuilder> viewPagerviews = [];
    for (int i = 0; i < predictedTypes.length; i++) {
      viewPagerviews.add(MoviesFutureBuilder(predictedTypes[i],i+1));
    }
    return viewPagerviews;
  }



}
