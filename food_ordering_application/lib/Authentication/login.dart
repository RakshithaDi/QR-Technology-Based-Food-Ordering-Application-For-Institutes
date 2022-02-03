import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Login extends StatefulWidget {
  //const login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey[200],
        body: SafeArea(
          child: ListView(
            children: <Widget>[
              Center(
                child: Container(
                  margin: EdgeInsets.only(
                    top: 20,
                    bottom: 20,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image(
                      image: AssetImage('images/foodx.png'),
                      height: 100.0,
                      width: 200.0,
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 10),
                child: Column(
                  children: <Widget>[
                    Text(
                      'Welcome to FoodX!',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      'Lets help you meet up your tasks.',
                      style: TextStyle(
                          fontSize: 15,
                          color: Colors.grey[500],
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 30.0,
                      width: 350,
                      child: Divider(
                        thickness: 2,
                        color: Colors.grey[400],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Container(
                        height: 45,
                        child: TextField(
                          obscureText: false,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            prefixIcon: Icon(Icons.email),
                            labelText: 'Email',
                            labelStyle: TextStyle(
                              fontSize: 13,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Container(
                        height: 45,
                        child: TextField(
                          style: TextStyle(height: 1),
                          obscureText: true,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            prefixIcon: Icon(Icons.remove_red_eye),
                            labelText: 'Password',
                            labelStyle: TextStyle(
                              fontSize: 13,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                alignment: Alignment.centerRight,
                margin: EdgeInsets.only(right: 30),
                height: 40,
                child: SizedBox(
                  child: TextButton(
                    onPressed: () {},
                    child: Text(
                      'Forgot Password?',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(right: 50, left: 50),
                child: SizedBox(
                  width: 250,
                  height: 50,
                  child: TextButton(
                    style: TextButton.styleFrom(
                      primary: Colors.white,
                      backgroundColor: Color(0XFFD8352C),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          side: BorderSide(color: Colors.red)),
                    ),
                    onPressed: () {},
                    child: Text('Sign In'),
                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Container(
                margin: EdgeInsets.only(right: 30, left: 30),
                child: Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: SizedBox(
                    height: 50,
                    child: TextButton.icon(
                      style: TextButton.styleFrom(
                          //primary: Colors.white,
                          // backgroundColor: Color(0XFFD8352C),

                          side: BorderSide(color: Colors.grey[600], width: 1)),
                      onPressed: () {},
                      icon: FaIcon(FontAwesomeIcons.google),
                      label: Text(
                        'Sign In With Google',
                        style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Container(
                margin: EdgeInsets.only(right: 30, left: 30),
                child: Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: SizedBox(
                    height: 50,
                    child: TextButton.icon(
                      style: TextButton.styleFrom(
                          //primary: Colors.white,
                          // backgroundColor: Color(0XFFD8352C),

                          side: BorderSide(color: Colors.grey[600], width: 1)),
                      onPressed: () {},
                      icon: FaIcon(FontAwesomeIcons.facebook),
                      label: Text(
                        'Sign In With Facebook',
                        style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                child: Padding(
                  padding: const EdgeInsets.only(left: 100),
                  child: Row(
                    children: [
                      Text('Dont Have an account?'),
                      SizedBox(
                        child: TextButton(
                          style: TextButton.styleFrom(
                            primary: Colors.black,
                            //backgroundColor: Color(0XFFD8352C),
                            textStyle: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          onPressed: () {},
                          child: Text('Sign Up'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
