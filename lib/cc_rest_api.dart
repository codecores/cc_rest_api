import 'package:cc_rest_api/cc_rest_options.dart';

class CCRestApi {
  static final Map<String, dynamic> _instances = {};

  static CCRestOptions options = CCRestOptions(baseUrl: "");
  static CCRestLogging loggingOptions = CCRestLogging(logEnabled: true);

  static void init(
      {required CCRestOptions restOptions,
      CCRestLogging? loggingOptions,
      required List<dynamic> modules}) {
    CCRestApi.options = restOptions;

    if (loggingOptions != null) {
      CCRestApi.loggingOptions = loggingOptions;
    }

    for (var module in modules) {
      register(module);
    }
  }

  static void register<T>(T instance) {
    _instances[T.runtimeType.toString()] = instance;
  }

  static T getModule<T>() {
    final instance = _instances[T.runtimeType.toString()];
    if (instance != null) {
      return instance as T;
    } else {
      throw Exception('Module not found for type $T');
    }
  }
}
