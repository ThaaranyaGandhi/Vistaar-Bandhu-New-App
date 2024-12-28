import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart' as http_parser;
import 'package:vistaar_bandhu_new_version/service/url_constants.dart';
import 'package:vistaar_bandhu_new_version/storage/app_pref.dart';
import 'package:vistaar_bandhu_new_version/util/app_logger.dart';

import '../environment.dart';
import 'api_methods.dart';
import 'app_di.dart';

class ApiClient {
  String _baseUrl = '';
  AppSharedPref _pref = getIt<AppSharedPref>();

  final String _tagRequest = '====== Request =====>';
  final String _tagResponse = '====== Response =====>';

  Future<Either<String, String>> apiClient(
      {required String path,
      Encoding? encoding,
      Map<String, String>? header,
      required ApiMethod method,
      Map<dynamic, dynamic>? body}) async {
    // final String accessToken = _pref.token;

    /// Check internet connection

    // bool result = await DataConnectionChecker().hasConnection;
    // if (!result) {
    //   return Left('Please check your internet connection');
    // }

    var headers;
    if (header == null) {
      headers = {'Content-Type': 'application/json'};
    } else {
      headers = header;
    }

    var responseData;
    final url = Uri.parse(_baseUrl + path);
    appLogger(Environment().config?.envParam,
        ' $_tagRequest  $method   $url \n $headers');
    appLogger(Environment().config?.envParam, ' ${json.encode(body)}');

    try {
      switch (method) {
        case ApiMethod.GET:
          {
            responseData = await http
                .get(url, headers: headers)
                .timeout(const Duration(seconds: 30));
          }
          break;

        case ApiMethod.POST:
          {
            responseData = await http
                .post(url, headers: headers, body: json.encode(body))
                .timeout(Duration(seconds: 30));
          }
          break;
        case ApiMethod.POST_HEADER:
          {
            responseData = await http
                .post(url, headers: headers, body: json.encode(body))
                .timeout(Duration(seconds: 30));
          }
          break;
        case ApiMethod.PUT:
          // TODO: Handle this case.
          break;

        case ApiMethod.DELETE:
          {
            responseData = await http.delete(
              url,
              headers: headers,
            );
          }
          break;
        case ApiMethod.POST_WITHOUT_TOKEN:
          {
            responseData =
                await http.post(url, headers: headers, body: json.encode(body));
          }
          break;
      }
    } on TimeoutException catch (_) {
      return const Left('Server timeout! try again later');
    } on SocketException catch (e) {
      debugPrint(e.toString());
    }
    appLogger(Environment().config?.envParam, "res --->  $responseData");
    appLogger(Environment().config?.envParam,
        '$_tagResponse ${responseData.statusCode} - $url \n ${responseData.body}');
    if (responseData.statusCode == 200) {
      return Right(responseData.body);
    } else {
      return Left(responseData.errormessage);
    }
  }

  // Call details upload
  Future<String> welcomeKitPDF(Map<String, String> jsonObject) async {
    try {
      Map<String, String> headers = {'Content-Type': 'application/json'};
      var url = Uri.parse(
          'http://productivity.vistaarfinance.net.in:98/SVC_Lead.svc/GetWelcomeKit');
      final response = await http
          .post(url, headers: headers, body: json.encode(jsonObject))
          .timeout(const Duration(seconds: 10));
      if (response.statusCode == 200) {
        var responseBody = response.body;
        return responseBody;
      } else {
        return "File not found.";
      }
    } catch (e, s) {
      debugPrint('Error : $e');
      debugPrint('Error : $s');
      return "File not found.";
      //  return null;
    }
  }

  Future<Either<String, dynamic>> uploadFiles(
      {required File file, String? type, String? name}) async {
    Map<String, String> headers = Map();
    headers[HttpHeaders.contentTypeHeader] = "application/json";

    /// Check internet connection

    // bool result = await DataConnectionChecker().hasConnection;
    // if (!result) {
    //   return Left('Please check your internet connection');
    // }

    var request = http.MultipartRequest(
      'POST',
      Uri.parse(
        API_UPLOAD_IMAGE,
      ),
    );
    request.files.add(await http.MultipartFile.fromPath(
      'file',
      file.path,
      contentType: http_parser.MediaType('image', ''),
    ));
    request.fields['name'] = '$name';
    request.fields['type'] = '$type';
    // request.fields['ENV'] = '$API_ENV';

    request.headers.addAll(headers);
    request.persistentConnection = true;

    final res = await request.send().then((response) {
      print(response);
      if (response.statusCode == 200) {
        return response;
      }
      return response;
    }).catchError((e) {
      print(e);
      return Left(e.toString());
    });
    return Right(res);
  }
}
