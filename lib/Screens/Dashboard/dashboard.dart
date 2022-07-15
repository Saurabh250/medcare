import 'package:amigoapp/Models/session_model.dart';
import 'package:amigoapp/Screens/Edit_Account/edit_account.dart';
import 'package:amigoapp/Services/auth.dart';
import 'package:amigoapp/Services/crud.dart';
import 'package:amigoapp/Utils/color_constants.dart';
import 'package:amigoapp/Utils/constant_components.dart';
import 'package:amigoapp/Utils/size_config.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'components/sessionCard.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  //--booleans for the session switching DEFAULT to Upcoming Sessions
  bool displayUpcomingSessions = true;
  bool displayPreviousSessions = false;
  //--Placeholder for user name
  String userUID = AuthServices().returnUserUID();

  //--Receiving User Data for Dashboard

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // getuserdata();
    return StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(userUID)
            .snapshots(),
        builder: (context, snapshot) {
          Map data = snapshot.data?.data();

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
                'Dashboard',
                style: regulartextstyle(
                  SizeConfig.appBarTextSize,
                  amigo_grey,
                  false,
                ),
              ),
              actions: [
                IconButton(
                  icon: Icon(
                    Icons.edit,
                    color: amigo_grey,
                    size: SizeConfig.heightMultiplier * 2.5,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditAccount(),
                      ),
                    );
                  },
                )
              ],
            ),
            body: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Container(
                padding: EdgeInsets.symmetric(
                  vertical: SizeConfig.heightMultiplier * 2,
                  horizontal: SizeConfig.widthMultiplier * 2,
                ),
                child: Column(
                  children: [
                    //---- TOP BAR FOR USER DATA AND GREETINGS
                    Padding(
                      padding: EdgeInsets.only(
                        bottom: SizeConfig.widthMultiplier * 4,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          CircleAvatar(
                            radius: SizeConfig.widthMultiplier * 10.5,
                            backgroundColor: amigo_blue,
                            child: CircleAvatar(
                              radius: SizeConfig.widthMultiplier * 10,
                              foregroundImage: data == null ||
                                      data['imgUrl'] == null ||
                                      data['imgUrl'] == ""
                                  ? NetworkImage(
                                      "https://firebasestorage.googleapis.com/v0/b/amigo-demo-71e13.appspot.com/o/Profile%20dummy(1).png?alt=media&token=b47efe10-96af-4389-8d91-7a7b5058a2c9",
                                    )
                                  : NetworkImage(
                                      data['imgUrl'] as String,
                                    ),
                            ),
                          ),
                          Column(
                            children: [
                              Text(
                                'Hey there !',
                                style: regulartextstyle(
                                    SizeConfig.regulartextSize,
                                    amigo_grey,
                                    false),
                              ),
                              Text(
                                data != null && data['name'] != ''
                                    ? data['name']
                                    : "Guest",
                                style: regulartextstyle(
                                    SizeConfig.regulartextSize,
                                    amigo_grey,
                                    false),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    //---- LINE FOR SPACING BETWEEN SESSIONS AND DETAILS
                    //---- SESSION BUTTONS
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: SizeConfig.widthMultiplier * 2,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          toggleSessionButton(
                            'Upcoming sessions',
                            displayUpcomingSessions,
                          ),
                          SizedBox(
                            width: SizeConfig.widthMultiplier * 5,
                          ),
                          toggleSessionButton(
                            'Previous sessions',
                            displayPreviousSessions,
                          )
                        ],
                      ),
                    ),
                    //---- SESSION LIST BASED ON CHOICE OF TYPE
                    displaySessionsList(),
                  ],
                ),
              ),
            ),
          );
        });
  }

  //---FIREBASE QUERY FOR TOTAL LIST OF SESSIONS OF THE USER
  StreamBuilder<QuerySnapshot<Object>> displaySessionsList() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('sessions')
          .where('userID', isEqualTo: userUID)
          .snapshots(),
      builder: (context, snapshot) {
        //LOADING WIDGET FOR THE STREAM
        if (!snapshot.hasData ||
            snapshot.hasError ||
            snapshot.connectionState == ConnectionState.waiting)
          return Container(
            padding: EdgeInsets.only(top: SizeConfig.widthMultiplier * 10),
            child: Text(
              'Fetching Sessions in 1,2,3... ',
              textAlign: TextAlign.center,
              style: regulartextstyle(
                SizeConfig.regulartextSize,
                amigo_lightGrey,
                false,
              ),
            ),
          );

        //NO SESSIONS RETRIEVED
        else if (snapshot.data == null || snapshot.data.size == 0)
          return Container(
            padding: EdgeInsets.only(top: SizeConfig.widthMultiplier * 10),
            child: Text(
              displayUpcomingSessions
                  ? 'No upcoming sessions'
                  : 'No previous sessions',
              textAlign: TextAlign.center,
              style: regulartextstyle(
                SizeConfig.regulartextSize,
                amigo_lightGrey,
                false,
              ),
            ),
          );

        //--RETRIEVED SESSIONS
        else {
          //--- Retrieve all sessions from the snapshot as Session Models
          List<SessionModel> listOfSessions =
              DatabaseService().getSessionModelLists(snapshot.data);
          //--- SEPARATING SESSIONS INTO THE CATEGORIES

          List separatedSessions =
              DatabaseService().getUpcomingSessionLists(listOfSessions);
          List<SessionModel> upcomingSessions = separatedSessions[0];
          List<SessionModel> previousSessions = separatedSessions[1];

          return displayUpcomingSessions
              ? upcomingSessions.length == 0
                  ? Container(
                      padding:
                          EdgeInsets.only(top: SizeConfig.widthMultiplier * 10),
                      child: Text(
                        'No upcoming sessions',
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
                        upcomingSessions.length,
                        (index) => sessionCard(
                          true,
                          upcomingSessions[index],
                          context,
                        ),
                      ),
                    )
              : previousSessions.length == 0
                  ? Container(
                      padding:
                          EdgeInsets.only(top: SizeConfig.widthMultiplier * 10),
                      child: Text(
                        'Take the first step towards self care\nBook a session with a therapist',
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
                        previousSessions.length,
                        (index) => sessionCard(
                          false,
                          previousSessions[index],
                          context,
                        ),
                      ),
                    );
        }
      },
    );
  }

  Widget toggleSessionButton(String text, bool displayBool) {
    Color textColor = displayBool ? amigo_blue : amigo_lightGrey;
    Color borderColor = displayBool ? amigo_blue : amigo_lightGrey;
    return Expanded(
      flex: 1,
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: borderColor,
              width: SizeConfig.widthMultiplier / 2,
            ),
          ),
        ),
        child: InkWell(
          onTap: () {
            setState(() {
              displayPreviousSessions = !displayPreviousSessions;
              displayUpcomingSessions = !displayUpcomingSessions;
            });
          },
          child: Padding(
            padding: EdgeInsets.only(bottom: SizeConfig.widthMultiplier),
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: regulartextstyle(
                SizeConfig.regulartextSize,
                textColor,
                displayBool,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
