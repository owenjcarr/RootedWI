import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


Future<http.Response> getProduceFuture() {
  String base =
      '10.0.2.2:8000'; //@TODO: figure out what to change this to in production
  return http.get(Uri.http(base, 'api/produce'), headers: <String, String>{
    'Content-Type': 'application/json; charset=UTF-8',
  });
}

int getBalance(http.Response response) {
  Map<String, dynamic> responseJson = jsonDecode(response.body);
  int balance = responseJson['balance'];
  debugPrint(balance.toString());
  return balance;
}

Future<http.Response> getBalanceFuture() {
  String base =
      '10.0.2.2:8000'; //@TODO: figure out what to change this to in production
  return http
      .get(Uri.http(base, 'api/balance/John Doe'), headers: <String, String>{
    'Content-Type': 'application/json; charset=UTF-8',
  });
}