import 'dart:convert';
import 'dart:io';
import 'package:challenge_guia/app/data/adapters/http_error_adapter.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../../../core/values/constants.dart';
import 'http_service.dart';

class HttpServiceImp implements HttpService {

  Future<http.Response> _request(
    String method,
    String path, {
    bool useBaseUrl = true,
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParams,
    Map<String, String>? headers,
  }) async {
    var baseUrl = Constants.baseUrl;
    final uri = Uri.parse(useBaseUrl ? '$baseUrl$path' : path)
        .replace(queryParameters: queryParams);

    final defaultHeaders = {
      'Content-Type': 'application/json',
      ...?headers,
    };

    if (kDebugMode) {
      print('$method $uri');
      print('Headers: $defaultHeaders');
      if (data != null) print('Body: $data');
    }

    switch (method) {
      case 'GET':
        return await http.get(uri, headers: defaultHeaders);
      case 'POST':
        return await http.post(uri,
            headers: defaultHeaders, body: jsonEncode(data));
      case 'PUT':
        return await http.put(uri,
            headers: defaultHeaders, body: jsonEncode(data));
      case 'DELETE':
        return await http.delete(uri,
            headers: defaultHeaders, body: jsonEncode(data));
      default:
        throw UnsupportedError('Unsupported HTTP method: $method');
    }
  }

  @override
  Future get(String path,
      {bool useBaseUrl = true,
      Map<String, dynamic>? queryParams,
      Map<String, String>? headers}) {
    try {
      return _request('GET', path,
          useBaseUrl: useBaseUrl, queryParams: queryParams, headers: headers);
    } on HttpException catch (e) {
      throw HttpErrorAdapter.convertToErrorModel(e);
    }
  }

  @override
  Future post(String path,
      {bool useBaseUrl = true,
      Map<String, dynamic>? data,
      Map<String, dynamic>? queryParams,
      Map<String, String>? headers}) async {
    try {
      return _request('POST', path,
          useBaseUrl: useBaseUrl,
          data: data,
          queryParams: queryParams,
          headers: headers);
    } on HttpException catch (e) {
      throw HttpErrorAdapter.convertToErrorModel(e);
    }
  }

  @override
  Future delete(String path,
      {bool useBaseUrl = true,
      Map<String, dynamic>? data,
      Map<String, dynamic>? queryParams,
      Map<String, String>? headers}) async {
    try {
      return _request('DELETE', path,
          useBaseUrl: useBaseUrl,
          data: data,
          queryParams: queryParams,
          headers: headers);
    } on HttpException catch (e) {
      throw HttpErrorAdapter.convertToErrorModel(e);
    }
  }

  @override
  Future put(String path,
      {bool useBaseUrl = true,
      Map<String, dynamic>? data,
      Map<String, dynamic>? queryParams,
      Map<String, String>? headers}) async {
    try {
      return _request('PUT', path,
          useBaseUrl: useBaseUrl,
          data: data,
          queryParams: queryParams,
          headers: headers);
    } on HttpException catch (e) {
      throw HttpErrorAdapter.convertToErrorModel(e);
    }
  }
}
