import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:musify_app/app/musify_app.dart';
import 'package:musify_app/core/di/injection_container.dart';

void main() async {
  /// Captures errors reported by the native environment, including native iOS
  /// and Android code.
  Future<void> reportError(dynamic error, StackTrace stackTrace) async {
    if (kDebugMode) {
      // Print the full stacktrace in debug mode.
      debugPrint(error.toString());
      return;
    } else {
      // Send the Exception and Stacktrace to sentry in Production mode.
      // await Sentry.captureException(error, stackTrace: stackTrace);
    }
  }

  await runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      await setUpLocator();

      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);

      await JustAudioBackground.init(
        androidNotificationChannelId: 'com.example.musify_app.channel.audio',
        androidNotificationChannelName: 'Audio playback',
        androidNotificationOngoing: true,
      );

      runApp(const MusifyApp());
    },
    reportError,
  );
}
