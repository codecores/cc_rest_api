import 'package:cc_rest_api/api/enums/network_type.dart';
import 'package:cc_rest_api/api/enums/request_type.dart';

class CCApiConfig {
  final String endpoint;
  final RequestType requestType;
  final NetworkType networkType;

  const CCApiConfig(this.endpoint, this.requestType, this.networkType);
}
