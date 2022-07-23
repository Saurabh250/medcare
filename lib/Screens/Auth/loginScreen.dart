// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, sort_child_properties_last, unused_import, must_be_immutable, avoid_print

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:medcare/home.dart';
import '../../routes.dart';
import '../../Services/http_request.dart';
import '../../Utils/size_config.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen();
  final TextEditingController _username = TextEditingController();
  final TextEditingController _password = TextEditingController();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/signin.png"),
                fit: BoxFit.fill,
              ),
            ),
            child: Column(
              children: [
                Padding(padding: EdgeInsets.fromLTRB(20, 340, 20, 0)),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 16.0, horizontal: 60.0),
                  child: Column(
                    children: [
                      TextField(
                        controller: _username,
                        autofocus: true,
                        enabled: true,
                        keyboardType: TextInputType.emailAddress,
                        cursorRadius: Radius.circular(30),
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            labelText: "Enter your username"),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      TextField(
                        obscureText: true,
                        controller: _password,
                        cursorRadius: Radius.circular(30.0),
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            labelText: "Enter your password"),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          if (_username.text.isEmpty) {
                            showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                      content: Text("Enter Username"),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: Text("Ok"),
                                        ),
                                      ],
                                    ));
                          } else if (_password.text.isEmpty) {
                            showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                      content: Text("Enter Password "),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: Text("Ok"),
                                        ),
                                      ],
                                    ));
                          } else {
                            print(_username.text);
                            print(_password.text);
                            loginUser(_username.text, _password.text);

                            Timer(Duration(seconds: 1), () {
                              print(mess());
                              if (mess() == 200) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Home(),
                                  ),
                                );
                              } else {
                                showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                          content: Text("Wrong Credentials"),
                                          actions: <Widget>[
                                            TextButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: Text("Ok"),
                                            ),
                                          ],
                                        ));
                              }
                            });
                          }
                        },
                        child: Text("Log In"),
                        style: ElevatedButton.styleFrom(
                          textStyle: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                          primary: Color.fromRGBO(0, 150, 199, 100),
                          side: BorderSide(width: 1, color: Colors.black),
                          elevation: 1,
                          fixedSize: const Size(300, 50),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 50, vertical: 10),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )));
  }
}
