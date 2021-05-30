import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


const String base = "rootedwi-app.herokuapp.com";
Future<http.Response> getProduceFuture() {
  return http.get(Uri.http(base, 'api/produce'), headers: <String, String>{
    'Content-Type': 'application/json; charset=UTF-8',
  });
}

int getBalance(http.Response response) {
  Map<String, dynamic> responseJson = jsonDecode(response.body);
  int balance = responseJson['balance'];
  return balance;
}

String getName(http.Response response) {
  Map<String, dynamic> responseJson = jsonDecode(response.body);
  String name = responseJson['name'];
  return name;
}

Future<http.Response> getBalanceFuture(String email) {
  return http
      .get(Uri.http(base, 'api/balance/$email'), headers: <String, String>{
    'Content-Type': 'application/json; charset=UTF-8',
  });
}