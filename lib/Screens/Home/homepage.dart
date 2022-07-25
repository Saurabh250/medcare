// ignore_for_file: deprecated_member_use, camel_case_types

import 'package:medcare/Screens/Dashboard/dashboard.dart';
import '../../Utils/color_constants.dart';
import '../../Utils/constant_components.dart';
import '../../Utils/loading_screen.dart';
import '../../Utils/size_config.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({required Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // for dot indicator
  int currentPos = 0;
  bool isLoading = true;
  bool showMoreTopics = false;
  int totalGridToShow = 4;

  Future<void> buildBanners() async {
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    buildBanners();
  }

  @override
  Widget build(BuildContext context) {
    var data;
    return Scaffold(
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
          'Home',
          style: regulartextstyle(
            20,
            amigo_grey,
            false,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return const Dashboard();
                  },
                ),
              );
            },
            icon: SizedBox(
              height: SizeConfig.heightMultiplier! * 2.2,
            ),
          ),
        ],
      ),
      drawer: appDrawer(context),
      body: isLoading
          ? const LoadingScreen()
          : SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  data == null
                      ? Container()
                      : data['profileCompleted'] == false
                          ? InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const Dashboard(),
                                    //builder: (context) => EditAccount(),
                                  ),
                                );
                              },
                              child: Card(
                                elevation: 10,
                                child: Container(
                                  width: double.infinity,
                                  padding: EdgeInsets.symmetric(
                                    horizontal: SizeConfig.widthMultiplier! * 4,
                                    vertical: SizeConfig.heightMultiplier!,
                                  ),
                                  color: amigo_blue,
                                  child: Text(
                                    'Complete your profile ',
                                    style: regulartextstyle(
                                      20,
                                      amigo_white,
                                      false,
                                    ),
                                  ),
                                ),
                              ),
                            )
                          : Container(),

                  // carousal cards
                  Padding(
                    padding: EdgeInsets.only(
                      top: SizeConfig.heightMultiplier! * 2.7,
                      bottom: SizeConfig.heightMultiplier!,
                      left: SizeConfig.widthMultiplier! * 2.7,
                      right: SizeConfig.widthMultiplier! * 2.7,
                    ),
                  ),

                  //  dot incdicator
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                  ),

                  // talk to an expert
                  Padding(
                    padding: EdgeInsets.only(
                      top: SizeConfig.heightMultiplier!,
                      bottom: SizeConfig.heightMultiplier!,
                      left: SizeConfig.widthMultiplier! * 2.7,
                      right: SizeConfig.widthMultiplier! * 2.7,
                    ),
                    child: buildTalkToExpertCard(),
                  ),

                  // have a doubt card
                  Padding(
                    padding: EdgeInsets.only(
                      top: SizeConfig.heightMultiplier!,
                      bottom: SizeConfig.heightMultiplier! * 2,
                      left: SizeConfig.widthMultiplier! * 2.7,
                      right: SizeConfig.widthMultiplier! * 2.7,
                    ),
                    child: buildHaveADoubtCard(),
                  ),

                  // down grid
                  Padding(
                    padding: EdgeInsets.only(
                      top: SizeConfig.heightMultiplier!,
                      bottom: SizeConfig.heightMultiplier!,
                      left: SizeConfig.widthMultiplier! * 2.7,
                      right: SizeConfig.widthMultiplier! * 2.7,
                    ),
                    child: listingOfCategories('', 'problem', totalGridToShow),
                  ),
                ],
              ),
            ),
    );
  }
}

Column buildTalkToExpertCard() {
  return Column(
    children: [
      // talk to expert row

      Row(
        textBaseline: TextBaseline.alphabetic,
        crossAxisAlignment: CrossAxisAlignment.baseline,
        children: [
          Padding(
            padding: EdgeInsets.only(left: SizeConfig.widthMultiplier! * 2),
            child: Text(
              "Talk to an expert",
              style: regulartextstyle(
                20 * 1.1,
                amigo_black,
                false,
              ),
            ),
          ),

          const SizedBox(
            width: 7,
          ),

          // recommended
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: amigo_blue,
                style: BorderStyle.solid,
                width: 1.0,
              ),
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(7),
            ),
            child: Padding(
              padding: const EdgeInsets.all(3.0),
              child: Text(
                "RECOMMENDED",
                style: regulartextstyle(
                  20 * 0.6,
                  amigo_blue,
                  false,
                ),
              ),
            ),
          ),
        ],
      ),

      const SizedBox(
        height: 5,
      ),

      // our card
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                blurRadius: 7,
                color: Colors.grey.shade300,
              ),
            ],
          ),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            shadowColor: amigo_black,
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  // our text row
                  Row(
                    children: [
                      Flexible(
                        child: Text(
                          "Book a private video call with our experts.",
                          style: regulartextstyle(
                            20 * 1.1,
                            amigo_black,
                            true,
                          ),
                        ),
                      ),

                      const SizedBox(
                        width: 2,
                      ),
                      // experts images
                      SizedBox(
                        child: Image.asset("assets/images/expert_group.png"),
                        height: SizeConfig.heightMultiplier! * 7,
                      ),
                    ],
                  ),

                  SizedBox(
                    height: SizeConfig.heightMultiplier! * 3,
                  ),

                  // out button
                  SizedBox(
                    width: double.infinity,
                    height: SizeConfig.heightMultiplier! * 5.5,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                          amigo_blue,
                        ),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              SizeConfig.heightMultiplier! * 5.5 * 0.5,
                            ),
                          ),
                        ),
                      ),
                      onPressed: () {},
                      child: Text(
                        "Get matched now!",
                        style: regulartextstyle(
                          20 * 1.1,
                          amigo_white,
                          false,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    ],
  );
}

