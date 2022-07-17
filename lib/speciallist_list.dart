// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:medcare/alldoctors.dart';

class SpecialistList extends StatelessWidget {
  SpecialistList({super.key});

  final List<String> entries = <String>[
    "Dermatology, Venereology & Leprosy",
    "Community Medicine",
    "Biophysics",
    "Biochemistry",
    "Anesthesiology",
    "Anatomy",
    "Aerospace Medicine",
    "ENT",
    "General Surgery",
    "Obstetrics and Gynaecology",
    "Traumatology and Surgery",
    "Otorhinolaryngology",
    "Orthopedics",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 80, left: 100, right: 80),
            child: Text(
              "Specialists",
              style: TextStyle(
                  color: Colors.blue,
                  fontSize: 25,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            height: 650,
            width: 390,
            child: SingleChildScrollView(
              child: ListView.builder(
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                scrollDirection: Axis.vertical,
                itemCount: entries.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: ((context) => AllDoctors())));
                      },
                      child: Text(entries[index]),
                      style: ElevatedButton.styleFrom(
                        textStyle: TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                        primary: Color.fromARGB(156, 15, 171, 243),
                        side: BorderSide(width: 1, color: Colors.black),
                        elevation: 1,
                        fixedSize: const Size(370, 50),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 40, vertical: 10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
