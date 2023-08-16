import 'package:get/get.dart';
import '../../data/models/network_response.dart';
import '../../data/services/network_caller.dart';
import '../../data/utils/urls.dart';

class ResetPasswordController extends GetxController {
  bool _resetPasswordInProgress = false;
  bool get resetPasswordInProgress => _resetPasswordInProgress;

  Future<bool> resetPassword(String email, String otp, String password) async {
    _resetPasswordInProgress = true;
    update();

    final Map<String, dynamic> requestBody = {
      "email": email,
      "OTP": otp,
      "password": password,
    };

    final NetworkResponse response =
        await NetworkCaller().postRequest(Urls.resetPassword, requestBody);
    _resetPasswordInProgress = false;
    update();
    if (response.isSuccess) {
      return true;
    } else {
      return false;
    }
  }
}
