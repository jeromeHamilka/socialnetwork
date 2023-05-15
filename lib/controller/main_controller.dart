import 'package:flutter/material.dart';

import 'dart:async';
import '../custom_widget/bar_item.dart';
import '../model/Member.dart';
import '../model/color_theme.dart';
import '../page/home_page.dart';
import '../page/members_page.dart';
import '../page/notif_page.dart';
import '../page/profile_page.dart';
import '../page/write_post.dart';
import '../util/constants.dart';
import '../util/firebase_handler.dart';
import 'loading_controller.dart';

class MainController extends StatefulWidget {
  final String memberUid;

  const MainController({super.key, required this.memberUid});

  @override
  State<MainController> createState() => _MainControllerState();
}

class _MainControllerState extends State<MainController> {
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();
  late StreamSubscription streamSubscription;
  Member? member;
  int index = 0;

  @override
  void initState() {
    super.initState();
    //Récupère user a partir de uid
    streamSubscription = FirebaseHandler()
        .fire_user
        .doc(widget.memberUid)
        .snapshots()
        .listen((event) {
      setState(() {
        print("New Event => $event");
        member = Member(event);
      });
    });
  }

  @override
  void dispose() {
    streamSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return (member == null)
        ? const LoadingController()
        : Scaffold(
            key: _globalKey,
            body: showPage(),
            bottomNavigationBar: BottomAppBar(
              color: ColorTheme().accent(),
              shape: const CircularNotchedRectangle(),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  BarItem(
                      icon: homeIcon,
                      onPressed: (() => buttonSelected(0)),
                      selected: (index == 0)),
                  BarItem(
                      icon: friendsIcon,
                      onPressed: (() => buttonSelected(1)),
                      selected: (index == 1)),
                  const SizedBox(
                    width: 0,
                    height: 0,
                  ),
                  BarItem(
                      icon: notifIcon,
                      onPressed: (() => buttonSelected(2)),
                      selected: (index == 2)),
                  BarItem(
                      icon: profileIcon,
                      onPressed: (() => buttonSelected(3)),
                      selected: (index == 3))
                ],
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                _globalKey.currentState?.showBottomSheet((context) => WritePost(
                      memberId: widget.memberUid,
                    ));
              },
              child: writePost,
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
          );
  }

  buttonSelected(int index) {
    setState(() {
      this.index = index;
    });
  }

  Widget showPage() {
    switch (index) {
      case 0:
        return HomePage(member: member!);
      case 1:
        return MembersPage(member: member!);
      case 2:
        return NotifPage(member: member!);
      case 3:
        return ProfilePage(member: member!);
      default:
        return Container();
    }
  }
}
