import 'package:flutter/material.dart';
import 'package:livtu/views/drawer.dart';

class Overview extends StatefulWidget {
  const Overview({super.key});

  @override
  State<Overview> createState() => _OverviewState();
}

class _OverviewState extends State<Overview> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: getUniversalDrawer(context: context),
      appBar: AppBar(
        title: const Text('LivTu'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text('Overview'),
      ),
    );
  }
}
