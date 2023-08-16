import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile_application/ui/state_managers/update_profile_controller.dart';
import 'package:mobile_application/ui/widgets/screen_background.dart';
import 'package:mobile_application/ui/widgets/user_profile_AppBar.dart';
import '../../data/models/auth_utility.dart';
import '../../data/models/login_model.dart';
import 'auth/login_screen.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({Key? key}) : super(key: key);

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  UserData userData = AuthUtility.userInfo.data!;

  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _firstNameTEController = TextEditingController();
  final TextEditingController _lastNameTEController = TextEditingController();
  final TextEditingController _phoneTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  XFile? imageFile;
  ImagePicker picker = ImagePicker();

  //bool _updateProfileInProgress = false;

  @override
  void initState() {
    super.initState();
    _emailTEController.text = userData.email ?? '';
    _firstNameTEController.text = userData.firstName ?? '';
    _lastNameTEController.text = userData.lastName ?? '';
    _phoneTEController.text = userData.mobile ?? '';
  }

  /* Future<void> updateProfile() async {
    _updateProfileInProgress = true;
    if (mounted) {
      setState(() {});
    }
    final Map<String, dynamic> requestBody = {
      "firstName": _firstNameTEController.text.trim(),
      "lastName": _lastNameTEController.text.trim(),
      "mobile": _phoneTEController.text.trim(),
      "photo": ""
    };
    if (_passwordTEController.text.isNotEmpty) {
      requestBody['password'] = _passwordTEController.text;
    }
    final NetworkResponse response =
        await NetworkCaller().postRequest(Urls.updateProfile, requestBody);
    _updateProfileInProgress = false;
    if (mounted) {
      setState(() {});
    }
    if (response.isSuccess) {
      userData.firstName = _firstNameTEController.text.trim();
      userData.lastName = _lastNameTEController.text.trim();
      userData.mobile = _phoneTEController.text.trim();
      AuthUtility.updateUserInfo(userData);

      _passwordTEController.clear();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Profile updated successfully'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Profile updated failed'),
          ),
        );
      }
    }
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const UserProfileAppBar(
                isUpdateScreen: true,
              ),
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.all(14.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Update Profile',
                          style: Theme.of(context).textTheme.titleLarge),
                      const SizedBox(
                        height: 24,
                      ),
                      InkWell(
                        onTap: () {
                          selectImage();
                        },
                        child: Container(
                          width: double.infinity,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                          ),
                          child: Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(16),
                                color: Colors.grey,
                                child: const Text('Photo'),
                              ),
                              const SizedBox(
                                width: 16,
                              ),
                              Visibility(
                                visible: imageFile != null,
                                child: Text(imageFile?.name ?? ''),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      TextFormField(
                        textInputAction: TextInputAction.next,
                        controller: _emailTEController,
                        readOnly: true,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                          hintText: 'Email',
                        ),
                        validator: (String? value) {
                          if (value?.trim().isEmpty ?? true) {
                            return 'Please enter your email';
                          }
                          if (!RegExp(
                                  r"^[a-zA-Z0-9.a-zA-Z0-9!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(value!)) {
                            return 'Enter a valid email';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      TextFormField(
                        textInputAction: TextInputAction.next,
                        controller: _firstNameTEController,
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                          hintText: 'First name',
                        ),
                        validator: (String? value) {
                          if ((value?.isEmpty ?? true) || value!.length < 3) {
                            return 'Enter your first name';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      TextFormField(
                        textInputAction: TextInputAction.next,
                        controller: _lastNameTEController,
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                          hintText: 'Last name',
                        ),
                        validator: (String? value) {
                          if ((value?.isEmpty ?? true) || value!.length < 3) {
                            return 'Enter your last name';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      TextFormField(
                        textInputAction: TextInputAction.next,
                        controller: _phoneTEController,
                        keyboardType: TextInputType.phone,
                        decoration: const InputDecoration(
                          hintText: 'Phone',
                        ),
                        validator: (String? value) {
                          if (value?.isEmpty ?? true) {
                            return 'Enter your phone number';
                          }
                          if (value!.length < 11 || value.length > 11) {
                            return 'Enter a valid phone number';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      TextFormField(
                        textInputAction: TextInputAction.done,
                        controller: _passwordTEController,
                        obscureText: true,
                        decoration: const InputDecoration(
                          hintText: 'Password',
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      GetBuilder<UpdateProfileController>(
                        builder: (updateProfileController) {
                          return SizedBox(
                            width: double.infinity,
                            child: updateProfileController
                                    .updateProfileInProgress
                                ? const Center(
                                    child: CircularProgressIndicator(),
                                  )
                                : ElevatedButton(
                                    onPressed: () {
                                      if (!_formKey.currentState!.validate()) {
                                        return;
                                      }

                                      updateProfileController
                                          .updateProfile(
                                        _firstNameTEController.text.trim(),
                                        _lastNameTEController.text.trim(),
                                        _phoneTEController.text.trim(),
                                        _passwordTEController.text,
                                      )
                                          .then(
                                        (result) {
                                          if (result == true) {
                                            userData.firstName =
                                                _firstNameTEController.text
                                                    .trim();
                                            userData.lastName =
                                                _lastNameTEController.text
                                                    .trim();
                                            userData.mobile =
                                                _phoneTEController.text.trim();
                                            AuthUtility.updateUserInfo(
                                                userData);

                                            _passwordTEController.clear();

                                            Get.snackbar('Success!',
                                                'Profile updated successfully');
                                          }
                                        },
                                      );
                                    },
                                    child: const Icon(
                                        Icons.arrow_forward_ios_outlined),
                                  ),
                          );
                        },
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: 42,
                        child: ElevatedButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  elevation: 4,
                                  shadowColor: Colors.grey,
                                  //titlePadding: const EdgeInsets.all(10),
                                  title: const Text(
                                    'Logging out...',
                                    style: TextStyle(
                                        fontSize: 23,
                                        fontWeight: FontWeight.normal),
                                  ),
                                  content: const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                      'Are you sure?',
                                      style: TextStyle(
                                        fontSize: 20,
                                      ),
                                    ),
                                  ),
                                  actions: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        TextButton(
                                          onPressed: () async {
                                            await AuthUtility.clearUserInfo();
                                            if (mounted) {
                                              Navigator.pushAndRemoveUntil(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        const LoginScreen(),
                                                  ),
                                                  (route) => false);
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                const SnackBar(
                                                  content: Text('Logged out'),
                                                  backgroundColor: Colors.green,
                                                ),
                                              );
                                            }
                                          },
                                          child: const Text(
                                            'Yes',
                                            style: TextStyle(
                                              color: Colors.red,
                                            ),
                                          ),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            Get.back();
                                          },
                                          child: const Text(
                                            'No',
                                            style:
                                                TextStyle(color: Colors.black),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                  contentPadding: const EdgeInsets.all(15),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                );
                              },
                            );
                          },
                          child: const Text('Logout'),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void selectImage() {
    picker.pickImage(source: ImageSource.gallery).then(
      (xFile) {
        if (xFile != null) {
          imageFile = xFile;
          if (mounted) {
            setState(() {});
          }
        }
      },
    );
  }
}
