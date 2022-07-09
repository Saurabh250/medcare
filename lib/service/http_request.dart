import 'dart:convert';

import 'package:medcare/constants/constants.dart';
import 'package:http/http.dart';

Constants c = Constants();
loginUser(email, password) async {
  final uri =
      Uri.parse('https://doctorapi.simulacratech.in/api/cockpit/authUser');
  final headers = {
    'Content- Type': 'application/json',
    'Authorization': 'Bearer $c.token',
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
