import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:musify_app/modules/splash/presentation/bloc/splash_bloc.dart';
import 'package:musify_app/routes/app_routes.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<SplashBloc, SplashState>(
        listener: (context, state) {
          if (state.loadComplete) {
            context.go(AppRoutes.songsScreen);
          }
        },
        child: Container(),
      ),
    );
  }
}
