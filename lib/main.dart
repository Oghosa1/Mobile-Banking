import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:fintech_ui/l10n/generated/app_localizations.dart';
import 'core/theme/app_theme.dart';
import 'shared/widgets/app_bottom_nav.dart';

import 'package:fintech_ui/core/config/environment_providers.dart';

void main() {
  runApp(
    const ProviderScope(
      child: FintechApp(),
    ),
  );
}

class FintechApp extends ConsumerWidget {
  const FintechApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final env = ref.watch(environmentProvider);

    return MaterialApp(
      title: env.appName,
      debugShowCheckedModeBanner: env.isProd,
      theme: AppTheme.darkTheme,
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'),
      ],
      home: const AppBottomNav(),
    );
  }
}