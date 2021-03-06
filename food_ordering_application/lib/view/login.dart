import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_ordering_application/view/resetpassword.dart';
import 'package:food_ordering_application/view/signup.dart';
import 'package:food_ordering_application/view/home.dart';
import 'package:food_ordering_application/model/constant.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'basicdetails.dart';
import 'otp_setup.dart';

class Login extends StatefulWidget {
  static String id = 'loginScreen';

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _obscureText = true;
  String Useremail;
  String _password;
  final TextEditingController _userEmailController = TextEditingController();
  final TextEditingController _userPassworController = TextEditingController();

  // Toggles the password show status
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  bool status = true;

  Future<void> _signInWithEmailAndPassword() async {
    try {
      setState(() {
        status = false;
      });
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: _userEmailController.text,
              password: _userPassworController.text);

      Useremail = _userPassworController.text;

      print('Sign in Succefully {$Useremail}');
      //  Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
      Navigator.pushNamedAndRemoveUntil(context, Home.id, (route) => false);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        setState(() {
          status = true;
        });
        print('No user found for that email.');
        showAlertDialog('No user found for that email.', context);
      } else if (e.code == 'wrong-password') {
        setState(() {
          status = true;
        });
        print('Wrong password provided for that user.');
        showAlertDialog('Wrong password provided for that user.', context);
      }
    }
  }

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential

    await FirebaseAuth.instance.signInWithCredential(credential);
    Navigator.push<void>(
      context,
      MaterialPageRoute<void>(
        builder: (BuildContext context) => BasiInfo(),
      ),
    );
  }

  final _formKey = GlobalKey<FormState>();
  bool value = false;
  final maxLines = 5;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kbackgroundcolor,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              flex: 2,
              child: Container(
                margin: EdgeInsets.only(top: 25),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image(
                          color: Sushi,
                          image: AssetImage('images/newLogofoodx.png'),
                          height: 100.0,
                          width: 300.0,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 30),
                      child: Text(
                        'Welcome to FoodX!',
                        style: fstlyepoppinsTitle,
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      'Let\'s help you meet up your tasks.',
                      style: fstlyepoppinsSubtitle,
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    SizedBox(
                      height: 10.0,
                      width: MediaQuery.of(context).size.width - 25,
                      child: Divider(
                        thickness: 2,
                        color: klblack,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 10, right: 10, top: 10),
                        child: TextFormField(
                          controller: _userEmailController,
                          cursorColor: Colors.green,
                          decoration: InputDecoration(
                            errorStyle: TextStyle(
                              color: titleColor,
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            labelText: 'Email',
                            labelStyle: fstlyepromptTextFields,
                            suffixIcon: Icon(
                              Icons.email,
                              color: klblack,
                            ),
                            border: InputBorder.none,
                          ),
                          keyboardType: TextInputType.emailAddress,
                          autocorrect: false,
                          textCapitalization: TextCapitalization.none,
                          enableSuggestions: false,
                          validator: (value) {
                            if (value.isEmpty || !value.contains('@')) {
                              return 'Please enter a valid email address';
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(height: 20.0),
                      Container(
                        margin: EdgeInsets.only(left: 10, right: 10),
                        child: TextFormField(
                          controller: _userPassworController,
                          cursorColor: Colors.green,
                          decoration: InputDecoration(
                            errorStyle: TextStyle(
                              color: titleColor,
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            labelText: 'Password',
                            labelStyle: fstlyepromptTextFields,
                            suffixIcon: IconButton(
                              onPressed: _toggle,
                              icon: Icon(
                                Icons.remove_red_eye_rounded,
                                color: klblack,
                              ),
                            ),
                            border: InputBorder.none,
                          ),
                          validator: (value) {
                            if (value.isEmpty || value.length < 7) {
                              return 'Please enter a long password';
                            }
                            return null;
                          },
                          onSaved: (val) => _password = val,
                          obscureText: _obscureText,
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerRight,
                        margin: EdgeInsets.only(right: 30),
                        height: 40,
                        child: SizedBox(
                          child: TextButton(
                            onPressed: () {
                              Navigator.push<void>(
                                context,
                                MaterialPageRoute<void>(
                                  builder: (BuildContext context) =>
                                      ResetPassword(),
                                ),
                              );
                            },
                            child: Text(
                              'Forgot Password?',
                              style: fstlyemontserratAlternatesText,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(right: 50, left: 50, top: 30),
                        child: SizedBox(
                          width: 200,
                          height: 50,
                          child: TextButton(
                            style: TextButton.styleFrom(
                              primary: Colors.white,
                              backgroundColor: Sushi,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(3),
                              ),
                            ),
                            onPressed: () async {
                              if (_formKey.currentState.validate()) {
                                _signInWithEmailAndPassword();
                              } else {
                                return null;
                              }

                              //
                            },
                            child: status == true
                                ? Text(
                                    "Login",
                                    style: buttonText,
                                  )
                                : CircularProgressIndicator(
                                    backgroundColor: Colors.black38,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        titleColor),
                                  ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                child: Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      margin: EdgeInsets.only(right: 50, left: 50),
                      child: TextButton(
                        child: Image(
                          image: AssetImage('images/googleIcon.png'),
                          width: 300,
                          height: 50,
                        ),
                        onPressed: () {
                          signInWithGoogle();
                        },
                      ),
                    ),
                    // Container(
                    //   margin: EdgeInsets.only(right: 50, left: 50),
                    //   child: TextButton(
                    //     child: Image(
                    //       image: AssetImage('images/facebookIcon.png'),
                    //       width: 300,
                    //       height: 50,
                    //     ),
                    //     onPressed: () {},
                    //   ),
                    // ),
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 100),
                        child: Row(
                          children: [
                            Text(
                              'Dont Have an account?',
                              style: fstlyemontserratAlternatesText,
                            ),
                            SizedBox(
                              child: TextButton(
                                style: TextButton.styleFrom(
                                  primary: titleColor,
                                  textStyle: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.push<void>(
                                    context,
                                    MaterialPageRoute<void>(
                                      builder: (BuildContext context) =>
                                          OtpSetup(),
                                    ),
                                  );
                                },
                                child: Text(
                                  "Sign Up",
                                  style: normalText,
                                ),
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
          ],
        ),
      ),
    );
  }
}

showAlertDialog(String message, BuildContext context) {
  // set up the button
  Widget okButton = FlatButton(
    child: Text("OK"),
    onPressed: () {
      Navigator.pop(context);
    },
  );
  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Alert Box"),
    content: Text(message),
    actions: [
      okButton,
    ],
  );
  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
