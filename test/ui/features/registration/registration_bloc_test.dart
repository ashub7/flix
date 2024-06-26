
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flix/core/utils/constants.dart';
import 'package:flix/domain/usecases/account/registration_usecase.dart';
import 'package:flix/ui/features/registration/bloc/registration_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import '../../../helpers/json_reader.dart';
import '../../../helpers/test_helper.mocks.dart';

main() {
  late MockPreferenceRepository preferenceRepository;
  late MockProfileUseCase profileUseCase;
  late MockRegistrationUseCase registrationUseCase;
  late RegistrationBloc registrationBloc;

  setUp(() {
    preferenceRepository = MockPreferenceRepository();
    profileUseCase = MockProfileUseCase();
    registrationUseCase = MockRegistrationUseCase();
    registrationBloc = RegistrationBloc(registrationUseCase, preferenceRepository, profileUseCase);
  });
  test("Initial state should be empty", () async {
    expect(registrationBloc.state, RegistrationInitial());
  });

  blocTest<RegistrationBloc, RegistrationState>(
    "New SignUp test",
    build: () {
      when(profileUseCase.getProfileByEmail("a@x.com")).thenAnswer(
            (realInvocation) async {
          return null;
        },
      );
      when(registrationUseCase(const RegistrationParams(fullName: "Test user", email: "a@x.com",
          password: "password", gender: 1, avatar: "", dob: ""))).thenAnswer((realInvocation) async {
            return 1;
      });
      return registrationBloc;
    },
    act: (bloc) => bloc.add(const RegistrationSubmitEvent(fullName: "Test user", email: "a@x.com",
        password: "password", confirmPassword: "password", gender: 1, avatar: "", dob: "")),
    wait: const Duration(milliseconds: 1000),
    expect: () => [
      RegistrationLoading(),
      RegistrationSuccess()
    ],
  );


  blocTest<RegistrationBloc, RegistrationState>(
    "Already registered test",
    build: () {
      when(profileUseCase.getProfileByEmail("a@x.com")).thenAnswer(
            (realInvocation) async {
          return dummyUser();
        },
      );
      return registrationBloc;
    },
    act: (bloc) => bloc.add(const RegistrationSubmitEvent(fullName: "Test user", email: "a@x.com",
        password: "password", confirmPassword: "password", gender: 1, avatar: "", dob: "")),
    wait: const Duration(milliseconds: 1000),
    expect: () => [
      RegistrationLoading(),
      const RegistrationErrorState(errorType: RegistrationValidationError.userAlreadyExists)
    ],
  );

  blocTest<RegistrationBloc, RegistrationState>(
    "Invalid email registration",
    build: () {
      return registrationBloc;
    },
    act: (bloc) => bloc.add(const RegistrationSubmitEvent(fullName: "Test user", email: "a@x",
        password: "password", confirmPassword: "password", gender: 1, avatar: "", dob: "")),
    wait: const Duration(milliseconds: 1000),
    expect: () => [
      RegistrationLoading(),
      const RegistrationErrorState(errorType: RegistrationValidationError.invalidEmail)
    ],
  );

}
