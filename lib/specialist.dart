// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:medcare/Models/specialistModel.dart';
import 'package:medcare/Services/http_request.dart';
import 'package:medcare/Utils/size_config.dart';
import 'package:medcare/alldoctors.dart';

class Specialist extends StatelessWidget {
  Specialist({super.key});
  int numberOfCards = 13;
  String titleOfCategory = 'problem';

  final List entries = [
    {"name": "Dermatology, Venereology & Leprosy", "color": Colors.blue},
    {"name": "Community Medicine", "color": Colors.blue},
    {"name": "Biophysics", "color": Colors.blue},
    {"name": "Biochemistry", "color": Colors.blue},
    {"name": "Anesthesiology", "color": Colors.blue},
    {"name": "Anatomy", "color": Colors.blue},
    {"name": "Aerospace Medicine", "color": Colors.blue},
    {"name": "ENT", "color": Colors.blue},
    {"name": "General Surgery", "color": Colors.blue},
    {"name": "Obstetrics and Gynaecology", "color": Colors.blue},
    {"name": "Traumatology and Surgery", "color": Colors.blue},
    {"name": "Otorhinolaryngology", "color": Colors.blue},
    {"name": "Orthopedics", "color": Colors.blue},
  ];

  @override
  Widget build(BuildContext context) {
    var items = specialistList(); // list assign
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 70),
                child: Container(
                  child: Text(
                    "Specialist",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: GridView.builder(
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 180,
                      childAspectRatio: 2.5,
                      crossAxisSpacing: 15,
                      mainAxisSpacing: 20),
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: items.length,
                  itemBuilder: (BuildContext ctx, index) {
                    var data = items[index]; // index value of list
                    return InkWell(
                      onTap: () {
                        debugPrint(data.name);
                        debugPrint("pressed");
                        specialist();
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: ((context) => AllDoctors())));
                      },
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(15)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: Text(
                            data.name,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }

  List<SpecialistList> specialistList() {
    var list = <SpecialistList>[];
    SpecialistList data;
    int index = nospecialist;
    // print(index);
    if (index != 0) {
      for (int i = 0; i < index; i++) {
        data = SpecialistList(
            json.decode(specialistresponse)["entries"][i]["name"]);
        list.add(data);
        //  print(data);
      }
    }
    return list;
  }
}
