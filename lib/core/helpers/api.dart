import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class Api {
  static Future<dynamic> get(
      {required String url, String? token}) async {
    Map<String, String> headers = {};
    // headers.addAll({
    //   'Content-Type': 'application/json',
    // });
    if (token != null) {
      headers.addAll({
        'Authorization': 'Bearer $token',
      });
    }
    http.Response response = await http.get(Uri.parse(url), headers: headers);
    if (response.statusCode >= 200 || response.statusCode < 300) {
      return jsonDecode(response.body);
    } else {
      throw Exception(
          'There is a issue with the status code ${response.statusCode}');
    }
  }

  static Future<dynamic> post(
      {required String url, @required dynamic body, String? token}) async {
    Map<String, String> headers = {};
    // headers.addAll({
    //   'Content-Type': 'application/json',
    // });

    if (token != null) {
      headers.addAll({
        'Authorization': 'Bearer $token',
      });
    }
    http.Response response;
    try {
      response = await http.post(
        Uri.parse(url),
        body: body,
        headers: headers,
      );
      Map<String, dynamic> data = jsonDecode(response.body);
      return data;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static Future<dynamic> put(
      {required String url,
      @required dynamic body,
      @required String? token}) async {
    Map<String, String> headers = {};
    // headers.addAll({
    //   'Content-Type': 'application/json',
    // });
    if (token != null) {
      headers.addAll({
        'Authorization': 'Bearer $token',
      });
    }

    http.Response response = await http.put(
      Uri.parse(url),
      body: body,
      headers: headers,
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      return data;
    } else {
      throw Exception(
          'There is a issue with the status code ${response.statusCode} with body ${response.body} ');
    }
  }

  static Future<dynamic> delete(
      {required String url,
      @required dynamic body,
      @required String? token}) async {
    Map<String, String> headers = {};
    // headers.addAll({
    //   'Content-Type': 'application/json',
    // });

    if (token != null) {
      headers.addAll({
        'Authorization': 'Bearer $token',
      });
    }

    http.Response response = await http.delete(
      Uri.parse(url),
      body: body,
      headers: headers,
    );
    if (response.statusCode >= 200 && response.statusCode < 300) {
      Map<String, dynamic> data = jsonDecode(response.body);
      return data;
    } else {
      if (kDebugMode) {
        print(response.body);
      }
      throw Exception(response.reasonPhrase.toString());
    }
  }
}
