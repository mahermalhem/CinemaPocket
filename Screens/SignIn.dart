import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project2/Components/ToastLong.dart';
import 'package:project2/Constant/Values.dart';
import 'package:project2/Components/TextInput.dart';
import 'package:project2/Components/ShowFancyDialog.dart';
import 'package:project2/Network/SingInByEmailApi.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'SignUp.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  static const String id = 'SignInScreen';
  SharedPreferences prefs;
  void initState() {
    getShared();

    super.initState();
  }

  void getShared() async {
    prefs = await SharedPreferences.getInstance();
    prefs.remove('isLogged');
    prefs.remove('userId');
  }

  List formData = ["", ""];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: Container(
          decoration: BoxDecoration(
            gradient: defaultlinearGradiantDecorantion,
          ),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child:Image.asset('images/cinemapocket.jpeg'),
                    ),
                  ),
                  Text(
                    "MOVIE FOR MOOD ",
                    style: Theme.of(context).textTheme.title,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        TextInput(
                          enable: true,
                          icon: Icons.mail,
                          pass: false,
                          text: 'userName',
                          onChangefun: (val) {
                            formData[0] = val;
                          },
                        ),
                        TextInput(
                          enable: true,
                          icon: Icons.lock,
                          pass: true,
                          text: 'Password',
                          onChangefun: (val) {
                            formData[1] = val;
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 300,
                    height: 50,
                    child: RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(30.0)),
                        padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
                        color: textInputColor,
                        child: Text(
                          "SignIn",
                          style: Theme.of(context).textTheme.body1,
                        ),
                        onPressed: () {
                          String userName = formData[0];
                          String pass = formData[1];
                          getShared();
                          SingInByEmailApi(userName, pass);
                          String userId = prefs.get('userId');
                          if (userId != null && userId != "") {
                            print(userId);
                            Navigator.of(context).pushNamedAndRemoveUntil(
                                '/HomeScreen', (Route<dynamic> route) => false);
                          }
                        }),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  InkWell(
                    child: Text(
                      "Forget password",
                      style: Theme.of(context).textTheme.body1,
                    ),
                    onTap: () {
                      ShowFancyDialog(context, 'Soon',
                          "Sorry you can`t Register now", () {});
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      InkWell(
                          child: new Text(
                            'don`t have account ? sign up',
                            style: Theme.of(context).textTheme.body1,
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignUp()),
                            );
                          }),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

