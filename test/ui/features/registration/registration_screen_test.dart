import 'package:flix/data/local/database/app_database.dart';
import 'package:flix/data/local/database/user_dao.dart';
import 'package:flix/data/local/model/user_model.dart';
import 'package:flix/ui/features/registration/bloc/registration_bloc.dart';
import 'package:flix/ui/features/registration/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import '../../../helpers/json_reader.dart';
import '../../mock_blocs.dart';
import '../../ui_test_helper.dart';



void main() {
  late AppDatabase database;
  late UserDao userDao;
  late Widget widgetUnderTest;
  late UserModel testUser;
  late RegistrationBloc mockBloc;

  setUpAll(() async{
    mockBloc = MockRegistrationBloc();
    widgetUnderTest = makeTestableWidget(
        child: BlocProvider(
            create: (context) => mockBloc, child: const RegisterScreen()));
    //database = await $FloorAppDatabase.inMemoryDatabaseBuilder().build();
    //userDao = database.userDao;
    testUser = dummyUser();
  });



  tearDown(() async {
   // await database.close();
  });

  testWidgets("Sign Up widget appeared on screen", (widgetTester) async {
    when(() => mockBloc.state,).thenReturn(RegistrationInitial());
    await widgetTester.pumpWidget(widgetUnderTest);
    await widgetTester.pump();
    expect(find.byType(AppBar), findsOneWidget);
    expect(find.text("Sign up"), findsExactly(2));
    final nameFieldFinder = find.byKey(const Key("name_field"));
    expect(nameFieldFinder, findsOneWidget);
  });

/*  testWidgets("Sign Up test", (tester) async {
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
