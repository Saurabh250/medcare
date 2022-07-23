// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:medcare/Services/http_request.dart';
import 'package:medcare/beds.dart';
import 'package:medcare/specialist.dart';
import 'package:medcare/reminder.dart';
import 'package:medcare/speciallist_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    specialist();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 30, right: 8),
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/home.png"),
                fit: BoxFit.fill,
              ),
            ),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 80, right: 220),
                  child: Text(
                    "MedCare",
                    style: TextStyle(
                        color: Colors.indigo[900],
                        fontWeight: FontWeight.bold,
                        fontSize: 30),
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 12, right: 200),
                  child: Text(
                    "Changing the way you receive healthcare with medical excellence",
                    style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                        fontSize: 15),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 50),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Padding(padding: EdgeInsets.only(right: 10)),
                          InkWell(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => Specialist()));
                            },
                            child: Card(
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(15)),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.black,
                                          blurRadius: 1,
                                          spreadRadius: 1,
                                          offset: Offset(0, 1)),
                                    ]),
                                height: 150,
                                width: 150,
                                child: Column(children: [
                                  Padding(padding: EdgeInsets.only(top: 30)),
                                  FaIcon(
                                    FontAwesomeIcons.userDoctor,
                                    color: Colors.blue,
                                    size: 50,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    "Choose a Doctor",
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.blue,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ]),
                              ),
                            ),
                          ),
                          Padding(padding: EdgeInsets.only(right: 30)),
                          InkWell(
                            onTap: (() {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => reminder()));
                            }),
                            child: Card(
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: const BorderRadius.all(
                                        const Radius.circular(15)),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.black,
                                          blurRadius: 1,
                                          spreadRadius: 1,
                                          offset: Offset(0, 1)),
                                    ]),
                                height: 150,
                                width: 160,
                                child: Column(children: [
                                  Padding(padding: EdgeInsets.only(top: 30)),
                                  FaIcon(
                                    FontAwesomeIcons.clock,
                                    color: Colors.blue,
                                    size: 50,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    "Set Reminder",
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.blue,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ]),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(padding: EdgeInsets.only(top: 50)),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(padding: EdgeInsets.only(right: 20)),
                          InkWell(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => beds(),
                                ),
                              );
                            },
                            child: Card(
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: const BorderRadius.all(
                                        const Radius.circular(15)),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.black,
                                          blurRadius: 1,
                                          spreadRadius: 1,
                                          offset: Offset(0, 1)),
                                    ]),
                                height: 150,
                                width: 160,
                                child: Column(children: [
                                  Padding(padding: EdgeInsets.only(top: 30)),
                                  FaIcon(
                                    FontAwesomeIcons.mapLocation,
                                    color: Colors.blue,
                                    size: 50,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    "Find Nearby Clinic",
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.blue,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ]),
                              ),
                            ),
                          ),
                          Padding(padding: EdgeInsets.only(right: 30)),
                          InkWell(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => beds()));
                            },
                            child: Card(
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: const BorderRadius.all(
                                        const Radius.circular(15)),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.black,
                                          blurRadius: 1,
                                          spreadRadius: 1,
                                          offset: Offset(0, 1)),
                                    ]),
                                height: 150,
                                width: 160,
                                child: Column(children: [
                                  Padding(padding: EdgeInsets.only(top: 30)),
                                  FaIcon(
                                    FontAwesomeIcons.bedPulse,
                                    color: Colors.blue,
                                    size: 50,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10, right: 10),
                                    child: Text(
                                      "Check Available Beds",
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.blue,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ]),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
