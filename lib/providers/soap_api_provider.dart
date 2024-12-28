import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:vistaar_bandhu_new_version/base/base_provider.dart';
import 'package:vistaar_bandhu_new_version/service/url_constants.dart';
import 'package:vistaar_bandhu_new_version/util/app_logger.dart';
import 'package:vistaar_bandhu_new_version/util/app_message.dart';
import 'package:xml2json/xml2json.dart';

import '../environment.dart';

class SoapApiProvider extends BaseProvider {
  Future<void> userLogin(String mobileNumber) async {
    super.isLoading = true;
    String envelope = '''
<?xml version="1.0" encoding="utf-8"?>
<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ser="http://service.indus.com/">
   <soapenv:Header/>
   <soapenv:Body>
      <ser:getApplication>
         <mobileNumber>$mobileNumber</mobileNumber>
      </ser:getAppVCPInput>
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
          ['ns2\$getAppVCPResponse']['output']['data']['\$t'];

      try {
        split = split.toString().replaceAll("\"{", "{");
        split = split.toString().replaceAll("\"}", "}");

        appLogger(Environment().config?.envParam, split);
      } catch (e) {
        print(e);
      }
    } else {
      showErrorToast('${response.statusCode} - ${response.reasonPhrase}');
    }

    super.isLoading = false;
  }
}
