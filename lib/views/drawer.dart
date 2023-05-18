import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:livtu/constants/routes.dart';
import 'package:livtu/services/auth/auth_service.dart';
import 'package:livtu/services/auth/bloc/auth_bloc.dart';
import 'package:livtu/utils/dialogs/sign_out_dialog.dart';

Drawer getUniversalDrawer({required BuildContext context}) {
  Random random = Random();
  int randomNumber = 100000 + random.nextInt(999999);
  String randomString = 'User$randomNumber';

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
            accountName: Text(
              AuthService.firebase().currentUser?.displayName ??
                  randomString,
              style: const TextStyle(fontSize: 18),
            ),
            accountEmail: Text(
              AuthService.firebase().currentUser?.email ?? 'Not registered',
            ),
            currentAccountPictureSize: const Size.square(40),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.teal.shade100,
              child: Text(
                AuthService.firebase().currentUser?.displayName?[0] ?? 'U',
                style: const TextStyle(
                  fontSize: 25.0,
                  color: Colors.teal,
                ),
              ), //Text
            ),
          ),
        ),
        ListTile(
          leading: const Icon(Icons.person),
          title: const Text(' My Profile'),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        ListTile(
          leading: const Icon(Icons.monetization_on),
          title: const Text(' Payments'),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        ListTile(
          leading: const Icon(Icons.badge_outlined),
          title: const Text(' Become Tutor'),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        ListTile(
          leading: const Icon(Icons.help_outline),
          title: const Text(' Help Center'),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        ListTile(
          leading: const Icon(Icons.settings),
          title: const Text(' Settings'),
          onTap: () {
            Navigator.pop(context);
            Navigator.of(context).pushNamed(settingsRoute);
          },
        ),
        ListTile(
          leading: const Icon(Icons.logout),
          title: const Text(' Log Out'),
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