Column buildHaveADoubtCard() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      // talk to expert row
      Padding(
        padding: EdgeInsets.only(left: SizeConfig.widthMultiplier! * 2),
        child: Text(
          "Have any doubts?",
          textAlign: TextAlign.left,
          style: regulartextstyle(
            20 * 1.1,
            amigo_black,
            false,
          ),
        ),
      ),

      const SizedBox(
        height: 5,
      ),

      // our card
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                blurRadius: 7,
                color: Colors.grey.shade300,
              ),
            ],
          ),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            shadowColor: amigo_black,
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // our text row
                  Text(
                    "Not sure what you're looking for?",
                    style: regulartextstyle(
                      20 * 1.1,
                      amigo_black,
                      true,
                    ),
                  ),

                  const SizedBox(
                    width: 2,
                  ),

                  Text(
                    "We will help you get more clarity.",
                    style: regulartextstyle(
                      20 * 0.9,
                      amigo_lightGrey,
                      true,
                    ),
                  ),

                  SizedBox(
                    height: SizeConfig.heightMultiplier! * 3,
                  ),

                  // out button
                  SizedBox(
                    width: double.infinity,
                    height: SizeConfig.heightMultiplier! * 5.5,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                          amigo_white,
                        ),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              SizeConfig.heightMultiplier! * 5.5 * 0.5,
                            ),
                            side: const BorderSide(color: amigo_blue),
                          ),
                        ),
                      ),
                      onPressed: () {},
                      child: Text(
                        "Book a FREE call now",
                        style: regulartextstyle(
                          20 * 1.1,
                          amigo_blue,
                          false,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    ],
  );
}

Widget listingOfCategories(
    String title, String titleOfCategory, int numberOfCards) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: EdgeInsets.only(
          left: SizeConfig.widthMultiplier!,
          bottom: SizeConfig.heightMultiplier! * 1.5,
        ),
        child: Text(
          "Topics",
          textAlign: TextAlign.left,
          style: regulartextstyle(
            20 * 1.1,
            amigo_black,
            false,
          ),
        ),
      ),
      const Padding(
        padding: EdgeInsets.all(4.0),
        child: null, //buildGridView(totalGridToShow, titleOfCategory),
      ),
      Padding(
        padding:
            EdgeInsets.symmetric(vertical: SizeConfig.heightMultiplier! * 2.5),
        child: Center(
          child: SizedBox(
            height: SizeConfig.heightMultiplier! * 5.5,
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                  amigo_white,
                ),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      SizeConfig.heightMultiplier! * 5.5 * 0.5,
                    ),
                    side: const BorderSide(color: amigo_blue),
                  ),
                ),
              ),
              onPressed: () {},
              child: null,
            ),
          ),
        ),
      ),
    ],
  );
}

  /* GridView buildGridView(int numberOfCards, String titleOfCategory) {
    return GridView.count(
      shrinkWrap: true,
      crossAxisSpacing: SizeConfig.widthMultiplier! * 6,
      mainAxisSpacing: SizeConfig.widthMultiplier! * 4,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      childAspectRatio: 16 / 9,
      children: List.generate(
        numberOfCards,
        (index) => InkWell(
          onLongPress: () {
            //String therapyName = titleOfCategory + 'Arrays';
            String description;
            List listingNames = [];

            if (titleOfCategory == 'problem') {
              listingNames = problemsArray;
              description = problemsDescription[listingNames[index]];
              titleOfCategory = 'problem';
            }
          },
          onTap: () {
            //String therapyName = titleOfCategory + 'Arrays';
            String description;
            List listingNames = [];

            if (titleOfCategory == 'problem') {
              listingNames = problemsArray;
              description = problemsDescription[listingNames[index]];
              titleOfCategory = 'problem';
            }
            if (titleOfCategory == 'therapyTypes') {
              listingNames = therapyTypesArray;
              description = therapyTypeDescription[listingNames[index]];
            }
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return ExpertListing(
                    therapyType: listingNames[index],
                    therapyDescription: description,
                  );
                },
              ),
            );
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(SizeConfig.widthMultiplier! * 2),
            child: Image.asset(
              'assets/$titleOfCategory/${index - 3}.png',
              width: SizeConfig.widthMultiplier! * 45,
              height: SizeConfig.widthMultiplier! * 25,
            ),
          ),
        ),
      ),
    );
  }

 */