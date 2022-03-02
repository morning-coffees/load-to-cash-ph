import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  UserModel.empty();
  UserModel(
      {required this.messages,
      required this.displayName,
      required this.email,
      required this.photoUrl});

  UserModel.fromJson(Map<String, Object?> json)
      : this(
          messages: json['messages']! as List<dynamic>,
          displayName: json['display_name']! as String,
          email: json['email']! as String,
          photoUrl: json['photo_url']! as String,
        );

  late List<dynamic> messages;
  late String displayName;
  late String email;
  late String photoUrl;

  final ref = FirebaseFirestore.instance
      .collection('users')
      .withConverter<UserModel>(
        fromFirestore: (snapshot, _) => UserModel.fromJson(snapshot.data()!),
        toFirestore: (movie, _) => movie.toJson(),
      );

  Map<String, Object?> toJson() {
    return {
      'messages': messages,
      'display_name': displayName,
      'email': email,
      'photo_url': photoUrl,
    };
  }
}
