import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:todo/presentation/route/app_router.dart';

import 'core/di/di.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  const token = 'fd1df697c8622b190f2f2999047342d91e90690b';

  setupLocator(token);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final AppRouter appRouter = getIt<AppRouter>();

   MyApp({super.key});

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
