import 'package:get/get.dart';

import '../../data/models/network_response.dart';
import '../../data/utils/urls.dart';

class SignUpController extends GetxController{

  bool _signUpInProgress = false;
bool get loginProgress => _signUpInProgress;

  Future<bool> userSignUp(String email, String firstName, String lastName, String phone, String password) async {
    _signUpInProgress = true;
    update();
    final NetworkResponse response =
    await NetworkCaller().postRequest(Urls.registration, <String, dynamic>{
      "email": email,
      "firstName": firstName,
      "lastName": lastName,
      "mobile": phone,
      "password": password,
      "photo": ""
    });
    _signUpInProgress = false;
    update();
    if (response.isSuccess) {
      _emailTEController.clear();
      _firstNameTEController.clear();
      _lastNameTEController.clear();
      _phoneTEController.clear();
      _phoneTEController.clear();
      _passwordTEController.clear();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Registration Successfully Done'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Registration Failed'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

}