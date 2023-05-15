import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../util/constants.dart';

class OnePost extends StatefulWidget {
  const OnePost({Key? key}) : super(key: key);

  @override
  State<OnePost> createState() => _OnePostState();
}

class _OnePostState extends State<OnePost> {
  static final firestoreInstance = FirebaseFirestore.instance;
  final fire_user = firestoreInstance.collection(memberRef);
  final Stream<QuerySnapshot> _postStream =
      FirebaseFirestore.instance.collection('member').snapshots();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _postStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        }

        return ListView(
          children: snapshot.data!.docs.map((DocumentSnapshot document) {
            Map<String, dynamic> data =
                document.data()! as Map<String, dynamic>;
            print("data: $data");
            return ListTile(
              title: Text(data['surname']),
              subtitle: Text(data['name']),
            );
          }).toList(),
        );
      },
    );
  }
}
