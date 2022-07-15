// ignore_for_file: missing_return

import 'dart:developer';

import 'package:amigoapp/Models/expertModel.dart';
import 'package:amigoapp/Models/session_model.dart';
import 'package:amigoapp/Screens/Dashboard/components/rating.dart';
import 'package:amigoapp/Screens/ExpertProfile/expert_profile.dart';
import 'package:amigoapp/Services/api_service.dart';
import 'package:amigoapp/Services/crud.dart';
import 'package:amigoapp/Utils/color_constants.dart';
import 'package:amigoapp/Utils/constant_components.dart';
import 'package:amigoapp/Utils/loading_screen.dart';
import 'package:amigoapp/Utils/size_config.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';

import 'package:permission_handler/permission_handler.dart';
import '../../VideoCall/test_videocall.dart';

String formatDate(Timestamp date) {
  String formattedDate =
      '${date.toDate().day}/${date.toDate().month}/${date.toDate().year}';
  return formattedDate;
}

String formatTime(Timestamp time) {
  String formattedTime =
      '${time.toDate().hour}:${time.toDate().minute} ${time.toDate().timeZoneName}';
  return formattedTime;
}

bool checkIfSessionActive(DateTime sessionTime) {
  sessionTime.subtract(Duration(minutes: 10));
}

Widget sessionCard(
    bool upcomingSession, SessionModel session, BuildContext kcontext) {
  log(session.sessionExpertName.toString());
  log(session.sessionDate.toString());
  log(Timestamp.now().toString());

  bool isSessionActive = DateTime.now()
      .isAfter(session.sessionDate.toDate().subtract(Duration(minutes: 10)));

  bool isSessionToday =
      DateTime.now().year == session.sessionDate.toDate().year &&
          DateTime.now().month == session.sessionDate.toDate().month &&
          DateTime.now().day == session.sessionDate.toDate().day;

  Timestamp slotDate = session.sessionDate;
  String sessionDate = formatDate(slotDate);
  String sessionTime = formatTime(session.sessionDate);
  String bookingDate = formatDate(session.sessionBookingTime);
  String bookingTime = formatTime(session.sessionBookingTime);

  return InkWell(
    onTap: () async {
      log(session.sessionTherapyType.toString());

      ExpertModel sessionExpert =
          await DatabaseService().getExpertProfile(session.sessionExpertUID);
      int indexOftherapy =
          sessionExpert.expertTherapyTypes.indexOf(session.sessionTherapyType);
      log(sessionExpert.expertTherapyTypes
          .indexOf(session.sessionTherapyType)
          .toString());
      Navigator.push(
        kcontext,
        MaterialPageRoute(
          builder: (kcontext) => ExpertProfile(
            currentExpert: sessionExpert,
            indexOfTherapy: indexOftherapy,
            therapyName: session.sessionTherapyType,
          ),
        ),
      );
    },
    child: Card(
      elevation: 10,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: SizeConfig.widthMultiplier * 2,
          vertical: SizeConfig.widthMultiplier * 2,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          right: SizeConfig.widthMultiplier * 2),
                      child: expertAvatar(session.sessionExpertImageURL),
                    ),
                    sessionDetail(session, sessionDate),
                  ],
                ),
                IconButton(
                  icon: Icon(
                    Icons.info_outline,
                    color: amigo_lightGrey,
                    size: SizeConfig.regulartextSize * 1.5,
                  ),
                  alignment: Alignment.center,
                  onPressed: () async {
                    onTapSessionInfo(kcontext, session, bookingDate,
                        bookingTime, sessionDate, sessionTime, upcomingSession);
                  },
                )
              ],
            ),
            upcomingSession
                ? isSessionToday
                    ? Align(
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding:
                              EdgeInsets.only(top: SizeConfig.heightMultiplier),
                          child: isSessionActive
                              ? sessionJoinButton(session, kcontext)
                              : sessionTodayButton(kcontext),
                        ),
                      )
                    : Container()
                : Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding:
                          EdgeInsets.only(top: SizeConfig.heightMultiplier),
                      child: session.sessionReviewSubmitted
                          ? Container()
                          : sessionRateButton(kcontext, session),
                    ),
                  ),
          ],
        ),
      ),
    ),
  );
}

