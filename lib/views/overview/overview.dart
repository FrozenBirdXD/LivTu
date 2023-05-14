import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:livtu/services/auth/bloc/auth_bloc.dart';
import 'package:livtu/utils/dialogs/sign_out_dialog.dart';

class Overview extends StatefulWidget {
  const Overview({super.key});

  @override
  State<Overview> createState() => _OverviewState();
}

class _OverviewState extends State<Overview> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
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
                  "User 1234",
                  style: TextStyle(fontSize: 18),
                ),
                accountEmail: const Text("example@gmail.com"),
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
              leading: const Icon(Icons.edit),
              title: const Text(' Edit Profile'),
              onTap: () {
                Navigator.pop(context);
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
      ),
      appBar: AppBar(
        title: const Text('LivTu'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text('Overview'),
      ),
    );
  }
}
