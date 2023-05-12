import 'package:flutter/material.dart';

import '../model/Member.dart';

class ProfilePage extends StatefulWidget {
  final Member member;
  const ProfilePage({super.key, required this.member});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("Profile Page"),
    );
  }
}
