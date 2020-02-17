import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'dart:convert';

Future<String> void_getJWT() async {
  final authJwt = await SharedPreferences.getInstance();
  String jwt = authJwt.getString("jwt");
  return jwt;
}

Future<String> void_getID() async {
  final authid = await SharedPreferences.getInstance();
  String id = authid.getString("id");
  return id;
}


Future<String> getUser() async {
  final authJwt = await SharedPreferences.getInstance();
  String username = authJwt.getString("username");
  return username;
}
