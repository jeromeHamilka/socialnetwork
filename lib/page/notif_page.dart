import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../model/Member.dart';
import '../model/inside_notif.dart';
import '../tile/notif_tile.dart';
import '../util/firebase_handler.dart';

class NotifPage extends StatefulWidget {
  final Member member;

  const NotifPage({super.key, required this.member});

  @override
  State<StatefulWidget> createState() => NotifState();
}

class NotifState extends State<NotifPage> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseHandler()
          .fire_notif
          .doc(FirebaseHandler().authInstance.currentUser!.uid)
          .collection("InsideNotif")
          .snapshots(),
      builder: (context, snapshots) {
        if (snapshots.hasData) {
          final datas = snapshots.data!.docs;
          return ListView.separated(
              itemBuilder: (ctx, index) {
                return NotifTile(notif: InsideNotif(datas[index]));
              },
              separatorBuilder: (ctx, index) {
                return const Divider();
              },
              itemCount: datas.length);
        } else {
          return const Center(
            child: Text("Aucune notif"),
          );
        }
      },
    );
  }
}
