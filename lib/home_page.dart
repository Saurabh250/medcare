// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:medcare/beds.dart';
import 'package:medcare/doctor.dart';
import 'package:medcare/reminder.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 90, left: 80, right: 80),
            child: Text(
              "MedCare",
              style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                  fontSize: 30),
              textAlign: TextAlign.center,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10, left: 30, right: 30),
            child: Text(
              "Changing the way you receive healthcare with medical excellence",
              style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
          ),
          Padding(padding: EdgeInsets.only(top: 10, bottom: 50)),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  Padding(padding: EdgeInsets.only(right: 20)),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => doctor()));
                    },
                    child: Card(
                      child: Container(
                        height: 150,
                        width: 160,
                        child: Column(children: [
                          Padding(padding: EdgeInsets.only(top: 30)),
                          FaIcon(
                            FontAwesomeIcons.userDoctor,
                            color: Colors.blue,
                            size: 50,
                          ),
                          Text(
                            "Choose a Doctor",
                            style: TextStyle(fontSize: 18, color: Colors.blue),
                          ),
                        ]),
                      ),
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(right: 30)),
                  InkWell(
                    onTap: (() {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => reminder()));
                    }),
                    child: Card(
                      child: Container(
                        height: 150,
                        width: 160,
                        child: Column(children: [
                          Padding(padding: EdgeInsets.only(top: 30)),
                          FaIcon(
                            FontAwesomeIcons.clock,
                            color: Colors.blue,
                            size: 50,
                          ),
                          Text(
                            "Set Reminder",
                            style: TextStyle(fontSize: 18, color: Colors.blue),
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
                        height: 150,
                        width: 160,
                        child: Column(children: [
                          Padding(padding: EdgeInsets.only(top: 30)),
                          FaIcon(
                            FontAwesomeIcons.mapLocation,
                            color: Colors.blue,
                            size: 50,
                          ),
                          Text(
                            "Find Nearby Clinic",
                            style: TextStyle(fontSize: 18, color: Colors.blue),
                          ),
                        ]),
                      ),
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(right: 20)),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => beds()));
                    },
                    child: Card(
                      child: Container(
                        height: 150,
                        width: 160,
                        child: Column(children: [
                          Padding(padding: EdgeInsets.only(top: 30)),
                          FaIcon(
                            FontAwesomeIcons.bedPulse,
                            color: Colors.blue,
                            size: 50,
                          ),
                          Text(
                            "Check Available Beds",
                            style: TextStyle(fontSize: 18, color: Colors.blue),
                          ),
                        ]),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
