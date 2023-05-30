import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:livtu/constants/routes.dart';
import 'package:livtu/services/auth/auth_service.dart';
import 'package:livtu/services/auth/bloc/auth_bloc.dart';
import 'package:livtu/services/profile/global_user_service.dart';
import 'package:livtu/utils/dialogs/sign_out_dialog.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

Drawer getUniversalDrawer({required BuildContext context}) {
  final GlobalUserService userService = GlobalUserService();

  Widget buildProfileImage(BuildContext context) {
    return StreamBuilder<String>(
      stream: userService.getIconURLStream(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }

        if (snapshot.hasError) {
          return const Text('Error');
        }

        String iconURL = snapshot.data ?? '';
        if (iconURL == '') {
          iconURL =
              'https://firebasestorage.googleapis.com/v0/b/livtu-flutter.appspot.com/o/profile_images%2Fdefault%20icon.png?alt=media&token=c33ce1c3-f961-4c3e-ae7d-41da985659d9';
        }
        return CircleAvatar(
          backgroundColor: Colors.grey.shade800,
          backgroundImage: NetworkImage(iconURL),
        );
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
            accountName: StreamBuilder<String>(
              stream: userService.getDisplayNameStream(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return const Text('Error');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Text('Loading...');
                }

                String displayName = snapshot.data ?? '';
                if (displayName == '') {
                  displayName = 'Username not set';
                }

                return Text(
                  displayName,
                  style: const TextStyle(fontSize: 18),
                );
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
            Navigator.of(context).pushNamed(becomeTutorRoute);
          },
        ),
        ListTile(
          leading: const Icon(Icons.help_outline),
          title: Text(AppLocalizations.of(context)!.support),
          onTap: () {
            Navigator.pop(context);
            Navigator.of(context).pushNamed(supportRoute);
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
