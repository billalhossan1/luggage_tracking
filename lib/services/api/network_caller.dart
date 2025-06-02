import 'dart:convert';
import 'dart:io'; // Added for SocketException
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:luggage_tracking/screens/common/model/error_response_model.dart';

import 'network_response.dart';



class NetworkCaller {
  final Logger _logger = Logger();

  Future<NetworkResponse> getRequest(String url, {Map<String, dynamic>? queryParam, String? accessToken}) async {
    try {
      Map<String, String> headers = {'content-type': 'application/json'};
      if (accessToken != null) {
        headers['Authorization'] = 'Bearer $accessToken'; // Ensure token format
      }

      Uri uri = Uri.parse(url);
      if (queryParam != null) {
        uri = uri.replace(queryParameters: queryParam);
      }

      _logger.i("Making GET request to: $uri");
      _logger.i("Headers: $headers");

      final response = await http.get(uri, headers: headers).timeout(
        const Duration(seconds: 30),
        onTimeout: () {
          _logger.e("Request timed out");
          throw Exception("Request timed out");
        },
      );

      _logger.i("Response status code: ${response.statusCode}");
      _logger.i("Response body: ${response.body}");

      if (response.statusCode == 200) {
        return NetworkResponse(
          isSuccess: true,
          statusCode: response.statusCode,
          responseData: jsonDecode(response.body),
        );
      } else {
        _logger.e("Error response: ${response.body}");
        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
          responseData: jsonDecode(response.body),
          errorMessage: "Failed to fetch data",
        );
      }
    } catch (e) {
      _logger.e("Exception in getRequest: $e");
      return NetworkResponse(
        isSuccess: false,
        statusCode: 500,
        responseData: null,
        errorMessage: e.toString(),
      );
    }
  }

  Future<NetworkResponse> postRequest(String url, {Map<String, dynamic>? body, String? accessToken,String? tempToken}) async {
    try {
      Uri uri = Uri.parse(url);
      Map<String, String> headers = {'content-type': 'application/json'};
      if (accessToken != null) {
        headers['Authorization'] = accessToken;
      }
      _logger.i("Token: $accessToken");
      // if( tempToken != null) {
      //   headers['Authorization'] = tempToken;
      // }
      _logRequest(url, headers, body);

      http.Response response = await http.post(uri, headers: headers, body: jsonEncode(body));

      _logResponse(url, response.statusCode, response.headers, response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return NetworkResponse(
          isSuccess: true,
          statusCode: response.statusCode,
          responseData: jsonDecode(response.body),
        );
      } else {
        ErrorResponseModel errorResponseModel = ErrorResponseModel.fromJson(jsonDecode(response.body));
        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
          errorMessage: errorResponseModel.errorMessages?.isNotEmpty == true
              ? errorResponseModel.errorMessages!.first.message ?? 'Unknown error occurred'
              : errorResponseModel.message ?? 'Unknown error occurred',

        );
      }
    } on SocketException {
      return NetworkResponse(
        isSuccess: false,
        statusCode: -1,
        errorMessage: "No Internet Connection",
      );
    } catch (e) {
      return NetworkResponse(
        isSuccess: false,
        statusCode: -1,
        errorMessage: e.toString(),
      );
    }
  }

  Future<NetworkResponse> delRequest(String url, {String? accessToken, required Map<String, dynamic> body}) async {
    try {
      Map<String, String> headers = {'content-type': 'application/json'};
      if (accessToken != null) {
        headers['Authorization'] = accessToken;
      }

      _logRequest(url);
      Uri uri = Uri.parse(url);
      http.Response response = await http.delete(uri, headers: headers,body: jsonEncode(body));

      _logResponse(url, response.statusCode, response.headers, response.body);

      if (response.statusCode == 200) {
        return NetworkResponse(
          isSuccess: true,
          statusCode: response.statusCode,
          responseData: jsonDecode(response.body),
        );
      } else {
        ErrorResponseModel errorResponseModel = ErrorResponseModel.fromJson(jsonDecode(response.body));
        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
          errorMessage: errorResponseModel.errorMessages?.isNotEmpty == true
              ? errorResponseModel.errorMessages!.first.message ?? 'Unknown error occurred'
              : errorResponseModel.message ?? 'Unknown error occurred',

        );
      }
    } on SocketException {
      return NetworkResponse(
        isSuccess: false,
        statusCode: -1,
        errorMessage: "No Internet Connection",
      );
    } catch (e) {
      return NetworkResponse(
        isSuccess: false,
        statusCode: -1,
        errorMessage: e.toString(),
      );
    }
  }

  Future<NetworkResponse> patchRequest(String url, {dynamic body, String? accessToken}) async {
    try {
      Map<String, String> headers = {'content-type': 'application/json'};
      if (accessToken != null) {
        headers['Authorization'] = accessToken;
      }

      _logRequest(url, headers, body);
      Uri uri = Uri.parse(url);
      http.Response response = await http.patch(uri, headers: headers, body: jsonEncode(body));

      _logResponse(url, response.statusCode, response.headers, response.body);

      if (response.statusCode == 200) {
        return NetworkResponse(
          isSuccess: true,
          statusCode: response.statusCode,
          responseData: jsonDecode(response.body),
        );
      } else {
        ErrorResponseModel errorResponseModel = ErrorResponseModel.fromJson(jsonDecode(response.body));
        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
          errorMessage: errorResponseModel.errorMessages?.isNotEmpty == true
              ? errorResponseModel.errorMessages!.first.message ?? 'Unknown error occurred'
              : errorResponseModel.message ?? 'Unknown error occurred',

        );
      }
    } on SocketException {
      return NetworkResponse(
        isSuccess: false,
        statusCode: -1,
        errorMessage: "No Internet Connection",
      );
    } catch (e) {
      return NetworkResponse(
        isSuccess: false,
        statusCode: -1,
        errorMessage: e.toString(),
      );
    }
  }

  void _logRequest(String url, [Map<String, dynamic>? headers, Map<String, dynamic>? body]) {
    _logger.i('URL => $url\nHeaders => $headers\nBODY => $body');
  }

  void _logResponse(String url, int statusCode, Map<String, String>? headers, String body) {
    _logger.i('URL => $url\nHeaders => $headers\nStatus code => $statusCode\nBODY => $body');
  }
}