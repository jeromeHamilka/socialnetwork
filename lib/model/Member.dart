import 'package:cloud_firestore/cloud_firestore.dart';
import '../util/constants.dart';

class Member {
  late String uid;
  late String name;
  late String surname;
  late String? imageUrl;
  late List<dynamic> followers;
  late List<dynamic> following;
  late DocumentReference<Map<String, dynamic>> ref;
  late String documentId;
  late String? description;

  Member(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    ref = snapshot.reference;
    uid = snapshot.id;
    Map<String, dynamic>? datas = snapshot.data();
    //print(datas);
    name = datas?[nameKey];
    surname = datas?[surnameKey];
    imageUrl = datas?[imageUrlKey];
    followers = datas?[followersKey];
    following = datas?[followingKey];
    description = datas?[descriptionKey];
  }

  Map<String, dynamic> toMap() {
    return {
      uidKey: uid,
      nameKey: name,
      surnameKey: surname,
      followingKey: following,
      followersKey: followers,
      imageUrlKey: imageUrl,
      descriptionKey: description,
    };
  }
}
