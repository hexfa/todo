import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:todo/core/constants/storage_value.dart';
import 'package:todo/core/theme/theme.dart';
import 'package:todo/core/util/storage.dart';
import 'package:todo/gen/assets.gen.dart';
import 'package:todo/main.dart';
import 'package:todo/presentation/route/app_router.dart';
import 'package:todo/presentation/route/rout_paths.dart';
import 'package:todo/presentation/views/base/base-state.dart';

class AppDrawer extends StatefulWidget {
  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends BaseState<AppDrawer> {
  bool isDarkTheme = true;
  String selectedLanguage = 'EN';
  bool isLanguageExpanded = false;
  final storage = GetIt.I<Storage>();

  @override
  void initState() {
    super.initState();
    _loadPreferences();
  }

  Future<void> _loadPreferences() async {
    String? savedLanguage = await storage.getLanguage();
    bool? savedTheme = await storage.getData<bool>(StorageKey.IS_DARK_THEME);
    setState(() {
      selectedLanguage = savedLanguage ?? 'EN';
      isDarkTheme = savedTheme ?? false;
    });
  }

  Future<void> _changeLanguage(String languageCode) async {
    setState(() {
      selectedLanguage = languageCode;
      isLanguageExpanded = false;
    });
    await storage.saveLanguage(languageCode);
    Locale newLocale = Locale(languageCode);
    MyApp.setLocale(context, newLocale);
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [theme.colorScheme.primary, Colors.blue.shade200],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [
            // Header
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 32.0),
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage(Assets.png.manCharacter.path),
                  ),
                ),
                SizedBox(height: 12),
                Text(
                  'Amir Dehdarian',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'amir.dehdarian@example.com',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),

            ListTile(
              onTap: (){
                context.push(AppRoutePath.taskHistory);
              },
              leading: Icon(Icons.history, color: Colors.white),
              title: Text(localization.taskHistory, style: TextStyle(color: Colors.white)),
            ),
            // Dark Mode Switch
            ListTile(
              leading: Icon(Icons.brightness_6, color: Colors.white),
              title: Text(localization.darkMode, style: TextStyle(color: Colors.white)),
              trailing: ThemeSwitcher(
                builder: (context) {
                  return Switch(
                    value: isDarkTheme,
                    activeColor: Colors.white,
                    onChanged: (value) async {
                      setState(() {
                        isDarkTheme = value;
                      });
                      await storage.saveData(StorageKey.IS_DARK_THEME, isDarkTheme);
                      ThemeSwitcher.of(context).changeTheme(
                        theme: isDarkTheme ? darkTheme : lightTheme,
                      );
                    },
                  );
                },
              ),
            ),
            // Language Selector
            ExpansionTile(
              leading: Icon(Icons.language, color: Colors.white),
              title: Text(localization.language, style: TextStyle(color: Colors.white)),
              trailing: Text(
                selectedLanguage,
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.white70),
              ),
              initiallyExpanded: isLanguageExpanded,
              onExpansionChanged: (expanded) {
                setState(() {
                  isLanguageExpanded = expanded;
                });
              },
              children: [
                ListTile(
                  title: Text(localization.english, style: TextStyle(color: Colors.white)),
                  trailing: selectedLanguage == 'en'
                      ? Icon(Icons.check, color: Colors.white)
                      : null,
                  onTap: () => _changeLanguage('en'),
                ),
                ListTile(
                  title: Text(localization.german, style: TextStyle(color: Colors.white)),
                  trailing: selectedLanguage == 'de'
                      ? Icon(Icons.check, color: Colors.white)
                      : null,
                  onTap: () => _changeLanguage('de'),
                ),
              ],
            ),
            Spacer(),
            // Logout
            ListTile(
              leading: Icon(Icons.logout, color: Colors.white),
              title: Text(localization.logout, style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
