import 'package:get/get.dart';
import '../../data/models/network_response.dart';
import '../../data/services/network_caller.dart';
import '../../data/utils/urls.dart';

class UpdateProfileController extends GetxController {
  bool _updateProfileInProgress = false;

  bool get updateProfileInProgress => _updateProfileInProgress;

  Future<dynamic> updateProfile(
      String firstName, String lastName, String phone, String password) async {
    _updateProfileInProgress = true;
    update();
    final Map<String, dynamic> requestBody = {
      "firstName": firstName.trim(),
      "lastName": lastName.trim(),
      "mobile": phone.trim(),
      "photo": ""
    };
    if (password.isNotEmpty) {
      requestBody['password'] = password;
      final NetworkResponse response =
          await NetworkCaller().postRequest(Urls.updateProfile, requestBody);
      _updateProfileInProgress = false;
      update();
      if (response.isSuccess) {
        return true;
      } else {
        return false;
      }
    }
  }
}
