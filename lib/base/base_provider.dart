
import 'package:flutter/cupertino.dart';
import 'package:vistaar_bandhu_new_version/service/api_client.dart';
import 'package:vistaar_bandhu_new_version/service/app_di.dart';
import 'package:vistaar_bandhu_new_version/storage/app_pref.dart';

class BaseProvider extends ChangeNotifier {
  ApiClient apiClient = getIt<ApiClient>();
  AppSharedPref pref = getIt<AppSharedPref>();

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}
