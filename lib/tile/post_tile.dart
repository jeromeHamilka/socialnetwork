import 'package:flutter/material.dart';
import 'package:socialnetwork/custom_widget/padding_with.dart';
import 'package:socialnetwork/util/constants.dart';

import '../custom_widget/post_content.dart';
import '../model/Member.dart';
import '../model/alert_helper.dart';
import '../model/color_theme.dart';
import '../model/post.dart';
import '../page/detail_page.dart';
import '../util/firebase_handler.dart';

class PostTile extends StatelessWidget {
  final Post post;
  final Member member;
  final bool isDetail;

  const PostTile({
    super.key,
    required this.post,
    required this.member,
    this.isDetail = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (!isDetail) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext ctx) {
                return DetailPage(post: post, member: member);
              },
            ),
          );
        }
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 5),
        child: Card(
          color: ColorTheme().base(),
          shadowColor: ColorTheme().pointer(),
          elevation: 5,
          child: PaddingWith(
            child: Column(
              children: [
                PostContent(post: post, member: member),
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                        icon: (post.likes.contains(
                                FirebaseHandler().authInstance.currentUser!.uid)
                            ? likeIcon
                            : unlikeIcon),
                        onPressed: () {
                          FirebaseHandler().addOrRemoveLike(post,
                              FirebaseHandler().authInstance.currentUser!.uid);
                        }),
                    Text("${post.likes.length} likes"),
                    IconButton(
                        icon: commentIcon,
                        onPressed: () {
                          AlertHelper().writeAComment(context,
                              post: post,
                              commentController: TextEditingController(),
                              member: member);
                        }),
                    Text("${post.comments.length} commentaires")
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
