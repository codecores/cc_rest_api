import 'dart:convert';

import 'package:cc_rest_api/api/enums/request_type.dart';
import 'package:cc_rest_api/api/handlers/i_api_handler.dart';
import 'package:cc_rest_api/api/models/api_config.dart';
import 'package:cc_rest_api/cc_rest_api.dart';
import 'package:http/http.dart' as http;

abstract class CCApiModule implements IAPIHandler {
  late String name;
  late CCApiConfig apiConfig;
  Map<String, dynamic> data = {};
  Map<String, String> headers = {};
  Map<String, dynamic> parameters = {};

  CCApiModule(this.apiConfig) {
    name = runtimeType.toString();
  }

  @override
  send() async {
    headers.addAll(CCRestApi.options.defaultHeaders);
    CCRestApi.loggingOptions.broadcastRequest(getUri().toString());

    http.Response? response = await handleRequest();

    if (response == null) {
      CCRestApi.loggingOptions.broadcastError("Unknown Request Type");
      return;
    }

    Map<String, dynamic> responseDTO = {};

    if (response.body.trim().isNotEmpty) {
      try {
        responseDTO = jsonDecode(response.body);
        CCRestApi.loggingOptions.broadcastResponse(responseDTO.toString());
      } catch (e) {
        if (CCRestApi.loggingOptions.onError != null) {
          CCRestApi.loggingOptions.broadcastError(e.toString());
        }
      }
    }
    this.response(responseDTO);
    return responseDTO;
  }

  Future<http.Response?> handleRequest() async {
    switch (apiConfig.requestType) {
      case RequestType.GET:
        {
          return await http.get(
            Uri.http(
              CCRestApi.options.baseUrl,
              apiConfig.endpoint,
              parameters,
            ),
            headers: headers,
          );
        }
      case RequestType.POST:
        {
          return await http.post(
            Uri.http(CCRestApi.options.baseUrl, apiConfig.endpoint),
            body: json.encode(data),
            headers: headers,
          );
        }
      case RequestType.DELETE:
        return await http.delete(
          Uri.http(CCRestApi.options.baseUrl, apiConfig.endpoint),
          body: json.encode(data),
          headers: headers,
        );
      default:
        print('Unknown request type');
    }
    return null;
  }

  @override
  Future<Map<String, dynamic>> request() async {
    return await send();
  }

  Uri getUri() {
    return Uri.http(CCRestApi.options.baseUrl, apiConfig.endpoint);
  }

  void setBody(Map<String, dynamic> data) {
    this.data = data;
  }

  void setHeaders(Map<String, String> headers) {
    this.headers = headers;
  }

  void setParameters(Map<String, dynamic> parameters) {
    this.parameters = parameters;
  }
}
