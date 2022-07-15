import 'dart:developer';

import 'package:amigoapp/Models/journalModel.dart';
import 'package:amigoapp/Screens/Journal/addjournal.dart';
import 'package:amigoapp/Services/auth.dart';
import 'package:amigoapp/Utils/color_constants.dart';
import 'package:amigoapp/Utils/constant_components.dart';
import 'package:amigoapp/Utils/size_config.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class JournalPage extends StatefulWidget {
  const JournalPage({Key key}) : super(key: key);

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
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('users')
          .doc(AuthServices().returnUserUID())
          .collection('journal')
          .where('date', isEqualTo: Timestamp.fromDate(selectedDate).toDate())
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          listOfJournals = [];
          try {
            for (var doc in snapshot.data.docs) {
              JournalModel currentReview = JournalModel.fromJson(doc.data());
              listOfJournals.add(currentReview);
            }
          } catch (e) {
            log(e.toString());
          }
        }
        return Scaffold(
          drawer: appDrawer(context),
          appBar: AppBar(
            backgroundColor: amigo_white,
            centerTitle: true,
            leading: Builder(
              builder: (context) => IconButton(
                  icon: Icon(
                    Icons.menu,
                    size: SizeConfig.heightMultiplier * 2.5,
                    color: amigo_grey,
                  ),
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  }),
            ),
            title: Text(
              'Journal',
              style: regulartextstyle(
                SizeConfig.appBarTextSize,
                amigo_grey,
                false,
              ),
            ),
            actions: [
              IconButton(
                icon: Icon(
                  Icons.add,
                  color: amigo_grey,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => JournalAdd(
                        selectedDate: selectedDate,
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
          body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: SizeConfig.widthMultiplier * 4,
              ),
              child: Column(
                children: [
                  Container(
                      child: TableCalendar(
                    headerStyle: HeaderStyle(
                      titleCentered: true,
                      formatButtonVisible: false,
                      titleTextStyle: regulartextstyle(
                        SizeConfig.appBarTextSize,
                        amigo_blue,
                        true,
                      ),
                    ),
                    calendarStyle: CalendarStyle(
                      selectedDecoration: BoxDecoration(
                        color: amigo_blue,
                        shape: BoxShape.circle,
                      ),
                    ),
                    firstDay: DateTime(2015),
                    lastDay: presentDate,
                    focusedDay: focusedDate,
                    selectedDayPredicate: (day) {
                      return isSameDay(selectedDate, day);
                    },
                    onDaySelected: (selectedDay, focusedDay) async {
                      setState(() {
                        selectedDate = selectedDay;
                        focusedDate = focusedDay;
                      });
                    },
                    onPageChanged: (focusedDay) {
                      focusedDate = focusedDay;
                    },
                  )),
                  SizedBox(
                    height: SizeConfig.heightMultiplier * 2,
                  ),
                  listOfJournals.length == 0
                      ? Padding(
                          padding: EdgeInsets.only(
                            top: SizeConfig.heightMultiplier * 4,
                          ),
                          child: Text(
                            "Tap on + to add an entry",
                            textAlign: TextAlign.center,
                            style: regulartextstyle(
                              SizeConfig.regulartextSize,
                              amigo_lightGrey,
                              false,
                            ),
                          ),
                        )
                      : Column(
                          children: List.generate(
                            listOfJournals.length,
                            (index) => journal(
                              listOfJournals[index],
                              index,
                            ),
                          ),
                        ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget journal(JournalModel givenjournal, int index) {
    Color journalcolor;
    if (givenjournal.color == null)
      journalcolor = amigo_lightBlue;
    else
      journalcolor = Color(givenjournal.color);

    return GestureDetector(
      onTap: () {
        tapped = !tapped;
        setState(() {
          if (tapped)
            tappedIndex = index;
          else
            tappedIndex = -1;
        });
      },
      child: Card(
        margin: EdgeInsets.symmetric(vertical: SizeConfig.heightMultiplier),
        elevation: 10,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(
            horizontal: SizeConfig.widthMultiplier * 3,
            vertical: SizeConfig.heightMultiplier * 1.5,
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
                  SizeConfig.regulartextSize,
                  amigo_grey,
                  true,
                ),
              ),
              SizedBox(
                height: 5.0,
              ),
              Text(
                givenjournal.journalBody,
                maxLines: tappedIndex == index ? null : 1,
                overflow: tappedIndex == index ? null : TextOverflow.ellipsis,
                style: regulartextstyle(
                  SizeConfig.regulartextSize,
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
}
