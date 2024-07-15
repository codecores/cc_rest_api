import 'package:cc_rest_api/api/modules/api_module.dart';

class Example extends CCApiModule {
  Example(super.config);

  @override
  Future<Map<String, dynamic>> request() async {
    return await super.request();
  }

  @override
  response(dynamic data) {}
}
