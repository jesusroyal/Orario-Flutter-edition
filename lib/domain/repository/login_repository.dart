import 'package:flutter/material.dart';

abstract class LoginRepository {
  Future<Map<String, String>> getUniversities();
  Future<Map<String, String>> getGroups({@required String university});
}
