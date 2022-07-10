// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'package:flutter/material.dart';

class Specialist extends StatelessWidget {
  const Specialist({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding:
                  EdgeInsets.only(top: 80, left: 100, right: 80, bottom: 10),
              child: Text(
                "Specialists",
                style: TextStyle(
                    color: Colors.blue,
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    left: 10,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: Text("Dermatology, Venereology & Leprosy"),
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
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 10),
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: Text("Community Medicine"),
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
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 10),
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: Text("Biophysics"),
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
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 10),
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: Text("Biochemistry"),
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
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 10),
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: Text("	Anesthesiology"),
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
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 10),
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: Text("	Anatomy"),
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
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 10),
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: Text("	Aerospace Medicine"),
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
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 10),
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: Text("	ENT"),
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
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 10),
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: Text("	General Surgery"),
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
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 10),
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: Text("	Obstetrics and Gynaecology"),
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
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 10),
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: Text("	Traumatology and Surgery"),
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
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 10),
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: Text("	Otorhinolaryngology"),
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
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 10),
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: Text("	Orthopedics"),
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
              ],
            ),
          ],
        ),
      ),
    );
  }
}
