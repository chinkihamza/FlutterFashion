import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

import 'package:flutter_fashion/Constants/text_styles.dart';
import 'package:flutter_fashion/Views/home_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  firebase_auth.FirebaseAuth firebaseAuth = firebase_auth.FirebaseAuth.instance;
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool isLoading = false;
  Future<void> _alertDialogBuilder(String error) async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            title: Text(
              "Error",
              style: Constants.regularDarkText,
            ),
            content: Text(
              error,
              style: Constants.regularText,
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    "Close",
                    style: Constants.regularDarkText,
                  ))
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          alignment: Alignment.center,
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 24),
                child: Text("Create A New Account",
                    textAlign: TextAlign.center, style: Constants.boldHeading),
              ),
              Column(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 8, horizontal: 24),
                    height: 50,
                    decoration: BoxDecoration(
                        color: Color(0xFFF2F2F2),
                        borderRadius: BorderRadius.circular(12)),
                    child: TextField(
                      controller: _emailController,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Email...",
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 24, vertical: 18)),
                      style: Constants.regularDarkText,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 8, horizontal: 24),
                    height: 50,
                    decoration: BoxDecoration(
                        color: Color(0xFFF2F2F2),
                        borderRadius: BorderRadius.circular(12)),
                    child: TextField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Password...",
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 24, vertical: 18)),
                      style: Constants.regularDarkText,
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      setState(() {
                        isLoading = true;
                      });
                      try {
                        firebase_auth.UserCredential userCredential =
                            await firebaseAuth.createUserWithEmailAndPassword(
                                email: _emailController.text,
                                password: _passwordController.text);
                        setState(() {
                          isLoading = false;
                        });
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (builder) => HomePage()),
                            (route) => false);
                      } catch (e) {
                        _alertDialogBuilder(e.toString());
                        _emailController.clear();
                        _passwordController.clear();
                        setState(() {
                          isLoading = false;
                        });
                      }
                    },
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                          color: Colors.black,
                          border: Border.all(color: Colors.black, width: 2.0),
                          borderRadius: BorderRadius.circular(12)),
                      margin: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                      child: Center(
                          child: isLoading
                              ? SizedBox(
                                  height: 27,
                                  width: 27,
                                  child: CircularProgressIndicator(),
                                )
                              : Text(
                                  "Create Account",
                                  style: TextStyle(
                                    fontFamily: "FiraSansCondensed",
                                    fontSize: 18.0,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                  ),
                                )),
                    ),
                  )
                ],
              ),
              Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      height: 50,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Colors.transparent,
                          border: Border.all(color: Colors.black, width: 2.0),
                          borderRadius: BorderRadius.circular(12)),
                      margin: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                      child: Text(
                        "Back to Login",
                        style: TextStyle(
                          fontFamily: "FiraSansCondensed",
                          fontSize: 18.0,
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
