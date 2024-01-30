import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

import 'cache_storage.dart';

class CacheStorageImpl implements CacheStorage {
  CacheStorageImpl(this.prefs);

  final SharedPreferences prefs;

  @override
  Future<bool> setString(String key, String value) async {
    return await prefs.setString(key, value);
  }

  @override
  String? getString(String key) {
    return prefs.getString(key);
  }

  @override
  Future<bool> setBool(String key, bool value) async {
    return await prefs.setBool(key, value);
  }

  @override
  bool? getBool(String key) {
    return prefs.getBool(key);
  }

  @override
  Future<bool> setInt(String key, int value) async {
    return await prefs.setInt(key, value);
  }

  @override
  int? getInt(String key) {
    return prefs.getInt(key);
  }

  @override
  Future<bool> setDouble(String key, double value) async {
    return await prefs.setDouble(key, value);
  }

  @override
  double? getDouble(String key) {
    return prefs.getDouble(key);
  }

  @override
  Future<bool> setStringList(String key, List<String> value) async {
    return await prefs.setStringList(key, value);
  }

  @override
  List<String>? getStringList(String key) {
    return prefs.getStringList(key);
  }

  @override
  Future<bool> remove(String key) async {
    return await prefs.remove(key);
  }

  @override
  Future<bool> clearAllCache() async {
    return await prefs.clear();
  }
}
