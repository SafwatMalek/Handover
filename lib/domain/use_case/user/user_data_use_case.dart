import 'package:handover/data/model/user/user_model.dart';

abstract class UserDataUseCase {
  Future<User> execute(String id);
}
