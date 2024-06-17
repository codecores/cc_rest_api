class CCRestOptions {
  String baseUrl = "";
  Map<String, String> defaultHeaders = {};

  CCRestOptions({required this.baseUrl, Map<String, String>? defaultHeaders}) {
    if (defaultHeaders != null) {
      this.defaultHeaders = defaultHeaders;
    } else {
      this.defaultHeaders.putIfAbsent("Access-Control-Allow-Origin", () => "*");
      this.defaultHeaders.putIfAbsent("Accept", () => "*/*");
      this.defaultHeaders.putIfAbsent("Content-Type", () => "application/json");
    }
  }
}

class CCRestLogging {
  bool logEnabled = true;
  Function(String)? onRequest;
  Function(String)? onResponse;
  Function(String)? onError;

  CCRestLogging({
    required this.logEnabled,
    this.onRequest,
    this.onResponse,
    this.onError,
  });

  void broadcastRequest(String value) {
    if (!logEnabled) return;
    if (onRequest == null) return;
    onRequest!("[CCRestApi - Request] $value");
  }

  void broadcastResponse(String value) {
    if (!logEnabled) return;
    if (onResponse == null) return;
    onResponse!("[CCRestApi - Response] $value");
  }

  void broadcastError(String value) {
    if (!logEnabled) return;
    if (onError == null) return;
    onError!("[CCRestApi - Error] $value");
  }
}
