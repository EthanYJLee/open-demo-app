import 'dart:convert';
import 'package:flutter/services.dart';

class AddressService {
  static Map<String, List<String>>? _citiesData;

  static Future<Map<String, List<String>>> getCitiesData() async {
    if (_citiesData != null) {
      return _citiesData!;
    }

    try {
      final String jsonString =
          await rootBundle.loadString('assets/data/korean_addresses.json');
      final Map<String, dynamic> jsonData = json.decode(jsonString);
      final Map<String, dynamic> rawCities = jsonData['cities'];
      _citiesData = rawCities
          .map((key, value) => MapEntry(key, List<String>.from(value)));
      return _citiesData!;
    } catch (e) {
      print('Error loading address data: $e');
      return {};
    }
  }

  static List<String> getCities() {
    if (_citiesData == null) return [];
    return _citiesData!.keys.toList();
  }

  static List<String> getDistricts(String city) {
    if (_citiesData == null) return [];
    return _citiesData![city] ?? [];
  }
}
