import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'constants.dart';

class FirebaseHandler {
  //Auth
  final authInstance = FirebaseAuth.instance;

  //Connexion
  Future<User?> signIn(String mail, String pwd) async {
    final userCredential = await authInstance.signInWithEmailAndPassword(
        email: mail, password: pwd);
    final User? user = userCredential.user;
    return user;
  }

  //Création user
  Future<User?> createUser(
      String mail, String pwd, String name, String surname) async {
    final userCredential = await authInstance.createUserWithEmailAndPassword(
        email: mail, password: pwd);
    final User? user = userCredential.user;
    if (user != null) {
      Map<String, dynamic> memberMap = {
        nameKey: name,
        surnameKey: surname,
        imageUrlKey: "",
        followersKey: [user.uid],
        followingKey: [],
        uidKey: user.uid
      };
      //AddUser;
      addUserToFirebase(memberMap);
    }

    return user;
  }

  //Database
  //CollectionReference member = FirebaseFirestore.instance.collection('member');

  static final firestoreInstance = FirebaseFirestore.instance;
  final fire_user = firestoreInstance.collection(memberRef);
  //final fire_notif = firestoreInstance.collection("notification");

  addUserToFirebase(Map<String, dynamic> map) {
    fire_user.doc(map[uidKey]).set(map);
  }
  // Future<void> addUserToFirebase() {
  //   return member.
  //   add({
  //     nameKey: name,
  //     surnameKey: surname,
  //     imageUrlKey: "",
  //     followersKey: [user.uid],
  //     followingKey: [],
  //     uidKey: user.uid,
  //   })
  // }
}
