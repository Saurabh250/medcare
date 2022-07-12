// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, sort_child_properties_last, unused_import, must_be_immutable, avoid_print

import 'package:flutter/material.dart';
import 'package:medcare/home.dart';
import 'package:medcare/routes.dart';
import 'package:medcare/Services/http_request.dart';

class Login extends StatelessWidget {
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
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
                      TextFormField(
                        controller: username,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            labelText: "Enter your username"),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        obscureText: true,
                        controller: password,
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
                          if (username.text.isEmpty) {
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
                          } else if (password.text.isEmpty) {
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
                            print(username.text);
                            loginUser("admin", "Developer@2022");
                            //Navigator.pushNamed(context, MyRoutes.homeRoute);
                          }
                        },
                        child: Text("Log In"),
                        style: ElevatedButton.styleFrom(
                          textStyle: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                          primary: Color.fromARGB(156, 15, 171, 243),
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
