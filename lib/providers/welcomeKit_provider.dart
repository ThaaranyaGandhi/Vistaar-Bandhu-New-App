import 'dart:convert';

import 'package:vistaar_bandhu_new_version/base/base_provider.dart';
import 'package:vistaar_bandhu_new_version/models/WhatsappModel.dart';
import 'package:vistaar_bandhu_new_version/service/api_methods.dart';
import 'package:vistaar_bandhu_new_version/service/url_constants.dart';
import 'package:vistaar_bandhu_new_version/util/app_message.dart';

class WelcomeKitProvider extends BaseProvider {
  Future<WhatsappModel?> getWhatsappMessageStatus(
      Map<String, dynamic> body) async {
    final response = await apiClient.apiClient(
        path: whatsappUrl, method: ApiMethod.POST, body: body);
    return response.fold((l) {
      showErrorToast(l);
    }, (r) {
      super.isLoading = false;
      final response = jsonDecode(r);
      if (response != null) {
        return WhatsappModel.fromJson(response);
      }
      return null;
    });
  }
}
