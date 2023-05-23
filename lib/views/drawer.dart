import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:livtu/constants/routes.dart';
import 'package:livtu/services/auth/auth_service.dart';
import 'package:livtu/services/auth/bloc/auth_bloc.dart';
import 'package:livtu/services/profile/global_user_helper.dart';
import 'package:livtu/utils/dialogs/sign_out_dialog.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

Drawer getUniversalDrawer({required BuildContext context}) {

  Widget buildProfileImage(BuildContext context) {
    return FutureBuilder<String>(
      future: getIconURL(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return const Text('Error');
        } else {
          final iconURL = snapshot.data;
          return CircleAvatar(
            backgroundColor: Colors.grey.shade800,
            backgroundImage: NetworkImage(iconURL ?? ''),
          );
        }
      },
    );
  }

  return Drawer(
    child: ListView(
      padding: const EdgeInsets.all(0),
      children: [
        DrawerHeader(
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
          ),
          child: UserAccountsDrawerHeader(
            decoration: const BoxDecoration(color: Colors.teal),
            accountName: FutureBuilder<String>(
              future: getUserName(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return const Text('Error');
                } else {
                  String displayName = snapshot.data ?? 'username not set';
                  return Text(
                    displayName,
                    style: const TextStyle(fontSize: 18),
                  );
                }
              },
            ),
            accountEmail: Text(
              AuthService.firebase().currentUser?.email ??
                  AppLocalizations.of(context)!.notRegistered,
            ),
            currentAccountPictureSize: const Size.square(40),
            currentAccountPicture: buildProfileImage(context),
          ),
        ),
        ListTile(
          leading: const Icon(Icons.person),
          title: Text(AppLocalizations.of(context)!.profile),
          onTap: () {
            Navigator.pop(context);
            Navigator.of(context).pushNamed(profileRoute);
          },
        ),
        ListTile(
          leading: const Icon(Icons.monetization_on),
          title: Text(AppLocalizations.of(context)!.purchases),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        ListTile(
          leading: const Icon(Icons.badge_outlined),
          title: Text(AppLocalizations.of(context)!.becomeTutor),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        ListTile(
          leading: const Icon(Icons.help_outline),
          title: Text(AppLocalizations.of(context)!.support),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        ListTile(
          leading: const Icon(Icons.settings),
          title: Text(AppLocalizations.of(context)!.settings),
          onTap: () {
            Navigator.pop(context);
            Navigator.of(context).pushNamed(settingsRoute);
          },
        ),
        ListTile(
          leading: const Icon(Icons.logout),
          title: Text(AppLocalizations.of(context)!.signOut),
          onTap: () async {
            final logout = await showSignOutDialog(context);
            if (logout) {
              BlocProvider.of<AuthBloc>(context).add(
                const AuthLogoutEvent(),
              );
            }
            Navigator.pop(context);
          },
        ),
      ],
    ),
  );
}
