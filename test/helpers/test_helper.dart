import 'package:flix/data/remote/service/web_service.dart';
import 'package:flix/domain/repository/movie_repository.dart';
import 'package:flix/domain/repository/preference_repository.dart';
import 'package:flix/domain/usecases/account/login_usecase.dart';
import 'package:flix/domain/usecases/account/profile_usecase.dart';
import 'package:flix/domain/usecases/account/registration_usecase.dart';
import 'package:mockito/annotations.dart';

@GenerateMocks([
  WebService,
  MovieRepository,
  RegistrationUseCase,
  ProfileUseCase,
  PreferenceRepository,
  LoginUseCase
])
void main() {}
