import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:livtu/services/profile/global_user.dart';
import 'package:livtu/services/profile/box_widget.dart';

class CommunityProfileView extends StatefulWidget {
  final GlobalUser user;
  const CommunityProfileView({super.key, required this.user});

  @override
  State<CommunityProfileView> createState() => _CommunityProfileViewState();
}

class _CommunityProfileViewState extends State<CommunityProfileView> {
  final double coverHeight = 280;
  final double profileHeight = 160;

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
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                widget.user.displayName ?? 'Username not set',
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                width: 6,
              ),
              getVerifyTutorIcon(),
            ],
          ),
          const SizedBox(
            height: 30.0,
          ),
          Column(
            children: [
              const Text(
                'Subjects',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: widget.user.subjects!.map((subject) {
                        return Box(
                          subject: subject,
                          fontSize: 16,
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              )
            ],
          ),
          Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(8.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Description',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 8.0,
                ),
                Text(
                  widget.user.description ?? 'No description available',
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
              ],
            ),
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
          child: buildProfileImage(context),
        ),
      ],
    );
  }

  Widget buildProfileImage(BuildContext context) {
    return CircleAvatar(
      radius: profileHeight / 2,
      backgroundColor: Colors.grey.shade800,
      backgroundImage: NetworkImage(widget.user.iconURL ??
          'https://firebasestorage.googleapis.com/v0/b/livtu-flutter.appspot.com/o/profile_images%2Fdefault%20icon.png?alt=media&token=c33ce1c3-f961-4c3e-ae7d-41da985659d9'),
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
  }

  Widget getVerifyTutorIcon() {
    final isTutor = widget.user.isTutor ?? false;
    if (isTutor) {
      return const Tooltip(
        triggerMode: TooltipTriggerMode.tap,
        message: 'Certified Tutor',
        child: Icon(
          Icons.verified_rounded,
          color: Colors.teal,
        ),
      );
    }

    return Container();
  }

  Widget buildCoverImage() {
    return Container(
      color: Colors.grey,
      child: Image.network(
        widget.user.photoURL ??
            'https://firebasestorage.googleapis.com/v0/b/livtu-flutter.appspot.com/o/profile_background%2Fdefault%20background.jpg?alt=media&token=58b786f3-b1a3-4f56-8ccd-9b9969b0a520',
        width: double.infinity,
        height: coverHeight,
        fit: BoxFit.cover,
      ),
    );
  }
}
