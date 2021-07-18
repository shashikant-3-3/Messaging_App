import 'package:cloud_firestore/cloud_firestore.dart';

class DBService {
  static DBService instance = DBService();

  late FirebaseFirestore _db;

  DBService() {
    _db = FirebaseFirestore.instance;
  }

  String _userCollection = "users";

  Future<void> createUserInDB(
      String _uid, String _name, String _email,) async {
    try {
      return await _db.collection(_userCollection).doc(_uid).set({
        "name": _name, 
        "email": _email,
        "lastSeen": DateTime.now().toUtc(),
      });
    } catch (e) {
      print(e);
    }
  }
}

