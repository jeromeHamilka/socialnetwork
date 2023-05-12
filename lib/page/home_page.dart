import 'package:flutter/material.dart';

import '../model/Member.dart';

class HomePage extends StatefulWidget {
  final Member member;
  const HomePage({super.key, required this.member});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("Home Page"),
    );
  }
}
