import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  MessageModel.empty();
  MessageModel({
    required this.title,
    required this.users,
  });

  MessageModel.fromJson(Map<String, Object?> json)
      : this(
          users: json['users']! as List<dynamic>,
          title: json['title']! as String,
        );

  late List<dynamic> users;
  late String title;

  final ref = FirebaseFirestore.instance
      .collection('messages')
      .withConverter<MessageModel>(
        fromFirestore: (snapshot, _) => MessageModel.fromJson(snapshot.data()!),
        toFirestore: (movie, _) => movie.toJson(),
      );

  Map<String, Object?> toJson() {
    return {
      'users': users,
      'title': title,
    };
  }
}
