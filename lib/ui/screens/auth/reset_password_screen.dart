import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_application/ui/screens/auth/login_screen.dart';
import 'package:mobile_application/ui/widgets/screen_background.dart';
import '../../state_managers/reset_password_controller.dart';

class ResetPasswordScreen extends StatefulWidget {
  final String email, otp;
  const ResetPasswordScreen({Key? key, required this.email, required this.otp})
      : super(key: key);

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final TextEditingController _passwordTEController = TextEditingController();
  final TextEditingController _confirmPasswordTEController =
      TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

/*  bool _resetPasswordInProgress = false;

  Future<void> resetPassword() async {
    _resetPasswordInProgress = true;
    if (mounted) {
      setState(() {});
    }

    final Map<String, dynamic> requestBody = {
      "email": widget.email,
      "OTP": widget.otp,
      "password": _passwordTEController.text
    };

    final NetworkResponse response =
        await NetworkCaller().postRequest(Urls.resetPassword, requestBody);
    _resetPasswordInProgress = false;
    if (mounted) {
      setState(() {});
    }
    if (response.isSuccess) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Password reset successful'),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const LoginScreen(),
            ),
            (route) => false);
      }
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Password reset failed'),
            backgroundColor: Colors.red,
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
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 150,
                    ),
                    Text(
                      'Set Password',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(
                      height: 7,
                    ),
                    Text(
                      'Minimum length password 63 character with letter and number combination',
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(color: Colors.grey),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    TextFormField(
                      textInputAction: TextInputAction.next,
                      controller: _passwordTEController,
                      //obscureText: true,
                      decoration: const InputDecoration(
                        hintText: 'Password',
                      ),
                      validator: (String? value) {
                        if (value?.isEmpty ?? true) {
                          return 'Please enter your password';
                        }
                        if (value!.length < 6) {
                          return 'Password must be at least 6 letters';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    TextFormField(
                      textInputAction: TextInputAction.done,
                      controller: _confirmPasswordTEController,
                      //obscureText: true,
                      decoration: const InputDecoration(
                        hintText: 'Confirm Password',
                      ),
                      validator: (String? value) {
                        if (value?.isEmpty ?? true) {
                          return 'Please enter your password';
                        } else if (value != _passwordTEController.text) {
                          return 'Password must be same';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    GetBuilder<ResetPasswordController>(
                      builder: (resetPasswordController) {
                        return SizedBox(
                          width: double.infinity,
                          child: Visibility(
                            visible: resetPasswordController
                                    .resetPasswordInProgress ==
                                false,
                            replacement: const Center(
                              child: CircularProgressIndicator(),
                            ),
                            child: ElevatedButton(
                              onPressed: () {
                                if (!_formKey.currentState!.validate()) {
                                  return;
                                }
                                Get.snackbar('Success!',
                                    'Password reset successfully done');
                                Get.offAll(
                                  const LoginScreen(),
                                );
                              },
                              child: const Text('Confirm'),
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Have an account?",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.5,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Get.offAll(
                              const LoginScreen(),
                            );
                          },
                          /*Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const LoginScreen(),
                                ),
                                (route) => false);
                          },*/
                          child: const Text(
                            'Sign in',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
