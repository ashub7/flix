import 'package:flix/data/local/model/user_model.dart';
import 'package:flix/ui/features/login/bloc/login_bloc.dart';
import 'package:flix/ui/features/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import '../../../helpers/json_reader.dart';
import '../../mock_blocs.dart';
import '../../ui_test_helper.dart';



void main() {
  late Widget widgetUnderTest;
  late UserModel testUser;
  late LoginBloc mockBloc;

  setUpAll(() async{
    mockBloc = MockLoginBloc();
    widgetUnderTest = makeTestableWidget(
        child: BlocProvider(
            create: (context) => mockBloc, child: const LoginScreen()));
    testUser = dummyUser();
  });



  tearDown(() async {
    // await database.close();
  });

  testWidgets("Login screen widgets appeared on screen", (widgetTester) async {
    when(() => mockBloc.state,).thenReturn(LoginInitial());
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
    when(() => mockBloc.state,).thenReturn(LoginInitial());
    await widgetTester.pumpWidget(widgetUnderTest);
    await widgetTester.pump();
    //final emailFieldFinder = find.byKey(const Key("login_email_field"));
    //final passwordFieldFinder = find.byKey(const Key("login_password_field"));
    final submitButtonFinder = find.byType(ElevatedButton);
    expect(submitButtonFinder, findsOneWidget);
    await widgetTester.tap(submitButtonFinder);
    mockBloc.emit(const LoginError(errorType: LoginValidationError.invalidEmail));
    expect(find.text("Enter a valid email"), findsNothing);
    await widgetTester.pump();
    //expect(find.byType(SnackBar), findsOneWidget);
    expect(find.text("Enter a valid email"), findsOneWidget);
  });
}
