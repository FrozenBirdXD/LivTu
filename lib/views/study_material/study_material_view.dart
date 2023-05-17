import 'package:flutter/material.dart';
import 'package:livtu/views/drawer.dart';

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
        title: const Text('Study Material'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text('Study Material'),
      ),
    );
  }
}