//-- Details of the session including date, time and expert name
Column sessionDetail(SessionModel session, String sessionDate) {
  return Column(
    mainAxisSize: MainAxisSize.max,
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        session.sessionExpertName,
        style: regulartextstyle(
          SizeConfig.regulartextSize,
          amigo_grey,
          true,
        ),
      ),
      // Gap between name and slot
      SizedBox(
        height: SizeConfig.heightMultiplier,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.max,
        children: [
          Row(
            children: [
              Icon(
                Icons.calendar_today_sharp,
                size: SizeConfig.regulartextSize,
              ),
              SizedBox(
                width: SizeConfig.widthMultiplier,
              ),
              Text(
                sessionDate,
                style: regulartextstyle(
                  SizeConfig.regulartextSize * .8,
                  amigo_grey,
                  false,
                ),
              ),
            ],
          ),
          SizedBox(
            width: SizeConfig.widthMultiplier * 2,
          ),
          Row(
            children: [
              Icon(
                CupertinoIcons.time,
                size: SizeConfig.regulartextSize,
              ),
              SizedBox(
                width: SizeConfig.widthMultiplier,
              ),
              Text(
                session.sessionTime,
                style: regulartextstyle(
                  SizeConfig.regulartextSize * .8,
                  amigo_grey,
                  false,
                ),
              ),
            ],
          ),
        ],
      ),
    ],
  );
}

Widget sessionTodayButton(BuildContext kcontext) {
  return InkWell(
    onTap: () {
      ScaffoldMessenger.of(kcontext).showSnackBar(
        snackBarComponent(
          kcontext,
          "You can join 10 mins before the session",
          Colors.green,
        ),
      );
    },
    child: Container(
      decoration: BoxDecoration(
        color: amigo_blue,
        borderRadius: BorderRadius.circular(13),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: SizeConfig.widthMultiplier * 2,
          horizontal: SizeConfig.widthMultiplier * 6,
        ),
        child: Text(
          'Session Today !',
          style: regulartextstyle(
            SizeConfig.regulartextSize * 0.9,
            amigo_white,
            false,
          ),
        ),
      ),
    ),
  );
}

//-- Rate Button for session
Widget sessionRateButton(BuildContext kcontext, SessionModel session) {
  return InkWell(
    onTap: () {
      rateAndReviewWidget(kcontext, session);
    },
    child: Container(
      decoration: BoxDecoration(
          color: Colors.orangeAccent,
          borderRadius: BorderRadius.circular(SizeConfig.widthMultiplier)),
      child: Padding(
        padding: EdgeInsets.symmetric(
            vertical: SizeConfig.widthMultiplier * 2,
            horizontal: SizeConfig.widthMultiplier * 5),
        child: Text(
          'Rate',
          style: regulartextstyle(
              SizeConfig.regulartextSize * 0.9, amigo_white, false),
        ),
      ),
    ),
  );
}

Future<bool> helpMe() async {
  // ignore: unused_local_variable
  Map<Permission, PermissionStatus> statuses = await [
    Permission.camera,
    Permission.microphone,
    Permission.bluetooth,
  ].request();

  if (await Permission.bluetooth.isGranted &&
      await Permission.camera.isGranted &&
      await Permission.bluetooth.isGranted) {
    print("PERMISSONS");
    print(Permission.bluetooth.isGranted);
    print(Permission.camera.isGranted);
    print(Permission.microphone.isGranted);
    return true;
  } else {
    print("PERMISSONS");
    print(await Permission.bluetooth.isGranted);
    print(await Permission.camera.isGranted);
    print(await Permission.microphone.isGranted);
    return false;
  }
}

//--- Rate and Review the session
Future rateAndReviewWidget(
  BuildContext kcontext,
  SessionModel session,
) {
  log(session.sessionUID);
  log(session.sessionExpertUID);
  return showDialog(
      context: kcontext,
      builder: (kcontext) {
        return Rating(
          currentSession: session,
        );
      });
}

Container giveRating() {
  return Container(
    width: double.infinity,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(5, (index) => ratingStar()),
    ),
  );
}

Widget ratingStar() {
  return Icon(
    Icons.star,
    color: Colors.orangeAccent,
    size: SizeConfig.heightMultiplier * 5,
  );
}

//--Submit Review

