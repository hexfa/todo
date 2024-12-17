import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:todo/presentation/route/app_router.dart';

import 'core/di/di.dart';

void main() {
  const token = '0123456789abcdef0123456789';

  setupLocator(token);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  AppRouter appRouter = GetIt.I<AppRouter>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      localizationsDelegates: const [
        AppLocalizations.delegate, // Add this line
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'), // English
      ],
      routerConfig: appRouter.router,
      locale: const Locale('en'),
      debugShowCheckedModeBanner: false,
    );
  }
}
