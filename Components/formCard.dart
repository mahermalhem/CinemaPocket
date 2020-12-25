import 'package:flutter/material.dart';
import 'package:project2/Constant/Values.dart';


class formCard extends StatelessWidget {
	formCard({
		this.predicted_types,
		this.creation_date,
		this.gender,
		this.age,
		this.feeling
	});
	String age ;
	String feeling ;
	String creation_date ;
	String gender ;
	String predicted_types ;
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
						flex: 1,
						child: Padding(
							padding: const EdgeInsets.all(6.0),
							child: Icon(Icons.library_books,
							size: 50,),
						),
					),
					Expanded(
						flex: 2,
						child: Column(
							children: <Widget>[
								Text('$predicted_types',style: Theme.of(context).textTheme.body2),
								Text('$gender',style: Theme.of(context).textTheme.body2),
								Text('$age',style: Theme.of(context).textTheme.body2),
								Text('$feeling',style: Theme.of(context).textTheme.body2),
								Text(creation_date.substring(1,16),style: Theme.of(context).textTheme.body2),
							],
						)
					),

				],
			),
		);
	}
}
