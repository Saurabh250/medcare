// ignore_for_file: avoid_print, unused_local_variable

import 'dart:convert';

import 'package:http/http.dart';
import '../Constants/constants.dart';

loginUser(email, password) async {
  final uri =
      Uri.parse('https://doctorapi.simulacratech.in/api/cockpit/authUser');
  final headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $Constants.token',
  };
  Map<String, dynamic> body = {'user': email, 'password': password};
  String jsonBody = json.encode(body);
  final encoding = Encoding.getByName('utf-8');

  Response response = await post(
    uri,
    headers: headers,
    body: jsonBody,
    encoding: encoding,
  );

  int statusCode = response.statusCode;
  print(json.decode(response.body));
}
