import 'package:equatable/equatable.dart';
import 'package:flix/domain/repository/database_repository.dart';
import 'package:flix/domain/usecases/base_usecase_with_param.dart';
import 'package:injectable/injectable.dart';

@injectable
class RegistrationUseCase
    extends BaseLocalUseCaseWithParams<int, RegistrationParams> {
  final DatabaseRepository _databaseRepository;

  RegistrationUseCase(this._databaseRepository);

  @override
  Future<int> call(RegistrationParams params) {
    return _databaseRepository.registerUser(params);
  }
}

class RegistrationParams extends Equatable{
  final String fullName;
  final String email;
  final String password;
  final int gender;
  final String avatar;
  final String dob;

  const RegistrationParams(
      {required this.fullName, required this.email, required this.password, required this.gender, required this.avatar, required this.dob});

  @override
  List<Object?> get props => [email, fullName];

  @override
  bool? get stringify => true;
}