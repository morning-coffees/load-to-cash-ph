import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  UserModel.empty();
  UserModel({required this.messages});

  UserModel.fromJson(Map<String, Object?> json)
      : this(
          messages: json['messages']! as List<String>,
        );

  late List<String> messages;

  final ref = FirebaseFirestore.instance
      .collection('users')
      .withConverter<UserModel>(
        fromFirestore: (snapshot, _) => UserModel.fromJson(snapshot.data()!),
        toFirestore: (movie, _) => movie.toJson(),
      );

  Map<String, Object?> toJson() {
    return {
      'messages': messages,
    };
  }
}
