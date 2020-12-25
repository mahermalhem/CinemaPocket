import 'package:flutter/material.dart';
import 'package:project2/Constant/Values.dart';

class TextInput extends StatelessWidget {

	final IconData icon;
	final String text;
	final bool pass;
	final bool enable;
	final Function onChangefun;


	const TextInput({
		this.icon,
		this.text,
		this.pass,
		this.enable,
		this.onChangefun
	});
	@override
	Widget build(BuildContext context) {
		return Padding(
			padding: const EdgeInsets.all(10.0),
			child: TextFormField(
				decoration: new InputDecoration(
					prefixIcon: Icon(
						icon,
						color: Colors.black54,
					),
					labelText:text ,
					fillColor: Colors.white,
					border: new OutlineInputBorder(
						borderRadius: new BorderRadius.circular(25.0),
						borderSide: new BorderSide(
						),
					),
					//fillColor: Colors.green
				),
				onChanged: onChangefun,
				obscureText: pass,
				keyboardType: TextInputType.emailAddress,
				style:Theme.of(context).textTheme.body1,
			),
		);
	}
}
