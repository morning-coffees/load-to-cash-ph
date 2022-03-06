import 'package:flutter/material.dart';

import '../theme.dart';

class UserProfileView extends StatelessWidget {
  final String imageUrl;
  final String displayName;

  const UserProfileView({
    Key? key,
    required this.imageUrl,
    required this.displayName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 40,
        ),
        CircleAvatar(
          radius: 50.0,
          backgroundImage: NetworkImage(imageUrl),
          backgroundColor: Colors.transparent,
        ),
        const SizedBox(
          height: 20,
        ),
        Text(
          displayName,
          style: TextStyle(fontSize: 20, color: whiteColor),
        ),
        const SizedBox(
          height: 30,
        ),
      ],
    );
  }
}
