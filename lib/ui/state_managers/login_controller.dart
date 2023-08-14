import 'package:get/get.dart';
import '../../data/models/auth_utility.dart';
import '../../data/models/login_model.dart';
import '../../data/models/network_response.dart';
import '../../data/services/network_caller.dart';
import '../../data/utils/urls.dart';

class LoginController extends GetxController {
  bool _logInInProgress = false;
  bool get loginInProgress => _logInInProgress;
  Future<bool> login(String email, String password) async {
    _logInInProgress = true;
    update();

    Map<String, dynamic> requestBody = {
      "email": email,
      "password": password,
    };
    final NetworkResponse response = await NetworkCaller()
        .postRequest(Urls.login, requestBody, isLogin: true);
    _logInInProgress = false;
    update();
    if (response.isSuccess) {
      await AuthUtility.saveUserInfo(
        LoginModel.fromJson(response.body!),
      );
      return true;
    } else {
      return false;
    }
  }
}
