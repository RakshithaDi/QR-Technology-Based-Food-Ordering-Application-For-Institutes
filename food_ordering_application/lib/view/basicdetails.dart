import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../model/constant.dart';
import '../model/registeruser.dart';
import 'home.dart';

class BasiInfo extends StatefulWidget {
  const BasiInfo({Key key}) : super(key: key);

  @override
  _BasiInfoState createState() => _BasiInfoState();
}

class _BasiInfoState extends State<BasiInfo> {
  final _formKey = GlobalKey<FormState>();
  // final TextEditingController _fnameController = TextEditingController();
  // final TextEditingController _lnameController = TextEditingController();
  final TextEditingController _userMobileController = TextEditingController();
  String userEmail;
  bool states = true;
  String firstName;
  String lastName;

  @override
  void initState() {
    super.initState();

    FirebaseAuth auth = FirebaseAuth.instance;

    if (auth.currentUser != null) {
      userEmail = auth.currentUser.email;
      print(auth.currentUser.email);
      print(auth.currentUser.displayName);
      String fullname = auth.currentUser.displayName;
      var names = fullname.split(' ');
      firstName = names[0];
      lastName = names[1];
      print(firstName);
      print(lastName);
      print(userEmail);
    }
  }

  void AddUser() async {
    try {
      RegisterUser adduser = RegisterUser(
          firstName, lastName, userEmail, _userMobileController.text);
      adduser.addUser();
      Navigator.pushNamedAndRemoveUntil(context, Home.id, (route) => false);
    } catch (e) {
      print(e);
      states = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kbackgroundcolor,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        title: Text('Sign In'),
        backgroundColor: Sushi,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 30),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Container(
                      child: Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                child: TextFormField(
                                  controller: _userMobileController,
                                  decoration: InputDecoration(
                                    errorStyle: TextStyle(
                                      color: titleColor,
                                    ),
                                    border: InputBorder.none,
                                    fillColor: Colors.white,
                                    filled: true,
                                    labelText: 'Mobile No',
                                    labelStyle: fstlyepromptTextFields,
                                  ),
                                  enableSuggestions: false,
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'Please enter a valid mobile no';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: 250,
                      height: 45,
                      child: TextButton(
                        style: TextButton.styleFrom(
                          primary: Colors.white,
                          backgroundColor: Sushi,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                            setState(() {
                              states = false;
                              AddUser();
                            });
                          } else {
                            return null;
                          }
                          //  Navigator.pushNamed(context, OtpSetup.id);
                        },
                        child: states == true
                            ? Text(
                                'Sign In',
                                style: buttonText,
                              )
                            : CircularProgressIndicator(
                                backgroundColor: Colors.black38,
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(titleColor)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
