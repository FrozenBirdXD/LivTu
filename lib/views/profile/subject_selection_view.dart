import 'package:flutter/material.dart';
import 'package:livtu/services/profile/global_user_service.dart';

class SubjectSelectionView extends StatefulWidget {
  final List<String> availableSubjects;
  const SubjectSelectionView({super.key, required this.availableSubjects});

  @override
  State<SubjectSelectionView> createState() => _SubjectSelectionViewState();
}

class _SubjectSelectionViewState extends State<SubjectSelectionView> {
  List<String> selectedSubjects = [];

  @override
  Widget build(BuildContext context) {
    final availableSubjectsWithBlank = [...widget.availableSubjects, ''];
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Subjects'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: availableSubjectsWithBlank.length,
        itemBuilder: (context, index) {
          final subject = availableSubjectsWithBlank[index];
          final isSelected = selectedSubjects.contains(subject);

          if (subject.isEmpty) {
            return Container(
              height: 60,
            );
          }

          return ListTile(
            title: Text(subject),
            trailing: Checkbox(
              value: isSelected,
              onChanged: (value) {
                setState(() {
                  if (value == true) {
                    selectedSubjects.add(subject);
                  } else {
                    selectedSubjects.remove(subject);
                  }
                });
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          List<String> allSubjects = await combineSubjects(selectedSubjects);
          GlobalUserService().updateSubjects(subjects: allSubjects);
          Navigator.pop(context);
        },
        child: const Icon(Icons.check),
      ),
    );
  }

  Future<List<String>> combineSubjects(List<String> selectedSubjects) async {
    List<String> savedSubjects =
        await GlobalUserService().getSubjectsStream().first;
    List<String> allSubjects = [...selectedSubjects, ...savedSubjects];
    return allSubjects;
  }
}
