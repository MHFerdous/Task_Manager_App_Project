import 'package:get/get.dart';
import '../../data/models/network_response.dart';
import '../../data/services/network_caller.dart';
import '../../data/utils/urls.dart';

class CancelledTaskController extends GetxController {
  bool _getProgressTaskCancelled = false;
  bool get getProgressTaskCancelled => _getProgressTaskCancelled;

  Future<bool> getCancelledTask() async {
    _getProgressTaskCancelled = true;
    update();
    final NetworkResponse response =
        await NetworkCaller().getRequest(Urls.cancelledTask);
    _getProgressTaskCancelled = false;
    update();
    if (response.isSuccess) {
      return true;
    } else {
      return false;
    }
  }
}
