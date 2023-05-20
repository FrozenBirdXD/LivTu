import 'package:flutter/material.dart';
import 'package:livtu/views/drawer.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
      body: Center(
        child: Text(AppLocalizations.of(context)!.studyMaterial),
      ),
    );
  }
}
