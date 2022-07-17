// ignore_for_file: must_be_immutable

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Models/userdetail.dart';
import 'Screens/Auth/loginScreen.dart';
import 'Screens/Landing/navigatingscreen.dart';

class Wrapper extends StatelessWidget {
  int index;
  bool authPage = true, f = true;

  Wrapper({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    UserDetail user = Provider.of<UserDetail>(context);
    log(user.toString());

    if (f == true) {
      if (user == null) {
        return LoginScreen();
      } else {
        //DatabaseService().postRegistrationToken();
        return NavigatingScreen(
          index: index,
        );
      }
    } else {
      //DatabaseService().postRegistrationToken();
      return NavigatingScreen(
        index: index,
      );
    }
  }
}
