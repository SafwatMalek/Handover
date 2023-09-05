import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:handover/data/model/user/user_model.dart';
import 'package:handover/domain/repository/user_repository.dart';

class UserRepoImp implements IUserRepository {
  final userRef =
      FirebaseFirestore.instance.collection('users').withConverter<User>(
            fromFirestore: (snapshots, _) => User.fromMap(snapshots.data()),
            toFirestore: (user, _) => user.toMap(),
          );

  @override
  Future<QuerySnapshot<User>> getUserById(String id) async {
    return userRef.where("id", isEqualTo: id).get();
  }
}
