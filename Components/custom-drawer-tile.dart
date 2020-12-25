
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:project2/Constant/Values.dart';

class CustomTile extends StatelessWidget {
  final String text ;
  final IconData icon;
  final Function onPress ;

  const CustomTile({
    this.text,this.icon,this.onPress,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Padding(
        padding: const EdgeInsets.all(13.0),
        child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
            children: <Widget>[
              Icon(icon,color:Colors.white,size: 30,),
              SizedBox(width: 15,),
              Text(text, style:Theme.of(context).textTheme.body2,),
            ],),
            Row(
              children: <Widget>[
                Icon(Icons.arrow_forward, color: Colors.white60,)
              ],),
          ],
        ),
      ),
      splashColor: textInputColor,
      onTap: onPress,

    );
  }
}
