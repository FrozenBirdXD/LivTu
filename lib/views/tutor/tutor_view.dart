import 'package:flutter/material.dart';
import 'package:livtu/views/drawer.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TutorView extends StatefulWidget {
  const TutorView({super.key});

  @override
  State<TutorView> createState() => _TutorViewState();
}

class _TutorViewState extends State<TutorView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: getUniversalDrawer(context: context),
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.myTutor),
        centerTitle: true,
      ),
      body: Center(
        child: Text(AppLocalizations.of(context)!.tutor),
      ),
    );
  }
}