Widget sessionJoinButton(SessionModel session, BuildContext kcontext) {
  return InkWell(
    onTap: () async {
      showDialog(
          context: kcontext,
          builder: (kcontext) => CupertinoAlertDialog(
                content: Text('Proceed to Call ?'),
                actions: [
                  CupertinoDialogAction(
                      child: Text('Okay'),
                      onPressed: () async {
                        // await Permission.camera.request();
                        // await Permission.microphone.request();
                        var camStatus = await Permission.camera.status;
                        log("PERMISSON OF CAMERA $camStatus");
                        var micStatus = await Permission.microphone.status;
                        log("PERMISSON OF MIC $micStatus");

                        Navigator.push(
                          kcontext,
                          MaterialPageRoute(
                            builder: (kcontext) => LoadingScreen(),
                          ),
                        );
                        List<String> data = await ApiService().getAgoraToken(
                          session.sessionUserUID,
                          session.sessionUID,
                        );

                        log("response is " + data.toString());
                        log("token is " + data[0]);
                        log("channel name is " + data[1]);
                        Navigator.pop(kcontext);
                        Navigator.push(
                          kcontext,
                          MaterialPageRoute(
                            builder: (kcontext) => TestCallPage(
                              channelName: data[1],
                              token: data[0],
                              appID: data[2],
                              session: session,
                              sessionId: '0',
                            ),
                          ),
                        );
                        //   if (await helpMe()) {
                        //     Navigator.push(
                        //       kcontext,
                        //       MaterialPageRoute(
                        //         builder: (kcontext) => LoadingScreen(),
                        //       ),
                        //     );
                        //     List<String> data = await ApiService().getAgoraToken(
                        //       session.sessionUserUID,
                        //       session.sessionUID,
                        //     );

                        //     log("response is " + data.toString());
                        //     Navigator.pop(kcontext);
                        //     Navigator.push(
                        //       kcontext,
                        //       MaterialPageRoute(
                        //         builder: (kcontext) => CallPage(
                        //           channelName: data[1],
                        //           // role: ClientRole.Broadcaster,
                        //           token: data[0],
                        //           // appID: data[2],
                        //           session: session,
                        //           sessionId: '0',
                        //         ),
                        //       ),
                        //     );
                        //   } else {
                        //     showNotificationDialog(
                        //       "Permission Error",
                        //       "Please accept all permissions before proceeding.",
                        //       'OK',
                        //       '',
                        //       kcontext,
                        //     );
                        //   }
                      })
                ],
              ));
    },
    child: Container(
      // width: SizeConfig.widthMultiplier * 30,
      decoration: BoxDecoration(
        color: Colors.green,
        borderRadius: BorderRadius.circular(SizeConfig.widthMultiplier),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: SizeConfig.widthMultiplier * 2,
          horizontal: SizeConfig.widthMultiplier * 5,
        ),
        child: Text(
          'Join Session',
          style: regulartextstyle(
            SizeConfig.regulartextSize * 0.9,
            amigo_white,
            false,
          ),
        ),
      ),
    ),
  );
}

InkWell sessionInfoButton(
    bool isUpcoming,
    BuildContext kcontext,
    SessionModel session,
    String bookingDate,
    String bookingTime,
    String sessionDate,
    String sessionTime) {
  return InkWell(
    onTap: () {
      onTapSessionInfo(
        kcontext,
        session,
        bookingDate,
        bookingTime,
        sessionDate,
        sessionTime,
        isUpcoming,
      );
    },
    child: Container(
      decoration: BoxDecoration(
        color: amigo_blue,
        borderRadius: BorderRadius.circular(
          SizeConfig.widthMultiplier,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: SizeConfig.widthMultiplier * 2,
          horizontal: SizeConfig.widthMultiplier * 6,
        ),
        child: Text(
          'Session info',
          style: regulartextstyle(
            SizeConfig.regulartextSize * 0.9,
            amigo_white,
            false,
          ),
        ),
      ),
    ),
  );
}

