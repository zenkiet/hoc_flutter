import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LoginService {
  bool isloading = false;
  setLoadingTrue() {
    isloading = true;
    // notifyListeners();
  }

  setLoadingFalse() {
    isloading = false;
    // notifyListeners();
  }

  // Future<bool> login(email, pass, BuildContext context, bool keepLoggedIn,
  //     {isFromLoginPage = true}) async {}
}
