import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget makeTestableWidget({ required Widget child }) {
  return ScreenUtilInit(
    designSize: const Size(360, 690),
    minTextAdapt: true,
    child: MediaQuery(
      data: const MediaQueryData(),
      child: MaterialApp(
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        home: child,
      ),
    ),
  );
}
