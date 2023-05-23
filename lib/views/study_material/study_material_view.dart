import 'package:flutter/material.dart';
import 'package:livtu/views/drawer.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:livtu/views/study_material/subject_box.dart';

class StudyMaterialView extends StatefulWidget {
  const StudyMaterialView({super.key});

  @override
  State<StudyMaterialView> createState() => _StudyMaterialViewState();
}

class _StudyMaterialViewState extends State<StudyMaterialView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: getUniversalDrawer(context: context),
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.studyMaterial),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: const SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SubjectBox(
                title: 'Box 1',
                description: 'This is the first box.',
                buttonText: 'Button 1',
              ),
              SizedBox(height: 16.0),
              SubjectBox(
                title: 'Box 2',
                description: 'This is the second box.',
                buttonText: 'Button 2',
              ),
              SizedBox(height: 16.0),
              SubjectBox(
                title: 'Box 3',
                description: 'This is the third box.',
                buttonText: 'Button 3',
              ),
              SizedBox(height: 16.0),
              SubjectBox(
                title: 'Box 4',
                description: 'This is the fourth box.',
                buttonText: 'Button 4',
              ),
              SizedBox(height: 16.0),
              SubjectBox(
                title: 'Box 5',
                description: 'This is the fifth box.',
                buttonText: 'Button 5',
              ),
              SizedBox(height: 16.0),
              SubjectBox(
                title: 'Box 6',
                description: 'This is the sixth box.',
                buttonText: 'Button 6',
              ),
              SizedBox(height: 16.0),
              SubjectBox(
                title: 'Box 7',
                description: 'This is the seventh box.',
                buttonText: 'Button 7',
              ),
              SizedBox(height: 16.0),
            ],
          ),
        ),
      ),
    );
  }
}
