import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../custom_widget/profile_image.dart';
import '../model/Member.dart';
import '../model/color_theme.dart';
import '../util/firebase_handler.dart';
import '../util/images.dart';
import 'profile_page.dart';

class MembersPage extends StatefulWidget {
  final Member member;

  const MembersPage({super.key, required this.member});

  @override
  State<StatefulWidget> createState() => MembersState();
}

class MembersState extends State<MembersPage> {
  @override
  Widget build(BuildContext context) {
    String myId = FirebaseHandler().authInstance.currentUser!.uid;
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseHandler().fire_user.snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasData) {
          return NestedScrollView(
              headerSliverBuilder: (BuildContext context, bool scrolled) {
                return [
                  SliverAppBar(
                    pinned: true,
                    expandedHeight: 200,
                    backgroundColor: ColorTheme().pointer(),
                    flexibleSpace: FlexibleSpaceBar(
                      title: const Text("Liste des utilisateurs"),
                      background: Image(
                        image: AssetImage(eventsImage),
                        fit: BoxFit.cover,
                      ),
                    ),
                  )
                ];
              },
              body: ListView.separated(
                  itemBuilder: (BuildContext ctx, int index) {
                    final list = snapshot.data!.docs;
                    final memberMap = list[index];
                    final member = Member(memberMap);
                    return ListTile(
                      leading: ProfileImage(
                          urlString: member.imageUrl ?? "", onPressed: (() {})),
                      title: Text(
                        "${member.surname} ${member.name}",
                        style: TextStyle(color: ColorTheme().textColor()),
                      ),
                      trailing: TextButton(
                          onPressed: () {
                            FirebaseHandler().addOrRemoveFollow(member);
                          },
                          child: (myId == member.uid)
                              ? const SizedBox(
                                  width: 0,
                                  height: 0,
                                )
                              : Text((member.followers!.contains(myId)
                                  ? "Ne plus suivre"
                                  : "Suivre"))),
                      onTap: () {
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (BuildContext ctx) {
                          return Scaffold(body: ProfilePage(member: member));
                        }));
                      },
                    );
                  },
                  separatorBuilder: (BuildContext ctx, int index) {
                    return const Divider();
                  },
                  itemCount: snapshot.data!.docs.length));
        } else {
          return const Center(
            child: Text("Aucun utilisateur sur cette app"),
          );
        }
      },
    );
  }
}
