import 'dart:convert';

import 'package:ShopApp/models/httpexception.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Auth with ChangeNotifier {
  String _token;
  DateTime _expiryDate;
  String _userId;

  bool get isAuth {
    if (token != null) {
      return true;
    } else {
      return false;
    }
  }

  String get token {
    if (_expiryDate != null &&
        _token != null &&
        _expiryDate.isAfter(DateTime.now())) {
      return _token;
    } else {
      return null;
    }
  }

  Future<Exception> autheticate(
      String username, String password, String url) async {
    try {
      final response = await http.post(
          "https://identitytoolkit.googleapis.com/v1/accounts:$url?key=AIzaSyC8Cn61t-ou6LJzElqAVnPRvUicL9i_iBw",
          headers: {'Content-Type': "application/json"},
          body: json.encode({
            "email": username,
            "password": password,
            "returnSecureToken": true
          }));
      final responseData = json.decode(response.body);
      print(responseData);
      if (responseData["error"] != null) {
        print("Exception");
        // print(responseData["error"]["message"]);
        throw HttpException(responseData["error"]["message"]);
      }

      _token = responseData["idToken"];
      _userId = responseData['localId'];
      _expiryDate = DateTime.now().add(Duration(seconds:int.parse(responseData["expiresIn"]) ));

    } catch (error) {
      throw error;
    }
    notifyListeners();
    //  print(json.decode(response.body));
  }

  // Future<void> signUp(String username, String password) async {
  //   final response = await http.post("https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyC8Cn61t-ou6LJzElqAVnPRvUicL9i_iBw",headers: {'Content-Type' :  "application/json"} ,body: json.encode({"email" : username , "password" : password , "returnSecureToken" : true}));
  //   print(json.decode(response.body));
  // }

  // Future<void> Login(String username , String password) async {
  //    final response = await http.post("https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=AIzaSyC8Cn61t-ou6LJzElqAVnPRvUicL9i_iBw",headers: {'Content-Type' :  "application/json"} ,body: json.encode({"email" : username , "password" : password , "returnSecureToken" : true}));
  // }

  Future signUp(String username, String password) async {
    return autheticate(username, password, "signUp");
    // print(json.decode(response.body));
  }

  Future logIn(String username, String password) async {
    return autheticate(username, password, "signInWithPassword");
  }
}
