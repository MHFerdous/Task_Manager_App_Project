import 'package:flutter/material.dart';
import 'package:mobile_application/data/models/auth_utility.dart';
import 'package:mobile_application/ui/screens/update_profile_screen.dart';

class UserProfileBanner extends StatefulWidget {
  final bool? isUpdateScreen;

  const UserProfileBanner({
    super.key,
    this.isUpdateScreen,
  });

  @override
  State<UserProfileBanner> createState() => _UserProfileBannerState();
}

class _UserProfileBannerState extends State<UserProfileBanner> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
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
      contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
      tileColor: Colors.teal,
      leading: CircleAvatar(
        backgroundImage: NetworkImage(
          AuthUtility.userInfo.data?.photo ?? '',
        ),
        onBackgroundImageError: (_, __) {
          const Icon(Icons.image);
        },
        radius: 16,
      ),
      title: Text(
        '${AuthUtility.userInfo.data?.firstName ?? "Couldn't load"} ${AuthUtility.userInfo.data?.lastName ?? ''}',
        style: const TextStyle(
          fontSize: 13,
          color: Colors.white,
        ),
      ),
      subtitle: Text(
        AuthUtility.userInfo.data?.email ?? "Couldn't load",
        style: const TextStyle(
          fontSize: 11,
          color: Colors.white,
        ),
      ),
    );
  }
}
