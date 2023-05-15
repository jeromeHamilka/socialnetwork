import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import '../custom_widget/profile_image.dart';
import '../model/Member.dart';
import '../model/color_theme.dart';
import '../model/member_comment.dart';
import '../util/firebase_handler.dart';

class CommentTile extends StatelessWidget {
  final MemberComment memberComment;

  const CommentTile({super.key, required this.memberComment});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
      stream:
          FirebaseHandler().fire_user.doc(memberComment.memberId).snapshots(),
      builder: (context, snap) {
        if (snap.hasData) {
          Member member = Member(snap.data!);
          return Column(
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      ProfileImage(
                          urlString: member.imageUrl ?? "", onPressed: (() {})),
                      Text("${member.surname} ${member.name}")
                    ],
                  ),
                  Text(
                    memberComment.date,
                    style: TextStyle(
                        color: ColorTheme().pointer(),
                        fontStyle: FontStyle.italic),
                  ),
                ],
              ),
              Center(
                child: Text(memberComment.text),
              ),
            ],
          );
        } else {
          return const SizedBox(height: 0, width: 0);
        }
      },
    );
  }
}
