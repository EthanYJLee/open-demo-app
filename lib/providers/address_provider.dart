import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/address_service.dart';

// 시/도 데이터 프로바이더
final citiesProvider = FutureProvider<List<String>>((ref) async {
  final citiesData = await AddressService.getCitiesData();
  return citiesData.keys.toList();
});

// 선택된 시/도 프로바이더
final selectedCityProvider = StateProvider<String?>((ref) => null);

// 선택된 시/도에 따른 구/군 목록 프로바이더
final districtsProvider =
    FutureProvider.family<List<String>, String?>((ref, city) async {
  if (city == null) return [];
  final citiesData = await AddressService.getCitiesData();
  return citiesData[city] ?? [];
});

// 선택된 구/군 프로바이더
final selectedDistrictProvider = StateProvider<String?>((ref) => null);
