import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:todo/core/constants/storage_value.dart';
import 'package:todo/core/theme/theme.dart';
import 'package:todo/core/util/storage.dart';
import 'package:todo/gen/assets.gen.dart';
import 'package:todo/main.dart';
import 'package:todo/presentation/route/rout_paths.dart';
import 'package:todo/presentation/views/base/base-state.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({super.key});

  @override
  State<AppDrawer> createState() => _AppDrawerState();
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

  Future<bool> _getDarkTheme() async {
    final theme = await storage.getData<bool>(StorageKey.IS_DARK_THEME);
    return theme ?? false; // Provide a default value if null
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
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Header
              Padding(
                padding: const EdgeInsets.only(top: 32.0),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: AssetImage(Assets.png.manCharacter.path),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Amir Dehdarian',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'amir.dehdarian@example.com',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),

              // Task History
              ListTile(
                onTap: () {
                  context.push(AppRoutePath.taskHistory);
                },
                leading: const Icon(Icons.history, color: Colors.white),
                title: Text(
                  localization.taskHistory,
                  style: const TextStyle(color: Colors.white),
                ),
              ),

              // Dark Mode Switch
              ListTile(
                leading: const Icon(Icons.brightness_6, color: Colors.white),
                title: Text(
                  localization.darkMode,
                  style: const TextStyle(color: Colors.white),
                ),
                trailing: FutureBuilder<bool>(
                  future: _getDarkTheme(), // Call the corrected method
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const CircularProgressIndicator(); // Loading indicator
                    }
                    final currentTheme = snapshot.data!;
                    return ThemeSwitcher(
                      builder: (context) {
                        return Switch(
                          value: currentTheme,
                          activeColor: Colors.white,
                          onChanged: (value) async {
                            await storage.saveData(
                                StorageKey.IS_DARK_THEME, value);
                            ThemeSwitcher.of(context).changeTheme(
                              theme: value ? darkTheme : lightTheme,
                            );
                            setState(() {
                              isDarkTheme = value;
                            });
                          },
                        );
                      },
                    );
                  },
                ),
              ),

              // Language Selector
              ExpansionTile(
                leading: const Icon(Icons.language, color: Colors.white),
                title: Text(
                  localization.language,
                  style: const TextStyle(color: Colors.white),
                ),
                trailing: Text(
                  selectedLanguage,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white70,
                  ),
                ),
                initiallyExpanded: isLanguageExpanded,
                onExpansionChanged: (expanded) {
                  setState(() {
                    isLanguageExpanded = expanded;
                  });
                },
                children: [
                  ListTile(
                    title: Text(
                      localization.english,
                      style: const TextStyle(color: Colors.white),
                    ),
                    trailing: selectedLanguage == 'en'
                        ? const Icon(Icons.check, color: Colors.white)
                        : null,
                    onTap: () => _changeLanguage('en'),
                  ),
                  ListTile(
                    title: Text(
                      localization.german,
                      style: const TextStyle(color: Colors.white),
                    ),
                    trailing: selectedLanguage == 'de'
                        ? const Icon(Icons.check, color: Colors.white)
                        : null,
                    onTap: () => _changeLanguage('de'),
                  ),
                ],
              ),

            ],
          ),
        ),
      ),
    );
  }
}
