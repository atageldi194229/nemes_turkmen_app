import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:nemes/data/models/app_data_model.dart';

class AppRepository {
  AppRepository._constructor();
  static final AppRepository _instance = AppRepository._constructor();
  factory AppRepository() => _instance;

  Future<Map<String, dynamic>> _readAppJsonData() async {
    const jsonPath = "assets/data.json";
    final String response = await rootBundle.loadString(jsonPath);
    final data = await json.decode(response);
    return data;
  }

  Future<AppDataModel> getAppData() async {
    final data = await _readAppJsonData();
    return AppDataModel.fromMap(data);
  }
}
