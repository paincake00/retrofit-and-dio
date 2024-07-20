import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:retrofit_package/service/api_service.dart';

class ApiProvider with ChangeNotifier {
  late ApiService _retrofitClient;
  late Dio _dioClient;

  ApiService get retrofitClient => _retrofitClient;
  Dio get dio => _dioClient;

  void setRetrofit(ApiService retrofitClient) {
    _retrofitClient = retrofitClient;
    notifyListeners();
  }

  void setDio(Dio dioClient) {
    _dioClient = dioClient;
    notifyListeners();
  }
}
