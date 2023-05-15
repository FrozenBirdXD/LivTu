import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:livtu/main.dart';
import 'package:livtu/services/auth/bloc/auth_bloc.dart';
import 'package:livtu/utils/dialogs/sign_out_dialog.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// ignore: must_be_immutable
class ProfileView extends StatelessWidget {
  ProfileView({super.key});

  final List<Locale> languages = [
    const Locale('en'),
    const Locale('de'),
  ];

  Locale selectLanguage = const Locale('en');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(AppLocalizations.of(context)!.profile),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Profile Options',
              style: TextStyle(
                fontSize: 24,
              ),
            ),
            const SizedBox(
              height: 32,
            ),
            ElevatedButton(
              onPressed: () {},
              child: const Text('Edit Profile'),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {
                BlocProvider.of<AuthBloc>(context).add(
                  const AuthChangePasswordEvent(newPassword: null),
                );
              },
              child: const Text('Change Password'),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () async {
                final logout = await showSignOutDialog(context);
                if (logout) {
                  BlocProvider.of<AuthBloc>(context).add(
                    const AuthLogoutEvent(),
                  );
                }
              },
              child: const Text('Log Out'),
            ),
            const SizedBox(
              height: 30,
            ),
            const Text(
              'Language',
              style: TextStyle(fontSize: 20),
            ),
            DropdownButton<Locale>(
              iconSize: 30,
              value: selectLanguage,
              onChanged: (Locale? newValue) {
                selectLanguage = newValue!;
                changeLocale(context, selectLanguage);
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

void changeLocale(BuildContext context, Locale locale) {
  var state = Localizations.localeOf(context);
  if (state.languageCode != locale.languageCode) {
    // Rebuild the widget tree with the new locale
    runApp(
      MyApp(
        locale: locale,
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
