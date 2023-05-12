import 'package:flutter/material.dart';

import '../model/Member.dart';

class MembersPage extends StatefulWidget {
  final Member member;
  const MembersPage({super.key, required this.member});

  @override
  State<MembersPage> createState() => _MembersPageState();
}

class _MembersPageState extends State<MembersPage> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("Members Page"),
    );
  }
}
