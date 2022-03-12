import 'package:flutter/material.dart';
import 'package:food_ordering_application/Authentication/login.dart';
import 'package:food_ordering_application/constant.dart';

class LoadingScreen extends StatefulWidget {
  static String id = "loading_screen";
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: kredbackgroundcolor,
        body: SafeArea(
          child: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
              Color(0xFFEf44949),
              Color(0xFFEf00e0e),
              Color(0xFFEEc00b0b),
            ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    flex: 2,
                    child: Container(
                      child: Image(
                        image: AssetImage('images/loadingLogo.png'),
                        height: 150.0,
                        width: 300.0,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(
                          top: 150, bottom: 30, right: 30, left: 30),
                      width: 250,
                      height: 10,
                      child: Card(
                        child: InkWell(
                          onTap: () {
                            Navigator.push<void>(
                              context,
                              MaterialPageRoute<void>(
                                builder: (BuildContext context) => Login(),
                              ),
                            );
                          },
                          child: Image(
                            alignment: Alignment.bottomCenter,
                            image: AssetImage('images/getStartedButton.png'),
                            height: 150.0,
                            width: 300.0,
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
      ),
    );
  }
}
