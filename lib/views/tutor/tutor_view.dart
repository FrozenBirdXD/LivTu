import 'package:flutter/material.dart';
import 'package:livtu/views/drawer.dart';

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
        title: const Text('My Tutor'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text('Tutor'),
      ),
    );
  }
}