// ignore_for_file: camel_case_types, prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_local_variable

import 'package:flutter/material.dart';

class reminder extends StatelessWidget {
  const reminder({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[200],
        title: Text(
          "Set Reminder",
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
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    "Drug Name",
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.blue,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                ],
              ),
              TextFormField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    labelText: "Enter drug name"),
              ),
              SizedBox(
                height: 25,
              ),
              Row(
                children: [
                  Text(
                    "Concern",
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.blue,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    labelText: "Enter drug name"),
              ),
              SizedBox(
                height: 25,
              ),
              Row(
                children: [
                  Text(
                    "Dosage",
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.blue,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    labelText: "0"),
              ),
              SizedBox(
                height: 25,
              ),
              Row(
                children: [
                  Text(
                    "Doctor",
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.blue,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    labelText: "Type Doctor's name"),
              ),
              SizedBox(
                height: 25,
              ),
              Row(
                children: [
                  Text(
                    "Start",
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.blue,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: 150,
                  ),
                  Text(
                    "End",
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.blue,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 150,
                    child: TextFormField(
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(150.0),
                          ),
                          labelText: "01-01-2022"),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                    height: 15,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 150,
                        child: TextFormField(
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(150.0),
                              ),
                              labelText: "01-01-2022"),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 25,
              ),
              Row(
                children: [
                  Text(
                    "Time",
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.blue,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                keyboardType: TextInputType.datetime,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    labelText: "0"),
              ),
              SizedBox(
                height: 15,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("Done"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
