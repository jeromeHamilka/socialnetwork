import 'package:flutter/material.dart';

import '../model/Member.dart';

class NotifPage extends StatefulWidget {
  final Member member;
  const NotifPage({super.key, required this.member});

  @override
  State<NotifPage> createState() => _NotifPageState();
}

class _NotifPageState extends State<NotifPage> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("Notif Page"),
    );
  }
}
