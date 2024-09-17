import 'package:flix/data/local/database/app_database.dart';
import 'package:flix/data/local/database/user_dao.dart';
import 'package:flix/data/local/model/user_model.dart';
import 'package:flix/ui/features/login/bloc/login_bloc.dart';
import 'package:flix/ui/features/login/login_screen.dart';
import 'package:flix/ui/widgets/progress_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import '../../../helpers/json_reader.dart';
import '../../../helpers/test_helper.mocks.dart';
import '../../mock_blocs.dart';
import '../../ui_test_helper.dart';



void main() {
  late Widget widgetUnderTest;
  late UserModel testUser;
  late LoginBloc loginBloc;
  late AppDatabase database;
  late UserDao userDao;

  setUpAll(() async{
    loginBloc = LoginBloc(MockPreferenceRepository(), MockLoginUseCase());
    widgetUnderTest = makeTestableWidget(
        child: BlocProvider(
            create: (context) => loginBloc, child: const LoginScreen()));
    database = await $FloorAppDatabase.inMemoryDatabaseBuilder().build();
    userDao = database.userDao;
    testUser = dummyUser();
  });

  setUp(() async {
    //userDao.deleteAll();
    //userDao.insertUser(testUser);
  },);


  tearDown(() async {
     //await database.close();
  });

  testWidgets("Login screen widgets appeared on screen", (widgetTester) async {
   // when(() => mockBloc.state,).thenReturn(LoginInitial());
    await widgetTester.pumpWidget(widgetUnderTest);
    await widgetTester.pump();
    expect(find.byType(AppBar), findsOneWidget);
    expect(find.text("Login"), findsExactly(2));
    final emailFieldFinder = find.byKey(const Key("login_email_field"));
    expect(emailFieldFinder, findsOneWidget);
    final passwordFieldFinder = find.byKey(const Key("login_password_field"));
    expect(passwordFieldFinder, findsOneWidget);
  });

  testWidgets("Blank credentials test", (widgetTester) async {
   // when(() => mockBloc.state,).thenReturn(LoginInitial());
    await widgetTester.pumpWidget(widgetUnderTest);
    await widgetTester.pump();
    final submitButtonFinder = find.byType(ElevatedButton);
    expect(submitButtonFinder, findsOneWidget);
    expect(find.byType(Text), findsNWidgets(5));
    //await widgetTester.pumpAndSettle();
    await widgetTester.tap(submitButtonFinder);
    //mockBloc.emit(const LoginError(errorType: LoginValidationError.invalidEmail));
   // await widgetTester.pumpAndSettle();
    print("state ${loginBloc.state}");
    await widgetTester.pumpAndSettle(const Duration(seconds: 10));
    //expect(find.text("Invalid email"), findsOneWidget);


   // final text = find.byType(type)('Email');

    print("state ${loginBloc.state}");
   /* expect(
        find.descendant(
            of: find.byKey(const Key("login_email_field")),
            matching: find.text('Enter a valid email')),
        findsOneWidget);*/
    //expect(text.decoration?.errorText, "Enter a valid email");
  });


  testWidgets("Login Success test", (widgetTester) async {
    //await userDao.insertUser(testUser);
   // when(() => mockBloc.state,).thenReturn(LoginInitial());
    await widgetTester.pumpWidget(widgetUnderTest);
    await widgetTester.pump();
    final emailFieldFinder = find.byKey(const Key("login_email_field"));
    final passwordFieldFinder = find.byKey(const Key("login_password_field"));
    await widgetTester.enterText(emailFieldFinder, testUser.email);
    await widgetTester.enterText(passwordFieldFinder, testUser.password);
    final submitButtonFinder = find.byType(ElevatedButton);
    expect(submitButtonFinder, findsOneWidget);
    await widgetTester.tap(submitButtonFinder);
    //mockBloc.emit(const LoginError(errorType: LoginValidationError.invalidEmail));
  //  await widgetTester.pump();
    await widgetTester.pumpAndSettle();
    expect(findsOneWidget,find.byType(ProgressLoader));
    /*await Future.delayed(const Duration(seconds: 3));
    final user = await userDao.findPersonByEmail(testUser.email);
    expect(user, isEmpty);*/
  });
}
