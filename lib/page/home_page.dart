import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../model/Member.dart';
import '../model/color_theme.dart';
import '../model/post.dart';
import '../tile/post_tile.dart';
import '../util/constants.dart';
import '../util/firebase_handler.dart';
import '../util/images.dart';

class HomePage extends StatefulWidget {
  final Member member;

  const HomePage({super.key, required this.member});

  @override
  State<StatefulWidget> createState() => HomeState();
}

class HomeState extends State<HomePage> {
  late StreamSubscription streamSubscription;
  List<Member> members = [];
  List<Post> posts = [];

  @override
  void initState() {
    setupStream();
    super.initState();
  }

  @override
  void dispose() {
    streamSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool scrolled) {
        return [
          SliverAppBar(
            pinned: true,
            expandedHeight: 200,
            backgroundColor: ColorTheme().pointer(),
            flexibleSpace: FlexibleSpaceBar(
              title: const Text("Fil d'actualité"),
              background: Image(
                image: AssetImage(homeImage),
                fit: BoxFit.cover,
              ),
            ),
          )
        ];
      },
      body: ListView.builder(
        itemCount: posts.length,
        itemBuilder: (BuildContext ctx, int index) {
          Post post = posts[index];
          Member member =
              members.singleWhere((element) => element.uid == post.memberId);
          return PostTile(post: post, member: member);
        },
      ),
    );
  }

  setupStream() {
    streamSubscription = FirebaseHandler()
        .fire_user
        .where(followersKey, arrayContains: widget.member.uid)
        .snapshots()
        .listen((event) {
      getMembers(event.docs);
      event.docs.forEach((docs) {
        docs.reference.collection("post").snapshots().listen((newPost) {
          print("J'ai un nouvel élément qui vient d'arriver !!!");
          setState(() {
            posts = getPosts(newPost.docs);
          });
        });
      });
    });
  }

  listenToPost(Post post) {
    post.ref.snapshots().listen((changes) {
      Post postTochange =
          posts.singleWhere((element) => element.documentId == post.documentId);
      posts.remove(postTochange);
      posts.add(post);
      posts.sort((a, b) => b.date.compareTo(a.date));
      setState(() {});
    });
  }

  getMembers(List<DocumentSnapshot> membersDoc) {
    List<Member> membersLists = members;
    membersDoc.forEach((memberSnapshot) {
      Member newMember = Member(memberSnapshot);
      if (membersLists.every((element) => element.uid != newMember.uid)) {
        membersLists.add(newMember);
      } else {
        Member toBeUpdated =
            membersLists.singleWhere((element) => element.uid == newMember.uid);
        membersLists.remove(toBeUpdated);
        membersLists.add(toBeUpdated);
      }
    });
    setState(() {
      members = membersLists;
    });
  }

  List<Post> getPosts(List<DocumentSnapshot> snapshot) {
    List<Post> newList = posts;
    snapshot.forEach((element) {
      Post newPost = Post(element);
      listenToPost(newPost);
      if (newList.every((post) => post.documentId != newPost.documentId)) {
        newList.add(newPost);
      } else {
        Post toBeUpdated = newList.singleWhere(
            (existing) => existing.documentId == newPost.documentId);
        newList.remove(toBeUpdated);
        newList.add(toBeUpdated);
      }
    });
    newList.sort((a, b) => b.date.compareTo(a.date));
    return newList;
  }
}
