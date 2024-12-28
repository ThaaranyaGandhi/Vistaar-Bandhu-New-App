import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get_ip_address/get_ip_address.dart';
import 'package:vistaar_bandhu_new_version/base/base_provider.dart';
import 'package:vistaar_bandhu_new_version/models/customer_model.dart';
import 'package:vistaar_bandhu_new_version/service/api_methods.dart';
import 'package:vistaar_bandhu_new_version/service/url_constants.dart';
import 'package:vistaar_bandhu_new_version/util/app_message.dart';
import 'package:http/http.dart' as http;
import 'package:xml2json/xml2json.dart';

class AuthProvider extends BaseProvider {
  Future<MyCustomerModel?> userLogin(String mobileNumber) async {
    super.isLoading = true;
    String envelope = '''
<?xml version="1.0" encoding="utf-8"?>
<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ser="http://service.indus.com/">
   <soapenv:Header/>
   <soapenv:Body>
      <ser:getApplication>
         <mobileNumber>$mobileNumber</mobileNumber>
      </ser:getApplication>
   </soapenv:Body>
</soapenv:Envelope>
''';

    http.Response response = await http.post(Uri.parse(apiLogin ?? ""),
        headers: {
          'Content-Type': 'application/xml',
          // 'SOAPAction': 'AuthenticateCredential'
        },
        body: envelope);

    if (response.statusCode == 200) {
      var rawXmlResponse = response.body;
      Xml2Json xml2json = new Xml2Json(); //Make an instance.
      xml2json.parse(rawXmlResponse);
      var jsonData = xml2json.toGData();

      var split = jsonDecode(jsonData)["soap\$Envelope"]["soap\$Body"]
          ['ns2\$getApplicationResponse']['output']['data']['\$t'];

      try {
        // split = split.toString().replaceAll("\"{", "{");
        // split = split.toString().replaceAll("\"}", "}");

        Map<String, dynamic> response = jsonDecode(split);

        if (response["applicationReference"] is String) {
          var applicationReference =
              castOrNull<String>(response["applicationReference"]);
          if (applicationReference!.toLowerCase() ==
              "No response".toLowerCase()) {
            showErrorToast("Your number is not registered");
          }
        } else {
          super.isLoading = false;
          return MyCustomerModel.fromJson(response);
        }
        // appLogger(split);
        return null;
      } catch (e) {
        super.isLoading = false;
        print(e);
      }
    } else {
      super.isLoading = false;
      showErrorToast('${response.statusCode} - ${response.reasonPhrase} ');
      // appLogger("${response.statusCode} ${response.body}");
    }
    super.isLoading = false;
    return null;
  }

  Future<int?> otpVerification(mobileNumberFromLogin) async {
    Map<dynamic, dynamic> input = Map();
    input['Mobile'] = '$mobileNumberFromLogin';
    input['Token'] = API_TOKEN;
    final response = await apiClient.apiClient(
        path: API_OTP, method: ApiMethod.POST, body: input);
    return response.fold((l) {
      showErrorToast(l);
      return null;
    }, (r) {
      super.isLoading = false;
      final response = jsonDecode(r);
      return response["d"];
    });
  }

  Future<String?> addAppKey(Map body) async {
    final response = await apiClient.apiClient(
        path: appKeyMapping, method: ApiMethod.POST, body: body);
    return response.fold((l) {
      showErrorToast(l);
      return null;
    }, (r) {
      super.isLoading = false;
      final response = jsonDecode(r);
      return response["d"];
    });
  }

