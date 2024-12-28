import 'dart:convert';
import 'package:vistaar_bandhu_new_version/base/base_provider.dart';
import 'package:vistaar_bandhu_new_version/models/pvl_offer_model.dart';
import 'package:vistaar_bandhu_new_version/service/api_methods.dart';
import 'package:vistaar_bandhu_new_version/service/url_constants.dart';
import 'package:vistaar_bandhu_new_version/util/app_logger.dart';
import 'package:vistaar_bandhu_new_version/util/app_message.dart';

import '../environment.dart';

class PvlProvider extends BaseProvider {
  Future<PvlOfferModel?> getPvlList(Map<String, dynamic> body) async {
    final response = await apiClient.apiClient(
        path: apiGetPVLOffers, method: ApiMethod.POST, body: body);
    return response.fold((l) {
      super.isLoading = false;
      showErrorToast(l);

    }, (r) {
      super.isLoading = false;
      final response = jsonDecode(r);
      appLogger(
          Environment().config?.envParam, 'logger response post $response');
      if (response != null) {
        return PvlOfferModel.fromJson(response);
      } else {
        return null;
      }
    });
  }

  Future<dynamic> postCustomerInterest(Map<String, dynamic> body) async {
    apiClient
        .apiClient(
            path: apiUpdatePVLConsent, method: ApiMethod.POST, body: body)
        .then((value) {});
  }
}
