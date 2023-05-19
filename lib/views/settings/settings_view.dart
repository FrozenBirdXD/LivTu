import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  final List<Locale> languages = [
    const Locale('en'),
    const Locale('de'),
  ];

  @override
  Widget build(BuildContext context) {
    var localeProvider = Provider.of<LocaleProvider>(context);
    Locale selectLanguage = localeProvider.locale;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Language',
              style: TextStyle(fontSize: 20),
            ),
            DropdownButton<Locale>(
              iconSize: 30,
              value: selectLanguage,
              onChanged: (Locale? newValue) {
                if (newValue != null) {
                  localeProvider.changeLocale(newValue);
                }
              },
              items: languages.map((Locale locale) {
                return DropdownMenuItem<Locale>(
                  value: locale,
                  child: Text(
                    locale.languageCode,
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}

class LocaleProvider with ChangeNotifier {
  Locale _locale;

  LocaleProvider(this._locale);

  Locale get locale => _locale;

  void changeLocale(Locale locale) {
    _locale = locale;
    notifyListeners();
  }
}
