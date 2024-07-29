import 'package:be_glamourous/components/cutom_app_bar.dart';
import 'package:flutter/material.dart';

class SkinAnalyzerPage extends StatefulWidget {
  const SkinAnalyzerPage({super.key});

  @override
  State<SkinAnalyzerPage> createState() => _SkinAnalyzerPageState();
}

class _SkinAnalyzerPageState extends State<SkinAnalyzerPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.transparent,
      appBar: CustomAppBar(),
    );
  }
}