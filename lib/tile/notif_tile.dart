import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../custom_widget/profile_image.dart';
import '../model/Member.dart';
import '../model/color_theme.dart';
import '../model/inside_notif.dart';
import '../model/post.dart';
import '../page/detail_page.dart';
import '../page/profile_page.dart';
import '../util/constants.dart';
import '../util/firebase_handler.dart';

class NotifTile extends StatelessWidget {
  final InsideNotif notif;

  const NotifTile({super.key, required this.notif});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
        stream: FirebaseHandler().fire_user.doc(notif.userId).snapshots(),
        builder: (context, snap) {
          if (snap.hasData) {
            Member member = Member(snap.data!);
            return InkWell(
                onTap: () {
                  FirebaseHandler().seenNotif(notif);
                  if (notif.type == follow) {
                    Navigator.push(context, MaterialPageRoute(builder: (build) {
                      return Scaffold(body: ProfilePage(member: member));
                    }));
                  } else {
                    notif.aboutRef.get().then((value) {
                      Post post = Post(value);
                      Navigator.push(context,
                          MaterialPageRoute(builder: (build) {
                        return DetailPage(post: post, member: member);
                      }));
                    });
                  }
                },
                child: Container(
                  color: (notif.seen)
                      ? ColorTheme().base()
                      : ColorTheme().accent(),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Row(
                            children: [
                              ProfileImage(
                                  urlString: member.imageUrl ?? "",
                                  onPressed: (() {})),
                              Text("${member.surname} ${member.name}")
                            ],
                          ),
                          Text(notif.date)
                        ],
                      ),
                      Center(
                        child: Text(notif.text),
                      )
                    ],
                  ),
                ));
          } else {
            return const Center(child: Text("Aucune données"));
          }
        });
  }
}
