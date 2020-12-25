import 'package:async/async.dart';
import 'package:flutter/cupertino.dart';
import 'package:project2/Components/RatingDialog.dart';
import 'package:project2/Components/ToastLong.dart';
import 'package:project2/Network/postComment.dart';
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

class MovieDetails extends StatefulWidget {
  @override
  _MovieDetailsState createState() => _MovieDetailsState();
}

class _MovieDetailsState extends State<MovieDetails> {
	static const String id = 'HomeScreen';

	String movieId;
	String userId;
	SharedPreferences prefs;
	String valueOfComment;

	@override
	void initState() {
		getShared();
		super.initState();
	}



	void getShared() async {
		prefs = await SharedPreferences.getInstance();
		print("user id from Movie details screen");
		userId = prefs.getString('userId');
		movieId = prefs.getString('movieId');
		print('from details movie uesrid $userId and  $movieId');
	}


	final _closeMemo = new AsyncMemoizer();
	Future close() => _closeMemo.runOnce(() {
		return getMovieComments();
	});


	@override
	Widget build(BuildContext context) {
		return Scaffold(
			/*floatingActionButton: FabCircularMenu(
          alignment: Alignment(-1, 1),
          fabMargin: EdgeInsets.all(16),
          fabColor: floatingColor,
          fabSize: 100,
          ringWidth: 60,
          fabElevation: 23,
          fabCloseColor: Colors.grey,
          fabOpenColor: floatingColor,
          fabOpenIcon: Icon(
            Icons.live_help,
            size: 35,
          ),
          ringDiameter: 250.0,
          ringColor: floatingColor,
          children: <Widget>[
            IconButton(
                icon: Icon(Icons.camera_front),
                iconSize: 30,
                onPressed: () {
                  print('Favorite');
                }),
            IconButton(
                icon: Icon(Icons.edit),
                iconSize: 40,
                onPressed: () {
                  print("hi");
                }),
            IconButton(
                icon: Icon(Icons.camera_alt),
                iconSize: 40,
                onPressed: () {
                  print("hi");
                }),
          ]),*/
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
									style: Theme
											.of(context)
											.textTheme
											.title,
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
					child: Padding(
						padding: const EdgeInsets.all(12.0),
						child: Column(
							children: <Widget>[
								Expanded(flex: 5, child: movieDetailsFuture()),
								Expanded(
									flex: 3,
									child:commentsFuture(),
								),
								Expanded(
									child: Directionality(
										textDirection: TextDirection.rtl,
										child: TextField(
											enabled: true,
											onChanged: (controllerText) {
												valueOfComment = "";
												valueOfComment += controllerText;
											},
											controller: TextEditingController(),
											obscureText: false,
											textAlign: TextAlign.left,
											decoration: InputDecoration(
												border: OutlineInputBorder(
													borderRadius: BorderRadius.circular(10),
												),
												labelText: "Writer a comment",
												labelStyle: Theme
														.of(context)
														.textTheme
														.body1,
												prefixIcon: Icon(
													Icons.comment,
													color: Colors.grey[500],
												),
												suffixIcon: InkWell(
													onTap: () async{
														setState(() {
															this.reassemble();
															print(prefs.getString('movieId'));
															print(prefs.getString('userId'));
															if(valueOfComment != null && valueOfComment != ""){
																postComment(valueOfComment);
															}
															else
																showLongToast('Comment cannot be empty');
														});
													},
													child: Icon(
														Icons.input,
														color: Colors.grey[500],
													),
												),
											),
										),
									),
								),
							],
						),
					),
				),
			),
		);
	}


	 movieDetailsFuture()  {
		//ScrollController _scrollController = new ScrollController();

		return FutureBuilder(
			future:  getMovieDetail(),
			builder: (BuildContext context, snapshot) {
				if (snapshot.hasData)
					switch (snapshot.connectionState) {
						case ConnectionState.none:
							return CircularProgressIndicator();
						case ConnectionState.active:
							return CircularProgressIndicator();
						case ConnectionState.waiting:
							return CircularProgressIndicator();
						case ConnectionState.done:
							return  Column(
								mainAxisAlignment: MainAxisAlignment.center,
								children: <Widget>[
									Expanded(
										flex: 3,
										child: YoutubePlayer(
											controller: YoutubePlayerController(
													initialVideoId: YoutubePlayer.convertUrlToId(snapshot.data.movie_trailer)),
										),
									),
									Expanded(
										flex: 1,
										child: Row(
											mainAxisAlignment: MainAxisAlignment.spaceBetween,
											children: <Widget>[
												Expanded(
													flex: 2,
													child: Padding(
														padding: const EdgeInsets.all(8.0),
														child: Text(
															snapshot.data.movie_name,
															style: Theme
																	.of(context)
																	.textTheme
																	.body2,
														),
													),
												),
												Expanded(
													flex: 1,
													child: InkWell(
														onTap: (){
															showDialog(
																	context: context,
																	builder: (_) => RatingDialog()
															);
														},
														child: Row(
													  	mainAxisAlignment: MainAxisAlignment.end,
													  	children: <Widget>[
													  		Text(snapshot.data.movie_rank,
													  				style: Theme
													  						.of(context)
													  						.textTheme
													  						.title),
													  		Icon(
													  			Icons.star,
													  			color: Colors.orange,
													  			size: 22,
													  		),
													  	],
													  ),
													),
												),
											],
										),
									),
									Expanded(
										flex: 1,
										child: SingleChildScrollView(
											child: ReadMoreText(snapshot.data.movie_desc,
													trimLines: 2,
													colorClickableText: Colors.pink,
													trimMode: TrimMode.Line,
													trimCollapsedText: '...ReadMore',
													trimExpandedText: ' Show Less',
													style: Theme
															.of(context)
															.textTheme
															.body2),
										),
									),
								],
							);
						default:
							return Text("Sorry No data Retrived");
					}
				else if (snapshot.hasError) {
					return Text("اذهب الى المفضلة و قم باختيار نوع الاسئلة");
				}
				return CircularProgressIndicator();
			},
		);
	}


	 commentsFuture() {
		//ScrollController _scrollController = new ScrollController();
		return FutureBuilder(
			future: getMovieComments(),
			builder: (BuildContext context, snapshot) {
				if (snapshot.hasData)
					switch (snapshot.connectionState) {
						case ConnectionState.none:
							return CircularProgressIndicator();
						case ConnectionState.active:
							return CircularProgressIndicator();
						case ConnectionState.waiting:
							return CircularProgressIndicator();
						case ConnectionState.done:
							return ListView.builder(
									itemCount: snapshot.data.length,
									itemBuilder: (context,index){
										return Column(
											children: <Widget>[
												InkWell(
													onTap: () {
														print(index);
													},
													child: Column(
														children: <Widget>[
															Row(
																//footer row
																mainAxisAlignment:
																MainAxisAlignment.spaceBetween,
																children: <Widget>[
																	Row(
																		children: <Widget>[
																			//right footer row
																			Padding(
																				padding: const EdgeInsets.all(8.0),
																				child: Text(
																					snapshot.data[index].comment_date != null ? snapshot.data[index].comment_date  : "5/10/2019",
																					style: Theme
																							.of(context)
																							.textTheme
																							.body1,
																				),
																			),
																			Icon(Icons.watch_later),
																		],
																	),
																	Row(
																		children: <Widget>[
																			//left footer row
																			Padding(
																				padding: const EdgeInsets.all(8.0),
																				child: Text(
																					snapshot.data[index].user_name ,
																					style: Theme
																							.of(context)
																							.textTheme
																							.body2,
																				),
																			),
																			SizedBox(
																				width: 30,
																				height: 30,
																				child: CircleAvatar(
																					radius: 100,
																					backgroundImage:
																					AssetImage('images/cinemapocket.jpeg'),
																				),
																			)
																		],
																	),
																],
															),
															Container(
																margin: EdgeInsets.all(8.0),
																alignment: Alignment(1, 0),
																child: LimitedBox(
																		maxHeight: 50,
																		maxWidth: 50,
																		child: Text(
																				snapshot.data[index].comment_desc
																		),
																		),
															),
															Row(
																mainAxisAlignment:
																MainAxisAlignment.spaceBetween,
																children: <Widget>[
																	//header row
																	Row(
																		children: <Widget>[
																			//right header row
																			Padding(
																				padding: const EdgeInsets.all(8.0),
																				child: InkWell(
																						onTap: () {
																							print(index);
																						},
																						child: Text(
																							"Replay",
																							style: Theme
																									.of(context)
																									.textTheme
																									.body1,
																						)),
																			),
																			Icon(Icons.comment),
																		],
																	),
																],
															),
														],
													),
												),
											],
										);
									});
								/*SingleChildScrollView(
										child:
									),*/
						default:
							return Text("Sorry No data Retrived");
					}
				else if (snapshot.hasError) {
					return Text("No comments yet");
				}
				return CircularProgressIndicator();
			},
		);
	}




}