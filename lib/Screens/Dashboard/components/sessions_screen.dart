import 'package:amigoapp/Services/auth.dart';
import 'package:flutter/material.dart';

class SessionsScreen extends StatefulWidget {
  const SessionsScreen({Key key}) : super(key: key);

  @override
  _SessionsScreenState createState() => _SessionsScreenState();
}

class _SessionsScreenState extends State<SessionsScreen> {
  String userid;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    userid = AuthServices().returnUserUID();
    return Container();
  }
}
