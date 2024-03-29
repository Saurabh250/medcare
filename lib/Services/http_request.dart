// ignore_for_file: avoid_print, unused_local_variable

import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart';
import 'package:medcare/constants/constants.dart';

String token = Constants.token;
late int statusCode;
late int nospecialist;
late String specialistresponse;
late int nohospital;
late String hospitalresponse;

loginUser(email, password) async {
  final uri =
      Uri.parse('https://doctorapi.simulacratech.in/api/cockpit/authUser');
  final headers = {
    'Content-Type': 'application/json',
    'authorization': 'Bearer $token',
  };
  Map<String, dynamic> body = {"user": "$email", "password": "$password"};
  String jsonBody = json.encode(body);
  log(headers.toString());
  log(jsonBody);
  final encoding = Encoding.getByName('utf-8');

  Response response = await post(
    uri,
    headers: headers,
    body: jsonBody,
  );
  log(response.toString());

  statusCode = response.statusCode;
  log(statusCode.toString());
  print(json.decode(response.body));
  print("fgfghfhg" + statusCode.toString());
  //return statusCode.toString();
}

mess() {
  return statusCode;
}

specialist() async {
  final uri = Uri.parse(
      'https://doctorapi.simulacratech.in/api/collections/get/Specialities');
  final headers = {
    'Content-Type': 'application/json',
    'authorization': 'Bearer $token',
  };
  final encoding = Encoding.getByName('utf-8');

  Response response = await post(
    uri,
    headers: headers,
  );
  int statusCode = response.statusCode;
  specialistresponse = response.body;
  //print(json.decode(specialistresponse)["entries"][0]["name"]);
  nospecialist = json.decode(specialistresponse)["total"];
  //print(nospecialist);
}

hospitals() async {
  final uri = Uri.parse(
      'https://doctorapi.simulacratech.in/api/collections/get/Hospitals');
  final headers = {
    'Content-Type': 'application/json',
    'authorization': 'Bearer $token',
  };
  final encoding = Encoding.getByName('utf-8');

  Response response = await post(
    uri,
    headers: headers,
  );
  int statusCode = response.statusCode;
  hospitalresponse = response.body;
  print(json.decode(hospitalresponse));
  print(json.decode(hospitalresponse)["entries"][0]["name"]);
  print(json.decode(hospitalresponse)["entries"][0]["phone"]);
  print(json.decode(hospitalresponse)["entries"][0]["address"]);
  print(json.decode(hospitalresponse)["entries"][0]["pricing"]);
  print(json.decode(hospitalresponse)["entries"][0]["rating"]);
  print(json.decode(hospitalresponse)["entries"][0]["Beds"]);
  nohospital = json.decode(hospitalresponse)["total"];
  print(nohospital);
}
