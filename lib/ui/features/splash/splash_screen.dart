import 'package:flix/core/extension/build_context_ext.dart';
import 'package:flix/ui/config/rout_names.dart';
import 'package:flix/ui/features/splash/bloc/splash_bloc.dart';
import 'package:flix/ui/features/splash/bloc/splash_event.dart';
import 'package:flix/ui/features/splash/bloc/splash_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<SplashBloc, SplashState>(
      bloc: BlocProvider.of<SplashBloc>(context)..add(SplashInitEvent()),
      listener: (context, state) {
       if(state is SplashExit){
         context.go(state.isLoggedIn?RoutesName.home.path: RoutesName.login.path);
       }
      },
      child: Container(
        color: Theme.of(context).primaryColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const FlutterLogo(size: 70,),
            Text(
              context.loc.app_name,
              style: Theme.of(context).textTheme.headlineLarge
              ?.copyWith(fontSize: 50),
            ),
            30.verticalSpaceFromWidth,
            const CircularProgressIndicator()
          ],
        ),
      ),
    );
  }
}
