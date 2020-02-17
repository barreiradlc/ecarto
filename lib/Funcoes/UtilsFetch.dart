import 'package:e_carto/Recursos/Api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';


  


// Future<String> contatarAutor(id) async {
//       print(id.toString());

//       Dio dio = new Dio();
//       // dio.options.headers['content-Type'] = 'application/json';
//       dio.options.headers["authorization"] = jwt;
//       // dio.options.headers["authorization"] = "token ${token}";
//       var response = await dio.get(host + '/usuario/' + id.toString());
//       // print(response);
//       print('response.data');
//       print(response.data);
//       print('response.data');
    
//       // var response = await http.get(Uri.encodeFull(host + '/usuario/' + id.toString()),
//       //     headers: {"Authorization": jwt});

//       // var response = await http.get(Uri.encodeFull(host + '/usuario/' + id.toString()),
//       //   headers: {"Authorization": jwt});

//       // Response response;
//       // Dio dio = new Dio();
//       // response = await dio.get("/test?id=12&name=wendu");
//       // print(response.data.toString());
// // Optionally the request above could also be done as
//       // response =
//       //     await dio.get("/test", queryParameters: {"id": 12, "name": "wendu"});
//       // print(response.data.toString());

//       // print(jsonDecode(response.body));
//       // print(response.body);

//       // setState(() {
//       //   autor = jsonDecode(response.body);
//       // });

//       // print(response.body);

//       // alertAutor();

//       // return "Sucesso";
//     }
