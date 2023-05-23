import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:livtu/constants/routes.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:livtu/services/auth/auth_service.dart';
import 'package:livtu/services/profile/global_user_service.dart';
import 'package:livtu/services/profile/global_user_helper.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final double coverHeight = 280;
  final double profileHeight = 160;
  GlobalUserService service = GlobalUserService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.profile),
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          buildTop(),
          buildProfile(),
          buildOptionButtons(),
        ],
      ),
    );
  }

  Widget buildProfile() {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 48,
      ),
      child: Column(
        children: [
          FutureBuilder<String>(
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
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                );
              }
            },
          ),
          Text(
            AuthService.firebase().currentUser?.email ??
                AppLocalizations.of(context)!.notRegistered,
          ),
          const Divider(
            height: 1,
          ),
          const SizedBox(
            height: 24,
          ),
        ],
      ),
    );
  }

  Stack buildTop() {
    final top = coverHeight - profileHeight / 2;
    final bottom = profileHeight / 2;

    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(
            bottom: bottom,
          ),
          child: buildCoverImage(),
        ),
        Positioned(
          top: top,
          child: GestureDetector(
            onTap: () {
              selectProfileImage();
            },
            child: buildProfileImage(context),
          ),
        ),
      ],
    );
  }

  selectProfileImage() async {
    final ImagePicker imagePicker = ImagePicker();
    final pickedImage =
        await imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      String imageURL = await service.uploadImageToStorage(pickedImage);
      service.updateIconURL(url: imageURL);
    }
  }

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
            radius: profileHeight / 2,
            backgroundColor: Colors.grey.shade800,
            backgroundImage: NetworkImage(iconURL ?? ''),
            child: Container(
              width: profileHeight,
              height: profileHeight,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.grey.shade100,
                  width: 5.0,
                ),
              ),
            ),
          );
        }
      },
    );
  }

  Container buildCoverImage() {
    return Container(
      color: Colors.grey,
      child: Image.network(
        'https://images.unsplash.com/photo-1464822759023-fed622ff2c3b?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1170&q=80',
        width: double.infinity,
        height: coverHeight,
        fit: BoxFit.cover,
      ),
    );
  }

  Center buildOptionButtons() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            AppLocalizations.of(context)!.profileOptions,
            style: const TextStyle(
              fontSize: 24,
            ),
          ),
          const SizedBox(
            height: 32,
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pushNamed(changeUsernameRoute);
            },
            child: Text(AppLocalizations.of(context)!.changeUsername),
          ),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pushNamed(changePasswordRoute);
            },
            child: Text(AppLocalizations.of(context)!.changePassword),
          ),
          const SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }
}
