import 'dart:convert';
import 'package:vistaar_bandhu_new_version/base/base_provider.dart';
import 'package:vistaar_bandhu_new_version/environment.dart';
import 'package:vistaar_bandhu_new_version/models/enach_detail_model.dart';
import 'package:vistaar_bandhu_new_version/models/enach_status_model.dart';
import 'package:vistaar_bandhu_new_version/service/api_methods.dart';
import 'package:vistaar_bandhu_new_version/service/url_constants.dart';
import 'package:vistaar_bandhu_new_version/util/app_logger.dart';
import 'package:vistaar_bandhu_new_version/util/app_message.dart';

class EnachProvider extends BaseProvider {
  Future<EnachDetailsModel?> getEnachDetails(Map<String, dynamic> body) async {
    final response = await apiClient.apiClient(
        path: apiGetENachDetails, method: ApiMethod.POST, body: body);
    return response.fold((l) {
      showErrorToast(l);
    }, (r) {
      super.isLoading = false;
      final response = jsonDecode(r);
      appLogger(Environment().config?.envParam, 'logger response $response');

      if (response != null) {
        if (response['d'] != null) {
          super.isLoading = false;
          return EnachDetailsModel.fromJson(response);
        } else {
          super.isLoading = false;
          return null;
        }
      } else {
        super.isLoading = false;
        return null;
      }
    });
  }

  Future<EnachStatusModel?> getEnachStatus(Map<String, dynamic> body) async {
    final response = await apiClient.apiClient(
        path: apiGetEnachStatus, method: ApiMethod.POST, body: body);
    return response.fold((l) {
      showErrorToast(l);
    }, (r) {
      super.isLoading = false;
      final response = jsonDecode(r);
      appLogger(Environment().config?.envParam, 'logger response $response');

      if (response != null) {
        super.isLoading = false;
        return EnachStatusModel.fromJson(response);
      } else {
        super.isLoading = false;
        return null;
      }
    });
  }
}
