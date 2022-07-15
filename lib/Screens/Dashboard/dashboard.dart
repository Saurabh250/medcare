import '../../Utils/color_constants.dart';
import '../../Utils/constant_components.dart';
import '../../Utils/size_config.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  //--booleans for the session switching DEFAULT to Upcoming Sessions
  bool displayUpcomingSessions = true;
  bool displayPreviousSessions = false;
  //--Placeholder for user name
  //String userUID = AuthServices().returnUserUID();

  //--Receiving User Data for Dashboard

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // getuserdata();
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
          'Dashboard',
          style: regulartextstyle(
            20,
            amigo_grey,
            false,
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Container(
          padding: EdgeInsets.symmetric(
            vertical: SizeConfig.heightMultiplier! * 2,
            horizontal: SizeConfig.widthMultiplier! * 2,
          ),
          child: Column(
            children: [
              //---- TOP BAR FOR USER DATA AND GREETINGS
              Padding(
                padding: EdgeInsets.only(
                  bottom: SizeConfig.widthMultiplier! * 4,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        Text(
                          'Hey there !',
                          style: regulartextstyle(20, amigo_grey, false),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              //---- LINE FOR SPACING BETWEEN SESSIONS AND DETAILS
              //---- SESSION BUTTONS
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: SizeConfig.widthMultiplier! * 2,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    toggleSessionButton(
                      'Upcoming sessions',
                      displayUpcomingSessions,
                    ),
                    SizedBox(
                      width: SizeConfig.widthMultiplier! * 5,
                    ),
                    toggleSessionButton(
                      'Previous sessions',
                      displayPreviousSessions,
                    )
                  ],
                ),
              ),
              //---- SESSION LIST BASED ON CHOICE OF TYPE
              //displaySessionsList(),
            ],
          ),
        ),
      ),
    );
  }
}

//---FIREBASE QUERY FOR TOTAL LIST OF SESSIONS OF THE USER

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
            width: SizeConfig.widthMultiplier! / 2,
          ),
        ),
      ),
      child: InkWell(
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: regulartextstyle(
              20,
              textColor,
              displayBool,
            ),
          ),
        ),
      ),
    ),
  );
}
