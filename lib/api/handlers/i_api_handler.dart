abstract class IAPIHandler {
  Future<dynamic> send();
  Future<void> request();
  void response(dynamic data);
}
