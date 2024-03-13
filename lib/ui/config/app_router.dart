import 'package:flix/core/di/injector.dart';
import 'package:flix/ui/config/rout_names.dart';
import 'package:flix/ui/features/account/account_screen.dart';
import 'package:flix/ui/features/account/bloc/account_bloc.dart';
import 'package:flix/ui/features/app/bottom_nav_screen.dart';
import 'package:flix/ui/features/detail/bloc/detail_bloc.dart';
import 'package:flix/ui/features/detail/detail_screen.dart';
import 'package:flix/ui/features/detail/full_screen_image.dart';
import 'package:flix/ui/features/favorite/bloc/favorite_bloc.dart';
import 'package:flix/ui/features/favorite/favorite_screen.dart';
import 'package:flix/ui/features/home/bloc/home_bloc.dart';
import 'package:flix/ui/features/home/home_screen.dart';
import 'package:flix/ui/features/login/bloc/login_bloc.dart';
import 'package:flix/ui/features/login/login_screen.dart';
import 'package:flix/ui/features/registration/bloc/registration_bloc.dart';
import 'package:flix/ui/features/registration/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../features/splash/bloc/splash_bloc.dart';
import '../features/splash/splash_screen.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> _homeTabNavigatorKey =
    GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> _favTabNavigatorKey =
    GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> _accountTabNavigatorKey =
    GlobalKey<NavigatorState>();

BuildContext get context => router.routerDelegate.navigatorKey.currentContext!;

GoRouterDelegate get routerDelegate => router.routerDelegate;

GoRouteInformationParser get routeInformationParser =>
    router.routeInformationParser;

final router = GoRouter(
    navigatorKey: _rootNavigatorKey, initialLocation: '/', routes: routes);

final routes = [
  GoRoute(
    parentNavigatorKey: _rootNavigatorKey,
    name: "splash",
    path: '/',
    builder: (BuildContext context, GoRouterState state) {
      return BlocProvider<SplashBloc>(
        create: (context) => getIt<SplashBloc>(),
        child: const SplashScreen(),
      );
    },
  ),
  StatefulShellRoute.indexedStack(
    parentNavigatorKey: _rootNavigatorKey,
    branches: [
      StatefulShellBranch(
        navigatorKey: _homeTabNavigatorKey,
        routes: [
          GoRoute(
            name: RoutesName.home.name,
            path: RoutesName.home.path,
            pageBuilder: (context, GoRouterState state) {
              return _getPage(
                  MultiBlocProvider(providers: [
                    BlocProvider(create: (context) => getIt<HomeBloc>()),
                    BlocProvider(create: (context) => getIt<FavoriteBloc>()),
                  ], child: const HomeScreen()),
                  state);
            },
          ),
        ],
      ),
      StatefulShellBranch(
        navigatorKey: _favTabNavigatorKey,
        routes: [
          GoRoute(
            name: RoutesName.favorites.name,
            path: RoutesName.favorites.path,
            pageBuilder: (context, state) {
              Map extras = state.extra as Map<String, dynamic>;
              return _getPage(
                  BlocProvider(
                      create: (context) => getIt<FavoriteBloc>(),
                      child:  FavoriteScreen(reload: extras["reload"],)),
                  state);
            },
          ),
        ],
      ),
      StatefulShellBranch(
        navigatorKey: _accountTabNavigatorKey,
        routes: [
          GoRoute(
            name: RoutesName.account.name,
            path: RoutesName.account.path,
            pageBuilder: (context, state) {
              return _getPage(
                  BlocProvider(
                      create: (context) => getIt<AccountBloc>(),
                      child: const AccountScreen()),
                  state);
            },
          ),
        ],
      ),
    ],
    pageBuilder: (
      BuildContext context,
      GoRouterState state,
      StatefulNavigationShell navigationShell,
    ) {
      return _getPage(
          BottomNavigationScreen(
            child: navigationShell,
          ),
          state);
    },
  ),
  GoRoute(
    parentNavigatorKey: _rootNavigatorKey,
    path: RoutesName.login.path,
    pageBuilder: (context, state) {
      return _getPage(
        BlocProvider(
          create: (context) => getIt<LoginBloc>(),
          child: const LoginScreen(),
        ),
        state,
      );
    },
  ),
  GoRoute(
    parentNavigatorKey: _rootNavigatorKey,
    path: RoutesName.registration.path,
    pageBuilder: (context, state) {
      return _getPage(
        BlocProvider(
          create: (context) => getIt<RegistrationBloc>(),
          child: const RegisterScreen(),
        ),
        state,
      );
    },
  ),
  GoRoute(
    parentNavigatorKey: _rootNavigatorKey,
    path: RoutesName.detail.path,
    pageBuilder: (context, state) {
      Map extras = state.extra as Map<String, dynamic>;
      return _getPage(
          MultiBlocProvider(providers: [
            BlocProvider(create: (context) => getIt<DetailBloc>()),
            BlocProvider(create: (context) => getIt<FavoriteBloc>()),
          ], child: DetailScreen(movieId: extras["id"])),
          state);
    },
  ),
  GoRoute(
    parentNavigatorKey: _rootNavigatorKey,
    path: RoutesName.fullScreenImage.path,
    pageBuilder: (context, state) {
      Map extras = state.extra as Map<String, dynamic>;
      return _getPage(
        FullScreenImage(imageUrl: extras["imageUrl"]),
        state,
      );
    },
  )
];

_getPage(Widget child, GoRouterState state) {
  return MaterialPage(child: child, key: state.pageKey);
}

