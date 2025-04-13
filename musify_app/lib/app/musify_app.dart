import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:musify_app/core/constants/app_constants.dart';
import 'package:musify_app/core/di/injection_container.dart';
import 'package:musify_app/core/theme/cubit/theme_cubit.dart';
import 'package:musify_app/core/theme/theme.dart';
import 'package:musify_app/modules/cart/domain/usecases/cart_usecases.dart';
import 'package:musify_app/modules/cart/presentation/bloc/cart_bloc.dart';
import 'package:musify_app/modules/songs/domain/usecases/songs_usecase.dart';
import 'package:musify_app/modules/songs/presentation/bloc/songs_bloc.dart';
import 'package:musify_app/modules/splash/presentation/bloc/splash_bloc.dart';
import 'package:musify_app/routes/routes.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:musify_app/services/storage/storage_service.dart';

class MusifyApp extends StatelessWidget {
  const MusifyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider<ThemeCubit>(
              create: (_) => ThemeCubit(),
            ),
            BlocProvider(
              create: (_) => SplashBloc(
                storageService: locator<StorageService>(),
              )..add(SplashStarted()),
            ),
            BlocProvider<SongsBloc>(
              create: (_) => SongsBloc(
                useCase: locator<SongsUseCase>(),
              ),
            ),
            BlocProvider<CartBloc>(
              create: (_) => CartBloc(
                cartUsecases: locator<CartUsecases>(),
              )..add(const LoadCart()),
            ),
            // Add other BlocProviders here if needed
          ],
          child: MediaQuery(
            data: MediaQuery.of(context)
                .copyWith(textScaler: const TextScaler.linear(1.0)),
            child: BlocBuilder<ThemeCubit, ThemeMode>(
              builder: (context, themeMode) {
                return MaterialApp.router(
                  title: AppConstants.appName,
                  debugShowCheckedModeBanner: false,
                  themeMode: themeMode,
                  theme: AppTheme.light,
                  darkTheme: AppTheme.dark,
                  routerConfig: router,
                  supportedLocales: AppLocalizations.supportedLocales,
                  localizationsDelegates: const [
                    GlobalMaterialLocalizations.delegate,
                    GlobalWidgetsLocalizations.delegate,
                    GlobalCupertinoLocalizations.delegate,
                    ...AppLocalizations.localizationsDelegates,
                  ],
                );
              },
            ),
          ),
        );
      },
    );
  }
}
