import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:handover/data/model/user/user_model.dart';

abstract class IUserRepository {
  Future<QuerySnapshot<User>> getUserById(String id);
}
