import 'package:handover/data/model/user/user_model.dart';
import 'package:handover/domain/repository/user_repository.dart';

import 'user_data_use_case.dart';

class UserDataUseCaseImp implements UserDataUseCase {
  final IUserRepository _userRepo;

  UserDataUseCaseImp(this._userRepo);

  @override
  Future<User> execute(String id) async {
    try {
      var userSnapshot = await _userRepo.getUserById(id);
      return userSnapshot.docChanges.first.doc.data()!;
    } catch (e) {
      throw Exception("User not found");
    }
  }
}
