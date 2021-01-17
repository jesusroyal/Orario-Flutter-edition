import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class AdminService {
  Future<bool> ferifyToken(
      {@required String token, @required String path}) async {
    final db = FirebaseDatabase.instance;
    final ref = db.reference().child('uni/$path/token');

    bool isValid = false;
    await ref.once().then((value) {
      if (value.value.toString() == token) {
        isValid = true;
      }
    });
    return isValid;
  }
}