Future onTapSessionInfo(
  BuildContext kcontext,
  SessionModel session,
  String bookingDate,
  String bookingTime,
  String sessionDate,
  String sessionTime,
  bool isUpcoming,
) {
  log("REVIEW SUBMITTED ${session.sessionReviewSubmitted}");
  return showDialog(
    context: kcontext,
    builder: (kcontext) => Platform.isIOS
        ? CupertinoAlertDialog(
            title: Text('Session Info'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                sessionDetailText('Expert name', session.sessionExpertName),
                sessionDetailText('Therapy Type', session.sessionTherapyType),
                sessionDetailText('Booking Date', bookingDate),
                sessionDetailText('Booking Time', bookingTime),
                sessionDetailText('Session Date', sessionDate),
                sessionDetailText('Session Time', sessionTime),
                sessionDetailText('Client name', session.sessionUserName),
                !session.sessionReviewSubmitted
                    ? Text(
                        'Review submitted',
                        textAlign: TextAlign.center,
                        style: regulartextstyle(
                          SizeConfig.regulartextSize * 0.7,
                          amigo_grey,
                          false,
                        ),
                      )
                    : Container(),
                isUpcoming
                    ? Text(
                        'You can join the call 10 mins before the session.',
                        textAlign: TextAlign.center,
                        style: regulartextstyle(
                          SizeConfig.regulartextSize * 0.7,
                          amigo_grey,
                          false,
                        ),
                      )
                    : Container(),
              ],
            ),
            actions: [
              CupertinoDialogAction(
                child: Text(
                  'Get invoice',
                  style: regulartextstyle(
                      SizeConfig.regulartextSize * 0.8, amigo_blue, false),
                ),
              ),
              isUpcoming
                  ? CupertinoDialogAction(
                      child: Text(
                        'Request Cancellation/Reschedule',
                        style: regulartextstyle(
                            SizeConfig.regulartextSize * 0.8,
                            amigo_blue,
                            false),
                      ),
                    )
                  : CupertinoDialogAction(
                      child: Text(
                        'Request Individual Session Report',
                        style: regulartextstyle(
                            SizeConfig.regulartextSize * 0.8,
                            amigo_blue,
                            false),
                      ),
                    )
            ],
          )
        : AlertDialog(
            backgroundColor: amigo_backgroundLightGrey,
            shape: RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.circular(SizeConfig.widthMultiplier * 2),
            ),
            title: Text(
              'Session Info',
              textAlign: TextAlign.center,
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                sessionDetailText('Expert name', session.sessionExpertName),
                sessionDetailText('Therapy Type', session.sessionTherapyType),
                sessionDetailText('Booking Date', bookingDate),
                sessionDetailText('Booking Time', bookingTime),
                sessionDetailText('Session Date', sessionDate),
                sessionDetailText('Session Time', sessionTime),
                sessionDetailText('Client name', session.sessionUserName),
                sessionDetailText(
                    'Amount Paid', '₹${session.sessionAmountPaid.toString()}'),
                Text(''),
                !session.sessionReviewSubmitted
                    ? Text(
                        'Rating has been submitted submitted',
                        textAlign: TextAlign.center,
                        style: regulartextstyle(
                          SizeConfig.regulartextSize * 0.7,
                          amigo_grey,
                          false,
                        ),
                      )
                    : Container(),
                isUpcoming
                    ? Text(
                        'You can join the call 10 mins before the session.',
                        textAlign: TextAlign.center,
                        style: regulartextstyle(
                          SizeConfig.regulartextSize * 0.7,
                          amigo_grey,
                          false,
                        ),
                      )
                    : Container(),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  ApiService().sendInvoice(session.sessionUID);
                },
                child: Text(
                  'Get invoice',
                  textAlign: TextAlign.start,
                  style: regulartextstyle(
                    SizeConfig.regulartextSize * 0.8,
                    amigo_blue,
                    false,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  'Request Session Report',
                  textAlign: TextAlign.center,
                  style: regulartextstyle(
                    SizeConfig.regulartextSize * 0.8,
                    amigo_blue,
                    false,
                  ),
                ),
              ),
            ],
          ),
  );
}

Row sessionDetailText(String title, String value) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        title,
        style: regulartextstyle(
          SizeConfig.regulartextSize * 0.8,
          amigo_grey,
          false,
        ),
      ),
      Text(
        value,
        style: regulartextstyle(
          SizeConfig.regulartextSize * 0.8,
          amigo_grey,
          true,
        ),
      )
    ],
  );
}

//--Circle Avatar for doctor's image
Container expertAvatar(String imageUrl) {
  return Container(
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(SizeConfig.widthMultiplier * 10),
        border: Border.all(color: amigo_blue, width: 0.5)),
    child: CircleAvatar(
      radius: SizeConfig.widthMultiplier * 7.5,
      backgroundImage: AssetImage('assets/images/DefaultPhoto.jpg'),
      foregroundImage: NetworkImage(imageUrl),
    ),
  );
}
