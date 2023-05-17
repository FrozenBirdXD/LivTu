import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:livtu/constants/routes.dart';
import 'package:livtu/services/auth/auth_service.dart';
import 'package:livtu/services/auth/bloc/auth_bloc.dart';
import 'package:livtu/utils/dialogs/sign_out_dialog.dart';

Drawer getUniversalDrawer({required BuildContext context}) {
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
            accountName: const Text(
              'User 1234',
              style: TextStyle(fontSize: 18),
            ),
            accountEmail: Text(
              AuthService.firebase().currentUser?.email ?? 'Not registered',
            ),
            currentAccountPictureSize: const Size.square(50),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.teal.shade200,
              child: const Text(
                "U",
                style: TextStyle(fontSize: 30.0, color: Colors.blue),
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
