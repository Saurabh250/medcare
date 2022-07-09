// ignore_for_file: camel_case_types, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class beds extends StatelessWidget {
  const beds({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[200],
        title: Text(
          "Displaying Available Beds",
          style: TextStyle(
              fontSize: 17,
              color: Colors.blue[600],
              fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(15.0),
          child: Column(children: [
            Row(
              children: [
                Text(
                  "Results showing hospitals with available beds",
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.blue,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Card(
              child: Container(
                height: 150,
                width: 550,
                child: Column(children: [
                  Padding(padding: EdgeInsets.only(top: 30)),
                  Text(
                    "Sri Jayadeva Institute of Cardiology(SJIC)",
                    style: TextStyle(fontSize: 18, color: Colors.black),
                  ),
                  Text(
                    "+91 5887357996",
                    style: TextStyle(fontSize: 14),
                  ),
                  Text(
                    "15th main road, kengeri Clinic, doctors for various veins treatment",
                    style: TextStyle(fontSize: 14),
                  ),
                  Text(
                    "20 beds available",
                    style: TextStyle(fontSize: 14),
                  ),
                ]),
              ),
            ),
            Card(
              child: Container(
                height: 150,
                width: 550,
                child: Column(children: [
                  Padding(padding: EdgeInsets.only(top: 30)),
                  Text(
                    "Rajarajeshwari Medical College and Hospital(RRMCH)",
                    style: TextStyle(fontSize: 18, color: Colors.black),
                  ),
                  Text(
                    "+91 9874563210",
                    style: TextStyle(fontSize: 14),
                  ),
                  Text(
                    "15th main road, kengeri Clinic, doctors for various bones treatment",
                    style: TextStyle(fontSize: 14),
                  ),
                  Text(
                    "30 beds available",
                    style: TextStyle(fontSize: 14),
                  ),
                ]),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
