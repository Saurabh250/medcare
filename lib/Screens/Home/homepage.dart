// ignore_for_file: deprecated_member_use, camel_case_types

import 'package:amigoapp/Models/adBannerModel.dart';
import 'package:amigoapp/Screens/Edit_Account/edit_account.dart';
import 'package:amigoapp/Screens/Listing/constants.dart';
import 'package:amigoapp/Screens/Listing/expert_listing.dart';
import 'package:amigoapp/Services/api_service.dart';
import 'package:amigoapp/Services/auth.dart';
import 'package:amigoapp/Services/firebase_dynamic_link.dart';
import 'package:amigoapp/Utils/color_constants.dart';
import 'package:amigoapp/Utils/constant_components.dart';
import 'package:amigoapp/Utils/loading_screen.dart';
import 'package:amigoapp/Utils/size_config.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';
import '../chat/main_chat_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // for dot indicator
  int currentPos = 0;
  bool isLoading = true;
  bool showMoreTopics = false;
  int totalGridToShow = 4;
  List<AdBannerModel> adBannerLists = [];

  Future<void> buildBanners() async {
    var data = await FirebaseFirestore.instance.collection('adBanners').get();

    for (var banner in data.docs) {
      adBannerLists.add(AdBannerModel.fromJson(banner.data()));
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    buildBanners();
    FirebaseDynamicLinkService.initDynamicLink(context);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance
          .collection('users')
          .doc(AuthServices().returnUserUID())
          .snapshots(),
      builder: (context, snapshot) {
        Map data = snapshot.data?.data();

        return Scaffold(
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
              'Home',
              style: regulartextstyle(
                SizeConfig.appBarTextSize,
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
                        return MainChatScreen();
                      },
                    ),
                  );
                },
                icon: SizedBox(
                  height: SizeConfig.heightMultiplier * 2.2,
                  child: SvgPicture.asset(
                    "assets/icons/Chat_icon.svg",
                    color: amigo_grey,
                  ),
                ),
              ),
            ],
          ),
          drawer: appDrawer(context),
          body: isLoading
              ? LoadingScreen()
              : SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
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
                                        builder: (context) => EditAccount(),
                                      ),
                                    );
                                  },
                                  child: Card(
                                    elevation: 10,
                                    child: Container(
                                      width: double.infinity,
                                      padding: EdgeInsets.symmetric(
                                        horizontal:
                                            SizeConfig.widthMultiplier * 4,
                                        vertical: SizeConfig.heightMultiplier,
                                      ),
                                      color: amigo_blue,
                                      child: Text(
                                        'Complete your profile ',
                                        style: regulartextstyle(
                                          SizeConfig.regulartextSize,
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
                          top: SizeConfig.heightMultiplier * 2.7,
                          bottom: SizeConfig.heightMultiplier,
                          left: SizeConfig.widthMultiplier * 2.7,
                          right: SizeConfig.widthMultiplier * 2.7,
                        ),
                        child: adBanners(),
                      ),

                      //  dot incdicator
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: adBannerLists.map((url) {
                          int index = adBannerLists.indexOf(url);
                          return Container(
                            width: SizeConfig.widthMultiplier * 4,
                            height: SizeConfig.heightMultiplier * 0.9,
                            margin: EdgeInsets.only(
                              bottom: SizeConfig.heightMultiplier * 1,
                            ),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: currentPos == index
                                  ? amigo_blue
                                  : Colors.grey.shade300,
                            ),
                          );
                        }).toList(),
                      ),

                      // talk to an expert
                      Padding(
                        padding: EdgeInsets.only(
                          top: SizeConfig.heightMultiplier,
                          bottom: SizeConfig.heightMultiplier,
                          left: SizeConfig.widthMultiplier * 2.7,
                          right: SizeConfig.widthMultiplier * 2.7,
                        ),
                        child: buildTalkToExpertCard(),
                      ),

                      // have a doubt card
                      Padding(
                        padding: EdgeInsets.only(
                          top: SizeConfig.heightMultiplier,
                          bottom: SizeConfig.heightMultiplier * 2,
                          left: SizeConfig.widthMultiplier * 2.7,
                          right: SizeConfig.widthMultiplier * 2.7,
                        ),
                        child: buildHaveADoubtCard(),
                      ),

                      // down grid
                      Padding(
                        padding: EdgeInsets.only(
                          top: SizeConfig.heightMultiplier,
                          bottom: SizeConfig.heightMultiplier,
                          left: SizeConfig.widthMultiplier * 2.7,
                          right: SizeConfig.widthMultiplier * 2.7,
                        ),
                        child:
                            listingOfCategories('', 'problem', totalGridToShow),
                      ),
                    ],
                  ),
                ),
        );
      },
    );
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
              padding: EdgeInsets.only(left: SizeConfig.widthMultiplier * 2),
              child: Text(
                "Talk to an expert",
                style: regulartextstyle(
                  SizeConfig.regulartextSize * 1.1,
                  amigo_black,
                  false,
                ),
              ),
            ),

            SizedBox(
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
                    SizeConfig.regulartextSize * 0.6,
                    amigo_blue,
                    false,
                  ),
                ),
              ),
            ),
          ],
        ),

        SizedBox(
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
                              SizeConfig.regulartextSize * 1.1,
                              amigo_black,
                              true,
                            ),
                          ),
                        ),

                        SizedBox(
                          width: 2,
                        ),
                        // experts images
                        SizedBox(
                          child: Image.asset("assets/images/expert_group.png"),
                          height: SizeConfig.heightMultiplier * 7,
                        ),
                      ],
                    ),

                    SizedBox(
                      height: SizeConfig.heightMultiplier * 3,
                    ),

                    // out button
                    Container(
                      width: double.infinity,
                      height: SizeConfig.heightMultiplier * 5.5,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                            amigo_blue,
                          ),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                SizeConfig.heightMultiplier * 5.5 * 0.5,
                              ),
                            ),
                          ),
                        ),
                        onPressed: () {},
                        child: Text(
                          "Get matched now!",
                          style: regulartextstyle(
                            SizeConfig.regulartextSize * 1.1,
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
          padding: EdgeInsets.only(left: SizeConfig.widthMultiplier * 2),
          child: Text(
            "Have any doubts?",
            textAlign: TextAlign.left,
            style: regulartextstyle(
              SizeConfig.regulartextSize * 1.1,
              amigo_black,
              false,
            ),
          ),
        ),

        SizedBox(
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
                        SizeConfig.regulartextSize * 1.1,
                        amigo_black,
                        true,
                      ),
                    ),

                    SizedBox(
                      width: 2,
                    ),

                    Text(
                      "We will help you get more clarity.",
                      style: regulartextstyle(
                        SizeConfig.regulartextSize * 0.9,
                        amigo_lightGrey,
                        true,
                      ),
                    ),

                    SizedBox(
                      height: SizeConfig.heightMultiplier * 3,
                    ),

                    // out button
                    Container(
                      width: double.infinity,
                      height: SizeConfig.heightMultiplier * 5.5,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                            amigo_white,
                          ),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                SizeConfig.heightMultiplier * 5.5 * 0.5,
                              ),
                              side: BorderSide(color: amigo_blue),
                            ),
                          ),
                        ),
                        onPressed: () {},
                        child: Text(
                          "Book a FREE call now",
                          style: regulartextstyle(
                            SizeConfig.regulartextSize * 1.1,
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

  openLink(String url) async {
    ApiService().logBannerClick(url);
    if (await canLaunch(url)) {
      await launch(url, forceWebView: false);
    } else {
      Navigator.pop(context);
      showNotificationDialog('Could not open browser\n:(', '', '', '', context);
    }
  }

  Widget adBanners() {
    return CarouselSlider.builder(
      itemCount: adBannerLists.length,
      itemBuilder: (BuildContext context, int index, int pageViewIndex) {
        return GestureDetector(
          onTap: () {
            openLink(adBannerLists[index].bannerLink);
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 7),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                boxShadow: const [
                  BoxShadow(
                    blurRadius: 7,
                    color: Colors.grey,
                  ),
                ],
                image: DecorationImage(
                  image: NetworkImage(adBannerLists[index].imgUrl),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
        );
      },
      options: CarouselOptions(
        height: SizeConfig.heightMultiplier * 20,
        viewportFraction: 1,
        initialPage: 0,
        enableInfiniteScroll: true,
        reverse: false,
        autoPlay: true,
        autoPlayInterval: Duration(seconds: 5),
        autoPlayAnimationDuration: Duration(milliseconds: 800),
        autoPlayCurve: Curves.fastOutSlowIn,
        enlargeCenterPage: true,
        scrollDirection: Axis.horizontal,
        padEnds: true,
        onPageChanged: (index, reason) {
          setState(() {
            currentPos = index;
          });
        },
      ),
    );
  }

  Widget listingOfCategories(
      String title, String titleOfCategory, int numberOfCards) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(
            left: SizeConfig.widthMultiplier,
            bottom: SizeConfig.heightMultiplier * 1.5,
          ),
          child: Text(
            "Topics",
            textAlign: TextAlign.left,
            style: regulartextstyle(
              SizeConfig.regulartextSize * 1.1,
              amigo_black,
              false,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: buildGridView(totalGridToShow, titleOfCategory),
        ),
        Padding(
          padding:
              EdgeInsets.symmetric(vertical: SizeConfig.heightMultiplier * 2.5),
          child: Center(
            child: Container(
              height: SizeConfig.heightMultiplier * 5.5,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                    amigo_white,
                  ),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        SizeConfig.heightMultiplier * 5.5 * 0.5,
                      ),
                      side: BorderSide(color: amigo_blue),
                    ),
                  ),
                ),
                onPressed: () {
                  setState(() {
                    if (showMoreTopics) {
                      showMoreTopics = false;
                      totalGridToShow = 4;
                    } else {
                      showMoreTopics = true;
                      totalGridToShow = 20;
                    }
                  });
                },
                child: Text(
                  showMoreTopics ? "Hide topics" : "Show more topics",
                  style: regulartextstyle(
                    SizeConfig.regulartextSize * 1.1,
                    amigo_blue,
                    false,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  GridView buildGridView(int numberOfCards, String titleOfCategory) {
    return GridView.count(
      shrinkWrap: true,
      crossAxisSpacing: SizeConfig.widthMultiplier * 6,
      mainAxisSpacing: SizeConfig.widthMultiplier * 4,
      physics: NeverScrollableScrollPhysics(),
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
            showNotificationDialog(
                listingNames[index], description, '', '', context);
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
            borderRadius: BorderRadius.circular(SizeConfig.widthMultiplier * 2),
            child: Image.asset(
              'assets/$titleOfCategory/${index - 3}.png',
              width: SizeConfig.widthMultiplier * 45,
              height: SizeConfig.widthMultiplier * 25,
            ),
          ),
        ),
      ),
    );
  }
}
