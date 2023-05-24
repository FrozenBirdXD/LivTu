import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:livtu/constants/routes.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:livtu/services/auth/auth_service.dart';
import 'package:livtu/services/profile/global_user_service.dart';

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
          StreamBuilder<String>(
            stream: service.getDisplayNameStream(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const Text('Error');
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Text('Loading...');
              }

              final displayName = snapshot.data ?? '';
              return Text(
                displayName,
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              );
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
          child: GestureDetector(
            onTap: () {
              selectProfileBackground();
            },
            child: buildCoverImage(),
          ),
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
      String imageURL = await service.uploadProfileIconToStorage(pickedImage);
      service.updateIconURL(url: imageURL);
    }
  }

  selectProfileBackground() async {
    final ImagePicker imagePicker = ImagePicker();
    final pickedImage =
        await imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      String imageURL =
          await service.uploadProfileBackgroundToStorage(pickedImage);
      service.updatePhotoURL(url: imageURL);
    }
  }

  Widget buildProfileImage(BuildContext context) {
    return StreamBuilder<String>(
      stream: service.getIconURLStream(),
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
          radius: profileHeight / 2,
          backgroundColor: Colors.grey.shade800,
          backgroundImage: NetworkImage(iconURL),
          child: Container(
            width: profileHeight,
            height: profileHeight,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.grey.shade100,
                width: 5.0,
                strokeAlign: 0,
              ),
            ),
          ),
        );
      },
    );
  }

  Widget buildCoverImage() {
    return StreamBuilder<String>(
        stream: service.getPhotoURLStream(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
              color: Colors.grey,
              width: double.infinity,
              height: coverHeight,
              child: const CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Container(
              color: Colors.grey,
              width: double.infinity,
              height: coverHeight,
              child: const Text('Error'),
            );
          }

          String photoURL = snapshot.data ?? '';
          if (photoURL == '') {
            photoURL =
                'https://firebasestorage.googleapis.com/v0/b/livtu-flutter.appspot.com/o/profile_background%2Fdefault%20background.jpg?alt=media&token=58b786f3-b1a3-4f56-8ccd-9b9969b0a520';
          }

          return Container(
            color: Colors.grey,
            child: Image.network(
              photoURL,
              width: double.infinity,
              height: coverHeight,
              fit: BoxFit.cover,
            ),
          );
        });
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
