import 'package:dynamic_color/dynamic_color.dart';
import 'package:flix/core/di/injector.dart';
import 'package:flix/ui/config/app_router.dart';
import 'package:flix/ui/features/favorite/bloc/favorite_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import '../../config/theme/app_theme.dart';

class Application extends StatefulWidget {
  const Application({super.key});

  @override
  State<Application> createState() => _ApplicationState();
}

class _ApplicationState extends State<Application> {
  @override
  Widget build(BuildContext context) {
    const String fontPreference = "Outfit";
    final TextTheme darkTextTheme = GoogleFonts.getTextTheme(
      fontPreference,
      ThemeData.dark().textTheme,
    );
    final TextTheme lightTextTheme = GoogleFonts.getTextTheme(
      fontPreference,
      ThemeData.light().textTheme,
    );

    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      child: DynamicColorBuilder(
        builder: (ColorScheme? lightDynamic, ColorScheme? darkDynamic) {
          ColorScheme lightColorScheme = ColorScheme.fromSeed(
            seedColor: const Color(0XFF2CD312),
          );
          ;
          ColorScheme darkColorScheme = ColorScheme.fromSeed(
            seedColor: const Color(0XFF2CD312),
            brightness: Brightness.dark,
          );
          ;

          return MultiBlocProvider(
              providers: [
                BlocProvider<FavoriteBloc>(
                  create: (context) => getIt<FavoriteBloc>(),
                )
              ],
              child: MaterialApp.router(
                routerConfig: router,
                debugShowCheckedModeBanner: false,
                themeMode: ThemeMode.system,
                theme: appTheme(
                  context,
                  lightColorScheme,
                  fontPreference,
                  lightTextTheme,
                  ThemeData.light().dividerColor,
                  SystemUiOverlayStyle.dark,
                ),
                darkTheme: appTheme(
                  context,
                  darkColorScheme,
                  fontPreference,
                  darkTextTheme,
                  ThemeData.dark().dividerColor,
                  SystemUiOverlayStyle.light,
                ),
                localizationsDelegates: const [
                  AppLocalizations.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                supportedLocales: const [
                  Locale('en'), // English
                ],
              ));
        },
      ),
    );
  }
}
