import 'dart:async';
import 'package:uryde/src/resources/api.dart';

abstract class UserRepository {
  Future<String> sendReport(Map<String, dynamic> requestData);
}

class FakeUserRepository implements UserRepository {
  @override
  Future<String> sendReport(Map<String, dynamic> requestData) {
    Api api = Api();
    return api.sendReport(requestData);
  }
}
