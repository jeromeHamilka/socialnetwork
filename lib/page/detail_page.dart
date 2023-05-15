import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../model/Member.dart';
import '../model/member_comment.dart';
import '../model/post.dart';
import '../tile/comment_tile.dart';
import '../tile/post_tile.dart';
import '../util/constants.dart';

class DetailPage extends StatefulWidget {
  final Post post;
  final Member member;

  const DetailPage({
    super.key,
    required this.post,
    required this.member,
  });

  @override
  State<StatefulWidget> createState() => DetailState();
}

class DetailState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Détail du post")),
      body: StreamBuilder<DocumentSnapshot>(
        stream: widget.post.ref.snapshots(),
        builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snaps) {
          //return Text(snaps.data?.data().toString() ?? "");
          List<MemberComment> comments = [];
          //final datas = snaps.data!.data() as Map<String, dynamic>;
          //final List<Map<String, dynamic>> commentsSnap = datas[commentKey];
          late final datas = snaps.data?.data() as Map<String, dynamic>;
          if (snaps.data != null) {
            final List<dynamic> commentsSnap = datas[commentKey];
            for (var s in commentsSnap) {
              comments.add(MemberComment(s));
            }
          }
          return ListView.separated(
            itemBuilder: (context, index) {
              if (index == 0) {
                return PostTile(
                  post: widget.post,
                  member: widget.member,
                  isDetail: true,
                );
              } else {
                MemberComment comment = comments[index - 1];
                return CommentTile(memberComment: comment);
              }
            },
            separatorBuilder: (context, index) {
              return const Divider();
            },
            itemCount: comments.length + 1,
          );
        },
      ),
    );
  }
}
