import 'package:bloc_test/bloc_test.dart';
import 'package:flix/data/local/database/app_database.dart';
import 'package:flix/data/local/database/user_dao.dart';
import 'package:flix/data/local/model/user_model.dart';
import 'package:flix/ui/features/registration/bloc/registration_bloc.dart';
import 'package:flix/ui/features/registration/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../helpers/json_reader.dart';
import '../../ui_test_helper.dart';

class MockRegistrationBloc
    extends MockBloc<RegistrationEvent, RegistrationState>
    implements RegistrationBloc {}

void main() {
  late AppDatabase database;
  late UserDao userDao;
  late Widget widgetUnderTest;
  late UserModel testUser;
  late RegistrationBloc mockBloc;

  setUp(() async {
    mockBloc = MockRegistrationBloc();
    widgetUnderTest = makeTestableWidget(
        child: BlocProvider(
            create: (context) => mockBloc, child: const MaterialApp()));
    database = await $FloorAppDatabase.inMemoryDatabaseBuilder().build();
    userDao = database.userDao;
    testUser = dummyUser();
  });

  tearDown(() async {
    await database.close();
  });
  testWidgets("Sign Up", (widgetTester) async {
    await widgetTester.pumpWidget(widgetUnderTest);
    expect(find.byType(AppBar), findsOneWidget);
    expect(find.text("Sign up"), findsOneWidget);
  });

/*  testWidgets("Sign Up", (tester) async {
    await tester.pumpWidget(widgetUnderTest);
    final nameFieldFinder = find.byKey(const Key("name_field"));
    final emailFieldFinder = find.byKey(const Key("email_field"));
    final dobFieldFinder = find.byKey(const Key("dob_field"));
    final passwordFieldFinder = find.byKey(const Key("password_field"));
    final cPasswordFieldFinder =
        find.byKey(const Key("confirm_password_field"));
    final submitButtonFinder = find.byType(ElevatedButton);

    await tester.enterText(nameFieldFinder, testUser.fullName);
    await tester.enterText(emailFieldFinder, testUser.email);
    await tester.enterText(dobFieldFinder, testUser.dob);
    await tester.enterText(passwordFieldFinder, testUser.password);
    await tester.enterText(cPasswordFieldFinder, testUser.password);

    await tester.tap(submitButtonFinder);

    final users = await userDao.findAll();
    expect(users, isNotEmpty);
  });*/
}
