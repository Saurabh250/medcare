import 'package:flutter/material.dart';

class AllDoctors extends StatelessWidget {
  const AllDoctors({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[200],
        title: Text(
          "Doctor List",
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
                "Results showing available doctors",
                style: TextStyle(
                    fontSize: 15,
                    color: Colors.blue,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
          Card(
            child: Container(
              height: 120,
              width: 500,
              child: Column(children: [
                Padding(padding: EdgeInsets.only(top: 15, left: 90, right: 50)),
                Text(
                  "Dr. Janice",
                  style: TextStyle(fontSize: 18, color: Colors.black),
                ),
                Text(
                  "General Physician",
                  style: TextStyle(fontSize: 14),
                ),
                Text(
                  "MD-General Medicine, yuhhutiuu",
                  style: TextStyle(fontSize: 14),
                ),
                SizedBox(
                  height: 8.0,
                ),
                Text(
                  "Price 200",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ]),
            ),
          ),
          Card(
            child: Container(
              height: 120,
              width: 500,
              child: Column(children: [
                Padding(padding: EdgeInsets.only(top: 15, left: 90, right: 50)),
                Text(
                  "Dr. Janice",
                  style: TextStyle(fontSize: 18, color: Colors.black),
                ),
                Text(
                  "General Physician",
                  style: TextStyle(fontSize: 14),
                ),
                Text(
                  "MD-General Medicine, yuhhutiuu",
                  style: TextStyle(fontSize: 14),
                ),
                SizedBox(
                  height: 8.0,
                ),
                Text(
                  "Price 200",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ]),
            ),
          ),
          Card(
            child: Container(
              height: 120,
              width: 500,
              child: Column(children: [
                Padding(padding: EdgeInsets.only(top: 15, left: 90, right: 50)),
                Text(
                  "Dr. Janice",
                  style: TextStyle(fontSize: 18, color: Colors.black),
                ),
                Text(
                  "General Physician",
                  style: TextStyle(fontSize: 14),
                ),
                Text(
                  "MD-General Medicine, yuhhutiuu",
                  style: TextStyle(fontSize: 14),
                ),
                SizedBox(
                  height: 8.0,
                ),
                Text(
                  "Price 200",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ]),
            ),
          ),
          Card(
            child: Container(
              height: 120,
              width: 500,
              child: Column(children: [
                Padding(padding: EdgeInsets.only(top: 15, left: 90, right: 50)),
                Text(
                  "Dr. Janice",
                  style: TextStyle(fontSize: 18, color: Colors.black),
                ),
                Text(
                  "General Physician",
                  style: TextStyle(fontSize: 14),
                ),
                Text(
                  "MD-General Medicine, yuhhutiuu",
                  style: TextStyle(fontSize: 14),
                ),
                SizedBox(
                  height: 8.0,
                ),
                Text(
                  "Price 200",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ]),
            ),
          ),
          Card(
            child: Container(
              height: 120,
              width: 500,
              child: Column(children: [
                Padding(padding: EdgeInsets.only(top: 15, left: 90, right: 50)),
                Text(
                  "Dr. Janice",
                  style: TextStyle(fontSize: 18, color: Colors.black),
                ),
                Text(
                  "General Physician",
                  style: TextStyle(fontSize: 14),
                ),
                Text(
                  "MD-General Medicine, yuhhutiuu",
                  style: TextStyle(fontSize: 14),
                ),
                SizedBox(
                  height: 8.0,
                ),
                Text(
                  "Price 200",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ]),
            ),
          ),
        ]),
      )),
    );
  }
}