  Future<String?> getIpAddress() async {
    try {
      var ipAddress = IpAddress(type: RequestType.json);
      dynamic data = await ipAddress.getIpAddress();
      return data["ip"];
    } on IpAddressException catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  Future<List<dynamic>?> getLoanDetail(String applicationNumber) async {
    super.isLoading = true;
    String envelope = '''
<?xml version="1.0" encoding="utf-8"?>
<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ser="http://service.indus.com/">
   <soapenv:Header/>
   <soapenv:Body>
      <ser:getPopSearchData>
         <searchRequest>{"authentication":{"username":"14465","platform":"Android","appid":"LEAD_VIS","appversion":"3.1.13.0.0.50","deviceid":"2e1c7516e937763d","token":"WB0YvC6UvI7ZWiLInonOHNuse+0Pa5EVWzlErcNhe9W1x4idnmesjPcXxenZxaH93puXMGoI3NqD+k4zcir+CpWQhrP1luZHhLvo7Rop0J1xRBihMfxKeMBBkqWv/G0vsYufWV5+wIYn7ezit4H+Vr/EqR2J4kVYweZSkQAOR/Kql8YB271UivBffbsFAo2me/VNGI8qtLmjx2Zzfxzy8RLaEYbjzj+/3SRtupq7Si3W8YWkFkVn9gpx87N6Ts6ci+X45+2J5XUqlgq+H4zT8bfHscpyx/rKTjxIIeWPASd5xei2VOKbu8uP3b3WMWo7/Fn7ocZLfoI+l0DlhXdFMw==","releaseVersion":"1.0","masterdataVersion":"00000000000000"},"applications":[{"tabs":[{"tabid":"lms_view_TB","tabseq":"-1","subtabs":[{"subtabid":"lms_view_ST0","subtabseq":"-1","fields":{"Acc_no":"$applicationNumber"}}]}],"uid":"60c351cf-4669-48c8-b060-e1875b9f3e6f","applicantid":"1","screenid":"lms_view","searchType":"lms_view.lms_view_TB.lms_view_ST0.btn_Search"}]}</searchRequest>
      </ser:getPopSearchData>
   </soapenv:Body>
</soapenv:Envelope>
''';

    http.Response response = await http.post(Uri.parse(apiLoanDetails),
        headers: {
          'Content-Type': 'text/xml; charset=utf-8',
          'SOAPAction': 'AuthenticateCredential'
        },
        body: envelope);

    if (response.statusCode == 200) {
      var rawXmlResponse = response.body;
      Xml2Json xml2json = new Xml2Json(); //Make an instance.
      xml2json.parse(rawXmlResponse);
      var jsonData = xml2json.toGData();
      var split = jsonDecode(jsonData)["soap\$Envelope"]["soap\$Body"]
          ['ns2\$getPopSearchDataResponse']['return']['\$t'];
      // debugPrint("jsonData: $jsonData");
      // debugPrint(" split: $split");

      try {
        // split = split.toString().replaceAll("\"{", "{");
        // split = split.toString().replaceAll("\"}", "}");
        Map<String, dynamic> response = jsonDecode(split);
        if (response["response"] is Map<String, dynamic>) {
          Map<String, dynamic> responseJson = response["response"];
          List<dynamic> applications = responseJson["applications"];
          return applications;
        }
        // appLogger(split);
        return null;
      } catch (e) {
        print(e);
      }
    } else {
      showErrorToast('${response.statusCode} - ${response.reasonPhrase}');
      return null;
    }
    super.isLoading = false;
    return null;
  }

  Future<Map<String, dynamic>?> getLoanStatus(String applicationNumber) async {
    super.isLoading = true;
    String envelope = '''
<?xml version="1.0" encoding="utf-8"?>
<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ser="http://service.indus.com/">
   <soapenv:Header/>
   <soapenv:Body>
      <ser:getApplicationDtl>
         <applNumber>$applicationNumber</applNumber>
      </ser:getApplicationDtl>
   </soapenv:Body>
</soapenv:Envelope>
''';
    http.Response response = await http.post(Uri.parse(apiLogin ?? ""),
        headers: {
          'Content-Type': 'text/xml; charset=utf-8',
          'SOAPAction': 'AuthenticateCredential'
        },
        body: envelope);

    if (response.statusCode == 200) {
      var rawXmlResponse = response.body;
      Xml2Json xml2json = new Xml2Json(); //Make an instance.
      xml2json.parse(rawXmlResponse);
      var jsonData = xml2json.toGData();

      var split = jsonDecode(jsonData)["soap\$Envelope"]["soap\$Body"]
          ['ns2\$getApplicationDtlResponse']['output']['data']['\$t'];

      try {
        // split = split.toString().replaceAll("\"{", "{");
        // split = split.toString().replaceAll("\"}", "}");
        // appLogger(split);
        Map<String, dynamic> response = jsonDecode(split);
        return response;
      } catch (e) {
        print(e);
      }
    } else {
      showErrorToast('${response.statusCode} - ${response.reasonPhrase}');
      return null;
    }
    super.isLoading = false;
    return null;
  }

  Future<dynamic> referFriends(Map<String, dynamic> body) async {
    apiClient
        .apiClient(path: apiReferFriends, method: ApiMethod.POST, body: body)
        .then((value) {
      debugPrint("refer friend => $value");
    });
  }

  clearUserData() {
    pref.userName = "";
    pref.userMobile = "";
  }

  T? castOrNull<T>(dynamic x) => x is T ? x : null;
}
