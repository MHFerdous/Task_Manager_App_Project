import 'package:get/get.dart';
import '../../data/models/network_response.dart';
import '../../data/services/network_caller.dart';
import '../../data/utils/urls.dart';

class SignUpController extends GetxController {
  bool _signUpInProgress = false;
  bool get signUpProgress => _signUpInProgress;

  Future<bool> userSignUp(String email, String firstName, String lastName,
      String phone, String password) async {
    _signUpInProgress = true;
    update();
    final NetworkResponse response = await NetworkCaller().postRequest(
      Urls.registration,
      <String, dynamic>{
        "email": email,
        "firstName": firstName,
        "lastName": lastName,
        "mobile": phone,
        "password": password,
        "photo": ""
      },
    );
    _signUpInProgress = false;
    update();
    if (response.isSuccess) {
      return true;
    } else {
      return false;
    }
  }
}
