import 'package:flutter/material.dart';

abstract class AdminRepository {
  Future<bool> ferifyToken({@required String token, @required path});
}
