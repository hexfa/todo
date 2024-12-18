import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:todo/core/constants/storage_value.dart';
import 'package:todo/core/theme/theme.dart';
import 'package:todo/core/util/storage.dart';
import 'package:todo/presentation/route/app_router.dart';
import 'core/di/di.dart';

final storage = GetIt.I<Storage>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  const token = 'fd1df697c8622b190f2f2999047342d91e90690b';
  await setupLocator(token);
  bool isDarkTheme = await storage.getData<bool>(StorageKey.IS_DARK_THEME) ?? false;
  String? languageCode = await storage.getLanguage();
  runApp(MyApp(
    isDarkTheme: isDarkTheme,
    initialLocale: languageCode != null ? Locale(languageCode) : Locale('en'),
  ));
}

class MyApp extends StatefulWidget {
  final bool isDarkTheme;
  final Locale initialLocale;

  MyApp({super.key, required this.isDarkTheme, required this.initialLocale});

  static void setLocale(BuildContext context, Locale newLocale) {
    _MyAppState? state = context.findAncestorStateOfType<_MyAppState>();
    state?.setLocale(newLocale);
  }

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  AppRouter appRouter = GetIt.I<AppRouter>();
  Locale? _locale;

  void setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  void initState() {
    super.initState();
    _locale = widget.initialLocale;
  }

  @override
  Widget build(BuildContext context) {
    return ThemeProvider(
      initTheme: widget.isDarkTheme ? darkTheme : lightTheme,
      builder: (_, myTheme) {
        return MaterialApp.router(
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          locale: _locale,
          supportedLocales: const [
            Locale('en'), // English
            Locale('de'), // German
          ],
          routerConfig: appRouter.router,
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}
