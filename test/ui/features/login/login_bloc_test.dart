import 'package:bloc_test/bloc_test.dart';
import 'package:flix/domain/usecases/account/login_usecase.dart';
import 'package:flix/ui/features/login/bloc/login_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import '../../../helpers/test_helper.mocks.dart';

main() {
  late MockPreferenceRepository preferenceRepository;
  late MockLoginUseCase loginUseCase;
  late LoginBloc loginBloc;

  setUpAll(() {
    preferenceRepository = MockPreferenceRepository();
    loginUseCase = MockLoginUseCase();
  });

  setUp(() {
    loginBloc = LoginBloc(preferenceRepository, loginUseCase);
  });

  test("Initial state should be empty", () async {
    expect(loginBloc.state, LoginInitial());
  });

  blocTest<LoginBloc, LoginState>(
    "New Login success case",
    build: () {
      when(loginUseCase(
              const LoginParams(email: "a@x.com", password: "123456")))
          .thenAnswer(
        (realInvocation) async {
          return 1;
        },
      );
      return loginBloc;
    },
    act: (bloc) =>
        bloc.add(const LoginSubmitEvent(email: "a@x.com", password: "123456")),
    wait: const Duration(milliseconds: 3000),
    expect: () => [LoginLoading(), LoginSuccess()],
  );

  blocTest<LoginBloc, LoginState>(
    "Invalid credentials test",
    build: () {
      when(loginUseCase(
              const LoginParams(email: "a@x.com", password: "123456")))
          .thenAnswer(
        (realInvocation) async {
          return -1;
        },
      );
      return loginBloc;
    },
    act: (bloc) =>
        bloc.add(const LoginSubmitEvent(email: "a@x.com", password: "123456")),
    wait: const Duration(milliseconds: 3000),
    expect: () => [
      LoginLoading(),
      const LoginError(errorType: LoginValidationError.invalidCredentials)
    ],
  );

  group("Login validation test group", () {
    blocTest<LoginBloc, LoginState>(
      "Invalid Email test",
      build: () {
        return loginBloc;
      },
      act: (bloc) =>
          bloc.add(const LoginSubmitEvent(email: "a@x", password: "123456")),
      wait: const Duration(milliseconds: 3000),
      expect: () => [
        LoginLoading(),
        const LoginError(errorType: LoginValidationError.invalidEmail)
      ],
    );

    blocTest<LoginBloc, LoginState>(
      "Invalid password case",
      build: () {
        return loginBloc;
      },
      act: (bloc) =>
          bloc.add(const LoginSubmitEvent(email: "a@x.com", password: "123")),
      wait: const Duration(milliseconds: 3000),
      expect: () => [
        LoginLoading(),
        const LoginError(errorType: LoginValidationError.invalidPassword)
      ],
    );
  });
}
