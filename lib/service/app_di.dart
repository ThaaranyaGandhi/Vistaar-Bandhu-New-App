import 'package:get_it/get_it.dart';
import 'package:vistaar_bandhu_new_version/storage/app_pref.dart';
import 'package:vistaar_bandhu_new_version/util/app_helper.dart';

import 'api_client.dart';

final getIt = GetIt.instance;

Future<void> setupDI() async {
  var instance = await AppSharedPref.getInstance();
  getIt.registerSingleton<AppSharedPref>(instance);
  getIt.registerSingleton(ApiClient());
  var appHelper = await AppHelper.getInstance();
  getIt.registerSingleton(appHelper);
}
