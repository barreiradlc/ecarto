import '../Recursos/Api.dart';

import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
  // print(host);

Future<http.Response> fetchPost() async {
  http.Response response = await http.get('https://jsonplaceholder.typicode.com/posts/1');
  print('response');
  print(response);

  return response;
}


// Future<http.Response> fetchPost() async {
//   final http.Response response = await http.get('https://jsonplaceholder.typicode.com/posts/1');

//   if (response.statusCode == 200) {
//     // If the call to the server was successful, parse the JSON.
//     // print(response);
//     return json.decode(response.body);
//   } else {
//     // If that call was not successful, throw an error.
//     throw Exception('Failed to load post');
//   }
// }

