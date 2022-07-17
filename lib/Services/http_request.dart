// ignore_for_file: avoid_print, unused_local_variable

import 'dart:convert';

import 'package:http/http.dart';
import '../Constants/constants.dart';

loginUser(email, password) async {
  final uri =
      Uri.parse('https://doctorapi.simulacratech.in/api/cockpit/authUser');
  final headers = {
    'Content-Type': 'application/json',
<<<<<<< HEAD
    'Authorization': 'Bearer $c.token',
=======
    'authorization': ' Bearer $Constants.token',
>>>>>>> 9d982efb23cd642047fab4ad80661954ad1ed7ca
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
