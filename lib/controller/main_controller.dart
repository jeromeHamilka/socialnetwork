import 'package:flutter/material.dart';
import 'dart:async';

import '../model/Member.dart';
import '../util/firebase_handler.dart';
import 'package:socialnetwork/util/adduser.dart';

import 'loading_controller.dart';

class MainController extends StatefulWidget {
  final String memberUid;
  const MainController({super.key, required this.memberUid});

  @override
  State<MainController> createState() => _MainControllerState();
}

class _MainControllerState extends State<MainController> {
  late StreamSubscription streamSubscription;
  Member? member;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //Récupère user a partir de uid
    streamSubscription = FirebaseHandler()
        .fire_user
        .doc(widget.memberUid)
        .snapshots()
        .listen((event) {
      setState(() {
        //print("I got a member");
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
            appBar: AppBar(
              title: const Text("Salut"),
            ),
            body: Center(
              child: Text("Salut je suis ${member?.surname} ${member?.name}"),
            ),
          );
  }
}
