import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:musify_app/core/constants/app_constants.dart';
import 'package:musify_app/core/di/injection_container.dart';
import 'package:musify_app/core/theme/cubit/theme_cubit.dart';
import 'package:musify_app/core/theme/theme.dart';
import 'package:musify_app/modules/songs/domain/usecases/songs_usecase.dart';
import 'package:musify_app/modules/songs/presentation/bloc/songs_bloc.dart';
import 'package:musify_app/routes/app_routes.dart';
import 'package:musify_app/routes/routes.dart';
import 'package:musify_app/services/navigation/navigation_service.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
            BlocProvider<SongsBloc>(
              create: (_) => SongsBloc(
                useCase: locator<SongsUseCase>(),
              ),
            ),

            // Add other BlocProviders here if needed
          ],
          child: MediaQuery(
            data: MediaQuery.of(context)
                .copyWith(textScaler: const TextScaler.linear(1.0)),
            child: BlocBuilder<ThemeCubit, ThemeMode>(
              builder: (context, themeMode) {
                return MaterialApp(
                  title: AppConstants.appName,
                  debugShowCheckedModeBanner: false,
                  themeMode: themeMode,
                  theme: AppTheme.light,
                  darkTheme: AppTheme.dark,
                  navigatorKey: locator<NavigationService>().navigatorKey,
                  initialRoute: AppRoutes.splashScreen,
                  onGenerateRoute: (settings) => Routes.generateRoute(settings),
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
