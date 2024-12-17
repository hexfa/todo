import 'package:flutter/material.dart';
import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:get_it/get_it.dart';
import 'package:todo/core/constants/storage_value.dart';
import 'package:todo/core/theme/theme.dart';
import 'package:todo/gen/assets.gen.dart';
import 'package:todo/core/util/storage.dart';

class AppDrawer extends StatefulWidget {
  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  bool isDarkTheme = true;
  String selectedLanguage = 'EN';
  bool isLanguageExpanded = false;
  final storage = GetIt.I<Storage>();

  @override
  void initState() {
    super.initState();
    _loadThemePreference();
  }

  Future<void> _loadThemePreference() async {

    bool? savedTheme = await storage.getData(StorageKey.IS_DARK_THEME);
    setState(() {
      isDarkTheme = savedTheme ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Drawer(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.purpleAccent.shade100, Colors.blue.shade200],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [
            // Custom Header
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
            // Dark Mode Switch
            ListTile(
              leading: Icon(Icons.brightness_6, color: Colors.white),
              title: Text('Dark Mode', style: TextStyle(color: Colors.white)),
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
            // Language Expanded ListTile
            ExpansionTile(
              leading: Icon(Icons.language, color: Colors.white),
              title: Text('Language', style: TextStyle(color: Colors.white)),
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
                  title: Text('English', style: TextStyle(color: Colors.white)),
                  trailing: selectedLanguage == 'EN'
                      ? Icon(Icons.check, color: Colors.blue)
                      : null,
                  onTap: () {
                    setState(() {
                      selectedLanguage = 'EN';
                      isLanguageExpanded = false;
                    });
                  },
                ),
                ListTile(
                  title: Text('German', style: TextStyle(color: Colors.white)),
                  trailing: selectedLanguage == 'DE'
                      ? Icon(Icons.check, color: Colors.blue)
                      : null,
                  onTap: () {
                    setState(() {
                      selectedLanguage = 'DE';
                      isLanguageExpanded = false;
                    });
                  },
                ),
              ],
            ),
            Spacer(),
            ListTile(
              leading: Icon(Icons.logout, color: Colors.white),
              title: Text('Logout', style: TextStyle(color: Colors.white)),
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
