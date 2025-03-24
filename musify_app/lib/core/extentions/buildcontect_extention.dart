import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:musify_app/core/theme/custom_theme.dart';

extension AppContextExtensions on BuildContext {
  // Access CustomTheme extension from the context
  CustomTheme get customTheme {
    final theme = Theme.of(this).extension<CustomTheme>();
    if (theme == null) {
      throw Exception(
          "CustomTheme extension is not found in the current theme.");
    }
    return theme;
  }

  // Access AppLocalizations from the context
  AppLocalizations get loc {
    final localization = AppLocalizations.of(this);
    if (localization == null) {
      throw Exception(
          "AppLocalizations is not available in the provided context.");
    }
    return localization;
  }
}
