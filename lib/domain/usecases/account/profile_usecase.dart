import 'package:collection/collection.dart';
import 'package:flix/domain/repository/database_repository.dart';
import 'package:flix/domain/usecases/base_usecase_with_param.dart';
import 'package:injectable/injectable.dart';

import '../../../data/local/model/user_model.dart';

@injectable
class ProfileUseCase {
  final DatabaseRepository _databaseRepository;

  ProfileUseCase(this._databaseRepository);

  Future<UserModel?> getProfileById(int id) {
    return _databaseRepository.findUserById(id);
  }

  Future<int> updateProfile(UserModel userModel) {
    return _databaseRepository.updateProfile(userModel);
  }

  Future<UserModel?> getProfileByEmail(String email) {
    return _databaseRepository.findUserByEmail(email);
  }
}
