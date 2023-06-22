import 'dart:async';
import 'package:uryde/src/bloc/resources/api.dart';

abstract class UserRepository {
  Future<String> sendReport(Map<String, dynamic> requestData);
}

// TODO
// Check if this is the real way of doing the repository pattern
class FakeUserRepository implements UserRepository {
  @override
  Future<String> sendReport(Map<String, dynamic> requestData) {
    return Api.sendReport(requestData);
  }
}