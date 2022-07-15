import 'dart:developer';

import '../../Models/journalModel.dart';
import '../../Screens/Journal/addjournal.dart';
import '../../Services/auth.dart';
import '../../Utils/color_constants.dart';
import '../../Utils/constant_components.dart';
import '../../Utils/size_config.dart';
import 'package:flutter/material.dart';

class JournalPage extends StatefulWidget {
  const JournalPage({super.key});

  @override
  _JournalPageState createState() => _JournalPageState();
}

class _JournalPageState extends State<JournalPage> {
  DateTime focusedDate = DateTime.now();
  DateTime presentDate = DateTime.now();
  DateTime selectedDate = DateTime(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
    5,
    30,
  );
  bool tapped = false;
  int tappedIndex = -1;
  List<JournalModel> listOfJournals = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: appDrawer(context),
      appBar: AppBar(
        backgroundColor: amigo_white,
        centerTitle: true,
        leading: Builder(
          builder: (context) => IconButton(
              icon: Icon(
                Icons.menu,
                size: SizeConfig.heightMultiplier! * 2.5,
                color: amigo_grey,
              ),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              }),
        ),
        title: Text(
          'Journal',
          style: regulartextstyle(
            20,
            amigo_grey,
            false,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.add,
              color: amigo_grey,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => JournalAdd(),
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: SizeConfig.widthMultiplier! * 4,
          ),
          child: Column(
            children: const [],
          ),
        ),
      ),
    );
  }
}

Widget journal(JournalModel givenjournal, int index) {
  Color journalcolor;
  if (givenjournal.color == null) {
    journalcolor = amigo_lightBlue;
  } else {
    journalcolor = Color(givenjournal.color);
  }

  return GestureDetector(
    onTap: () {},
    child: Card(
      margin: EdgeInsets.symmetric(vertical: SizeConfig.heightMultiplier!),
      elevation: 10,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          horizontal: SizeConfig.widthMultiplier! * 3,
          vertical: SizeConfig.heightMultiplier! * 1.5,
        ),
        decoration: BoxDecoration(
          color: journalcolor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              givenjournal.journalTitle,
              style: regulartextstyle(
                20,
                amigo_grey,
                true,
              ),
            ),
            const SizedBox(
              height: 5.0,
            ),
            Text(
              givenjournal.journalBody,
              style: regulartextstyle(
                20,
                amigo_grey,
                false,
              ),
            )
          ],
        ),
      ),
    ),
  );
}
