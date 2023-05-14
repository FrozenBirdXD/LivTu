import 'package:flutter/material.dart';

class StudyMaterialView extends StatefulWidget {
  const StudyMaterialView({super.key});

  @override
  State<StudyMaterialView> createState() => _StudyMaterialViewState();
}

class _StudyMaterialViewState extends State<StudyMaterialView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Study Material'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text('Study Material'),
      ),
    );
  }
}
