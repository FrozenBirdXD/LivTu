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
                title: 'Mathematics',
                description:
                    'Expert guidance in Mathematics to strengthen foundational knowledge and excel academically.',
                buttonText: 'Learn More',
              ),
              SizedBox(height: 16.0),
              SubjectBox(
                title: 'English Language',
                description:
                    'Comprehensive support in English language skills, including reading, writing, and grammar.',
                buttonText: 'Learn More',
              ),
              SizedBox(height: 16.0),
              SubjectBox(
                title: 'Science',
                description:
                    'Specialized tutoring in various science subjects, including biology, chemistry, and physics.',
                buttonText: 'Learn More',
              ),
              SizedBox(height: 16.0),
              SubjectBox(
                title: 'Test Preparation (SAT/ACT)',
                description:
                    'Proven strategies and practice materials to excel in standardized tests like SAT and ACT.',
                buttonText: 'Learn More',
              ),
              SizedBox(height: 16.0),
              SubjectBox(
                title: 'Foreign Languages (Spanish/French)',
                description:
                    'Interactive language lessons to develop fluency and cultural understanding in Spanish or French.',
                buttonText: 'Learn More',
              ),
              SizedBox(height: 16.0),
              SubjectBox(
                title: 'Arts and Music',
                description:
                    'Creative tutoring for drawing, painting, music theory, and instrument instruction.',
                buttonText: 'Learn More',
              ),
              SizedBox(height: 16.0),
              SubjectBox(
                title: 'History',
                description:
                    'In-depth guidance in historical events, analysis, and critical thinking skills.',
                buttonText: 'Learn More',
              ),
              SizedBox(height: 16.0),
            ],
          ),
        ),
      ),
    );
  }
}
