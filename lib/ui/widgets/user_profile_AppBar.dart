import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mobile_application/data/models/auth_utility.dart';
import 'package:mobile_application/ui/screens/update_profile_screen.dart';

class UserProfileAppBar extends StatefulWidget {
  final bool? isUpdateScreen;

  const UserProfileAppBar({
    super.key,
    this.isUpdateScreen,
  });

  @override
  State<UserProfileAppBar> createState() => _UserProfileAppBarState();
}

class _UserProfileAppBarState extends State<UserProfileAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.teal,
      title: GestureDetector(
        onTap: () {
          if ((widget.isUpdateScreen ?? false) == false) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const UpdateProfileScreen(),
              ),
            );
          }
        },
        child: Row(
          children: [
            Visibility(
              visible: (widget.isUpdateScreen ?? false) == false,
              child: Row(
                children: [
                  CachedNetworkImage(
                    placeholder: (_, __) =>
                        const Icon(Icons.account_circle_rounded),
                    imageUrl: AuthUtility.userInfo.data?.photo ?? '',
                    errorWidget: (_, __, ___) =>
                        const Icon(Icons.account_circle_rounded),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${AuthUtility.userInfo.data?.firstName ?? "Couldn't load"} ${AuthUtility.userInfo.data?.lastName ?? ''}',
                  style: const TextStyle(
                    fontSize: 13,
                    color: Colors.white,
                  ),
                ),
                Text(
                  AuthUtility.userInfo.data?.email ?? "Couldn't load",
                  style: const TextStyle(
                    fontSize: 11,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
