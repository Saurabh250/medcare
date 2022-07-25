// ignore_for_file: camel_case_types, prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_import, sized_box_for_whitespace

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:medcare/Models/hospitalModel.dart';
import 'package:medcare/Services/http_request.dart';

class beds extends StatelessWidget {
  beds({super.key, required this.title});
  late String title;

  @override
  Widget build(BuildContext context) {
    var items = hospitalList();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[200],
        title: Text(
          title,
          style: TextStyle(
              fontSize: 17, color: Colors.white, fontWeight: FontWeight.bold),
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
            ListView.builder(
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                scrollDirection: Axis.vertical,
                itemCount: items.length,
                itemBuilder: (context, index) {
                  var data = items[index];
                  return Card(
                    child: Container(
                      height: 150,
                      width: 550,
                      child: Column(children: [
                        Padding(padding: EdgeInsets.only(top: 30)),
                        Text(
                          data.name,
                          style: TextStyle(fontSize: 18, color: Colors.black),
                        ),
                        Text(
                          data.phone,
                          style: TextStyle(fontSize: 14),
                        ),
                        Text(
                          data.address,
                          style: TextStyle(fontSize: 14),
                        ),
                        Text(
                          data.beds + " beds available",
                          style: TextStyle(fontSize: 14),
                        ),
                      ]),
                    ),
                  );
                }),
          ]),
        ),
      ),
    );
  }

  List<HospitalList> hospitalList() {
    var list = <HospitalList>[];
    HospitalList data;
    int index = nohospital;
    //print(index);
    if (index != 0) {
      for (int i = 0; i < index; i++) {
        data = HospitalList(
            json.decode(hospitalresponse)["entries"][i]["name"],
            json.decode(hospitalresponse)["entries"][i]["phone"],
            json.decode(hospitalresponse)["entries"][i]["address"],
            json.decode(hospitalresponse)["entries"][i]["pricing"],
            json.decode(hospitalresponse)["entries"][i]["rating"],
            json.decode(hospitalresponse)["entries"][i]["Beds"]);
        list.add(data);
        //  print(data);
      }
    }
    return list;
  }
}
