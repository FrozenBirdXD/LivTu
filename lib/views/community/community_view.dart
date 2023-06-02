import 'package:flutter/material.dart';
import 'package:livtu/services/profile/box_widget.dart';
import 'package:livtu/services/profile/global_user.dart';
import 'package:livtu/services/profile/global_user_service.dart';
import 'package:livtu/views/drawer.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CommunityView extends StatefulWidget {
  const CommunityView({super.key});

  @override
  State<CommunityView> createState() => _CommunityViewState();
}

class _CommunityViewState extends State<CommunityView> {
  final GlobalUserService globalUserService = GlobalUserService();
  CommunitySelect _select = CommunitySelect.tutors;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: getUniversalDrawer(context: context),
      appBar: AppBar(
        title: const Text('Community'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _select = CommunitySelect.tutors;
                    });
                  },
                  child: const Text('Tutors'),
                ),
                const SizedBox(
                  width: 20,
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _select = CommunitySelect.students;
                    });
                  },
                  child: const Text('Students'),
                ),
              ],
            ),
          ),
          Expanded(
            child: buildCommunity(),
          ),
        ],
      ),
    );
  }

  Widget buildCommunity() {
    if (_select == CommunitySelect.tutors) {
      return StreamBuilder<List<GlobalUser>>(
        stream: globalUserService.getAllTutorGlobalUsers(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text('Error');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasData) {
            final users = snapshot.data!;

            return ListView.builder(
              itemCount: users.length,
              itemBuilder: (BuildContext context, int index) {
                final user = users[index];
                return Card(
                  color: Colors.teal.shade50,
                  margin: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 8.0,
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(16),
                    leading: CircleAvatar(
                      backgroundColor: Colors.grey.shade800,
                      radius: 30.0,
                      backgroundImage: NetworkImage(user.iconURL ??
                          'https://firebasestorage.googleapis.com/v0/b/livtu-flutter.appspot.com/o/profile_images%2Fdefault%20icon.png?alt=media&token=c33ce1c3-f961-4c3e-ae7d-41da985659d9'),
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.teal.shade200,
                            width: 2,
                          ),
                        ),
                      ),
                    ),
                    title: Row(
                      children: [
                        Text(
                          user.displayName ?? 'Username not set',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          width: 6,
                        ),
                        Visibility(
                          visible: user.isTutor ?? false,
                          child: const Tooltip(
                            triggerMode: TooltipTriggerMode.tap,
                            message: 'Certified Tutor',
                            child: Icon(
                              Icons.verified_rounded,
                              color: Colors.teal,
                            ),
                          ),
                        ),
                      ],
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          user.description ?? 'No description available',
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 14.0,
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              Wrap(
                                spacing: 8,
                                runSpacing: 8,
                                children: user.subjects!.map((subject) {
                                  return Box(
                                    subject: subject,
                                    fontSize: 12.0,
                                  );
                                }).toList(),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    onTap: () {
                      // Handle user profile view here
                      // You can navigate to a new page or show a dialog with the user's details
                    },
                    trailing: const Icon(
                      Icons.message,
                      color: Colors.teal,
                    ),
                  ),
                );
              },
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      );
    } else if (_select == CommunitySelect.students) {
      return StreamBuilder<List<GlobalUser>>(
        stream: globalUserService.getAllStudentsGlobalUsers(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text('Error');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasData) {
            final users = snapshot.data!;

            return ListView.builder(
              itemCount: users.length,
              itemBuilder: (BuildContext context, int index) {
                final user = users[index];
                return Card(
                  color: Colors.teal.shade50,
                  margin: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 8.0,
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(16),
                    leading: CircleAvatar(
                      backgroundColor: Colors.grey.shade800,
                      radius: 30.0,
                      backgroundImage: NetworkImage(user.iconURL ??
                          'https://firebasestorage.googleapis.com/v0/b/livtu-flutter.appspot.com/o/profile_images%2Fdefault%20icon.png?alt=media&token=c33ce1c3-f961-4c3e-ae7d-41da985659d9'),
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.teal.shade200,
                            width: 2,
                          ),
                        ),
                      ),
                    ),
                    title: Row(
                      children: [
                        Text(
                          user.displayName ?? 'Username not set',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          width: 6,
                        ),
                        Visibility(
                          visible: user.isTutor ?? false,
                          child: const Tooltip(
                            triggerMode: TooltipTriggerMode.tap,
                            message: 'Certified Tutor',
                            child: Icon(
                              Icons.verified_rounded,
                              color: Colors.teal,
                            ),
                          ),
                        ),
                      ],
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          user.description ?? 'No description available',
                          style: const TextStyle(
                            fontSize: 14.0,
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              Wrap(
                                spacing: 8,
                                runSpacing: 8,
                                children: user.subjects!.map((subject) {
                                  return Box(
                                    subject: subject,
                                    fontSize: 12.0,
                                  );
                                }).toList(),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    onTap: () {
                      // Handle user profile view here
                      // You can navigate to a new page or show a dialog with the user's details
                    },
                    trailing: const Icon(
                      Icons.message,
                      color: Colors.teal,
                    ),
                  ),
                );
              },
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      );
    } else {
      return const Text('Error');
    }
  }
}

enum CommunitySelect { tutors, students }
