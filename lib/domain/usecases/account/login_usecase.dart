import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:flix/domain/repository/database_repository.dart';
import 'package:flix/domain/usecases/base_usecase_with_param.dart';
import 'package:injectable/injectable.dart';

@injectable
class LoginUseCase extends BaseLocalUseCaseWithParams<int, LoginParams> {
  final DatabaseRepository _databaseRepository;

  LoginUseCase(this._databaseRepository);

  @override
  Future<int> call(LoginParams params) async {
    final users = await _databaseRepository.getAllUsers();
    final user =  users.firstWhereOrNull((element) =>
            element.email == params.email &&
            element.password == params.password);
    if(user==null) return -1;
    return user.id!;
  }
}

class LoginParams extends Equatable{
  final String email;
  final String password;

  const LoginParams({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];

  @override
  bool? get stringify => true;
}
