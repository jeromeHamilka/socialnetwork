import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../model/Member.dart';
import '../model/post.dart';
import '../util/date_handler.dart';
import 'padding_with.dart';
import 'profile_image.dart';

class PostContent extends StatelessWidget {
  final Post post;
  final Member member;

  const PostContent({
    super.key,
    required this.post,
    required this.member,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            ProfileImage(urlString: member.imageUrl ?? "", onPressed: (() {})),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("${member.surname} ${member.name}"),
                Text(DateHandler().myDate(post.date))
              ],
            )
          ],
        ),
        const Divider(),
        (post.imageUrl != "")
            ? PaddingWith(
                child: Container(
                width: MediaQuery.of(context).size.width * 0.85,
                height: MediaQuery.of(context).size.width * 0.85,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  image: DecorationImage(
                      image: CachedNetworkImageProvider(post.imageUrl),
                      fit: BoxFit.cover),
                ),
              ))
            : const SizedBox(
                height: 0,
                width: 0,
              ),
        (post.text != "")
            ? Text(post.text)
            : const SizedBox(
                height: 0,
                width: 0,
              ),
      ],
    );
  }
}
