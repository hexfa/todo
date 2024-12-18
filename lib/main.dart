import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:todo/core/theme/theme.dart';
import 'package:todo/core/util/storage.dart';
import 'package:todo/presentation/route/app_router.dart';
import 'core/di/di.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  const token = 'fd1df697c8622b190f2f2999047342d91e90690b';
  await setupLocator(token);
  final storage = GetIt.I<Storage>();
  bool isDarkTheme = await storage.getData<bool>('isDarkTheme') ?? false;
  runApp(MyApp(isDarkTheme: isDarkTheme,));
}

class MyApp extends StatelessWidget {
  MyApp({super.key, required this.isDarkTheme});
  final bool isDarkTheme;
  AppRouter appRouter = GetIt.I<AppRouter>();

  @override
  Widget build(BuildContext context) {
    return ThemeProvider(
        initTheme: isDarkTheme ? darkTheme : lightTheme,
        builder: (_, myTheme) {
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
    );
  }
}
