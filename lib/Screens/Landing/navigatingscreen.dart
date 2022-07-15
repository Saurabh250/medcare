import 'package:medcare/Services/api_service.dart';
import 'package:medcare/Utils/color_constants.dart';
import 'package:medcare/Utils/constant_components.dart';
import 'package:medcare/Utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

import '../../home_page.dart';
import '../Dashboard/dashboard.dart';
import '../Journal/journalpage.dart';

class NavigatingScreen extends StatefulWidget {
  final int index;
  const NavigatingScreen({Key? key, required this.index}) : super(key: key);

  @override
  _NavigatingScreenState createState() => _NavigatingScreenState();
}

PersistentTabController _persistentTabController =
    _persistentTabController.jumpToTab(0);
int indexGlobal = 0;
void selindex(int index) {
  _persistentTabController.jumpToTab(index);
}

class _NavigatingScreenState extends State<NavigatingScreen> {
  List<Widget> bodyList = [const HomePage(), JournalPage(), Dashboard()];
  List<String> appbartitles = ['Home', 'Journal', 'Dashboard'];
  bool newUpdate = false;

  getAppUpdate() async {}

  @override
  void initState() {
    super.initState();
    getAppUpdate();
  }

  @override
  Widget build(BuildContext context) {
    // ApiService().getAppUpdate();

    _persistentTabController =
        PersistentTabController(initialIndex: widget.index);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: PersistentTabView(
        context,
        controller: _persistentTabController,
        navBarHeight: SizeConfig.heightMultiplier! * 7,
        screens: bodyList,
        confineInSafeArea: true,
        handleAndroidBackButtonPress: true,
        resizeToAvoidBottomInset: true,
        hideNavigationBarWhenKeyboardShows: true,
        popAllScreensOnTapOfSelectedTab: true,
        popActionScreens: PopActionScreensType.all,
        stateManagement: false,
        navBarStyle: NavBarStyle.style13,
        onItemSelected: (int index) {
          setState(() {
            _persistentTabController.index = index;
          });
        },
        decoration: const NavBarDecoration(boxShadow: [
          BoxShadow(color: amigo_backgroundLightGrey, spreadRadius: 2.0)
        ]),
        items: [
          PersistentBottomNavBarItem(
              title: 'Home',
              textStyle: regulartextstyle(
                  SizeConfig.regulartextSize! * 0.8, amigo_blue, false),
              icon: navBarIcons(Icons.home),
              activeColorPrimary: amigo_grey,
              activeColorSecondary: amigo_blue,
              inactiveColorPrimary: amigo_grey.withOpacity(0.5)),
          PersistentBottomNavBarItem(
              title: 'Journal',
              textStyle: regulartextstyle(
                SizeConfig.regulartextSize! * 0.8,
                amigo_blue,
                false,
              ),
              icon: navBarIcons(Icons.calendar_today),
              //icon: navBarIcons(Icons.home),
              activeColorPrimary: amigo_grey,
              activeColorSecondary: amigo_blue,
              inactiveColorPrimary: amigo_grey.withOpacity(0.5)),
          PersistentBottomNavBarItem(
            title: 'Dashboard',
            textStyle: regulartextstyle(
              SizeConfig.regulartextSize! * 0.8,
              amigo_blue,
              false,
            ),
            icon: navBarIcons(Icons.person),
            activeColorPrimary: amigo_grey,
            activeColorSecondary: amigo_blue,
            inactiveColorPrimary: amigo_grey.withOpacity(0.5),
          ),
        ],
      ),
    );
  }
}
