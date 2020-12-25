import 'package:flutter/material.dart';
import 'package:project2/Constant/Values.dart';


class movieCard extends StatelessWidget {
	 	movieCard({
		this.movieName,
		this.movieRank,
		this.movieImgUrl,
		this.movieType
	});
	String movieName;
	String movieRank;
	String movieImgUrl;
	String movieType;
	@override

	Widget build(BuildContext context) {
		return Container(
			decoration: BoxDecoration(
				borderRadius: BorderRadius.circular(20),
				gradient: defaultlinearGradiantDecorantion,
			),
			child: Column(
				mainAxisAlignment: MainAxisAlignment.center,
				children: <Widget>[
					Expanded(
						flex: 4,
						child: Padding(
							padding: const EdgeInsets.all(6.0),
							child: Container(
								decoration: BoxDecoration(
									image: DecorationImage(
											fit: BoxFit.cover,
											image: NetworkImage(movieImgUrl),
									),
									borderRadius: BorderRadius.circular(30),
								),
							),
						),
					),
					Text(movieName,style: Theme.of(context).textTheme.body2),
					Text('$movieType'),
					Expanded(
						flex: 1,
						child: Row(
							mainAxisAlignment: MainAxisAlignment.center,
							children: <Widget>[
								Text(movieRank),
								Icon(Icons.star),
							],
						),
					)
				],
			),
		);
	}
}
