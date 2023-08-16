import 'package:get/get.dart';
import '../../data/models/network_response.dart';
import '../../data/services/network_caller.dart';
import '../../data/utils/urls.dart';

class OtpVerificationController extends GetxController {
  bool _otpVerificationInProgress = false;
  bool get otpVerificationInProgress => _otpVerificationInProgress;

  Future<bool> verifyOTP(String email, String otp) async {
    _otpVerificationInProgress = true;
    update();
    final NetworkResponse response = await NetworkCaller().getRequest(
      Urls.otpVerify(email, otp),
    );
    _otpVerificationInProgress = false;
    update();
    if (response.isSuccess) {
      return true;
    } else {
      return false;
    }
  }
}
