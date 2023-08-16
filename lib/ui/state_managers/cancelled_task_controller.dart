import 'package:get/get.dart';
import '../../data/models/network_response.dart';
import '../../data/models/task_list_model.dart';
import '../../data/services/network_caller.dart';
import '../../data/utils/urls.dart';

class CancelledTaskController extends GetxController {
  bool _getProgressTaskCancelled = false;
  bool get getProgressTaskCancelled => _getProgressTaskCancelled;

   TaskListModel _taskListModel = TaskListModel();
   TaskListModel get taskListModel => _taskListModel;

  Future<bool> getCancelledTask() async {
    _getProgressTaskCancelled = true;
    update();
    final NetworkResponse response =
        await NetworkCaller().getRequest(Urls.cancelledTask);
    _getProgressTaskCancelled = false;
    if (response.isSuccess) {
      _taskListModel = TaskListModel.fromJson(response.body!);
      update();
      return true;
    } else {
      update();
      return false;
    }
  }
}
