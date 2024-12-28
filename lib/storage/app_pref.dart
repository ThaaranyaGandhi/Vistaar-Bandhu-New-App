import 'dart:convert';

import 'package:encrypt/encrypt.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vistaar_bandhu_new_version/storage/pref_constants.dart';

class AppSharedPref {
  static AppSharedPref? _instance;
  static SharedPreferences? _preferences;
  final key = Key.fromUtf8('akjnoivak101935naoigadjaafafd2f3');
  final iv = IV.fromLength(16);
  Encrypter? encrypter;

  AppSharedPref() {
    encrypter = Encrypter(AES(key));
  }

  static Future<AppSharedPref> getInstance() async {
    if (_instance == null) {
      _instance = AppSharedPref();
    }
    if (_preferences == null) {
      _preferences = await SharedPreferences.getInstance();
    }
    return _instance!;
  }

  void _saveToDisk<T>(String key, T content) {
    if (content is String) {
      _preferences!.setString(key, content);
    }
    if (content is bool) {
      _preferences!.setBool(key, content);
    }
    if (content is int) {
      _preferences!.setInt(key, content);
    }
    if (content is double) {
      _preferences!.setDouble(key, content);
    }
    if (content is List<String>) {
      _preferences!.setStringList(key, content);
    }
  }

  dynamic _getFromDisk(String key) {
    var value = _preferences!.get(key);
    return value;
  }

  clear() {
    _preferences!.clear();
  }

  String get token => _getFromDisk(PREF_ACCESS_TOKEN);

  set token(String userToken) => _saveToDisk(PREF_ACCESS_TOKEN, userToken);

  String get userMobile {
    var token = _getFromDisk(PREF_USER_MOBILE);
    if (token == null) {
      return '';
    }
    return token;
  }

  set userMobile(String mobile) => _saveToDisk(PREF_USER_MOBILE, mobile);

  String get userName {
    var token = _getFromDisk(PREF_USER_NAME);
    if (token == null) {
      return '';
    }
    return token;
  }

  set userName(String name) => _saveToDisk(PREF_USER_NAME, name);

  String get emandateStatus {
    var token = _getFromDisk(EMANDATE_UPDATED);
    if (token == null) {
      return '';
    }
    return token;
  }

  set emandateStatus(String name) => _saveToDisk(EMANDATE_UPDATED, name);

  int get interested {
    var token = _getFromDisk(INTEREST);
    if (token == null) {
      return 0;
    }
    return token;
  }

  set interested(int interest) => _saveToDisk(INTEREST, interest);

  List<String> get messageSent {
    var token = _getFromDisk(SENT_LIST);
    if (token == null) {
      return [];
    }
    return token;
  }

  set messageSent(List<String> status) => _saveToDisk(SENT_LIST, status);

  String get storeDate {
    var token = _getFromDisk(DATE);
    if (token == null) {
      return '';
    }
    return token;
  }

  set storeDate(String status) => _saveToDisk(DATE, status);
}
