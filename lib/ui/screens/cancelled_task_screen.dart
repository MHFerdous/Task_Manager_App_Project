import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_application/data/models/task_list_model.dart';
import 'package:mobile_application/ui/screens/update_task_status_sheet.dart';
import 'package:mobile_application/ui/state_managers/cancelled_task_controller.dart';
import 'package:mobile_application/ui/state_managers/delete_task_controller.dart';
import 'package:mobile_application/ui/widgets/screen_background.dart';
import '../widgets/task_list_tile.dart';
import '../widgets/user_profile_AppBar.dart';

class CancelledTaskScreen extends StatefulWidget {
  const CancelledTaskScreen({Key? key}) : super(key: key);

  @override
  State<CancelledTaskScreen> createState() => _CancelledTaskScreenState();
}

class _CancelledTaskScreenState extends State<CancelledTaskScreen> {
  final CancelledTaskController cancelledTaskController =
      Get.find<CancelledTaskController>();



  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        cancelledTaskController.getCancelledTask();
      },
    );
  }

/*  Future<void> getCancelledTask() async {
    _getProgressTaskCancelled = true;
    if (mounted) {
      setState(() {});
    }
    final NetworkResponse response =
        await NetworkCaller().getRequest(Urls.cancelledTask);
    if (response.isSuccess) {
      _taskListModel = TaskListModel.fromJson(response.body!);
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to load cancelled task'),
          ),
        );
      }
    }
    _getProgressTaskCancelled = false;
    if (mounted) {
      setState(() {});
    }
  }*/

/*  Future<void> deleteTask(String taskId) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Deleting...',
            style: TextStyle(fontSize: 23, fontWeight: FontWeight.normal),
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
                    final NetworkResponse response =
                        await NetworkCaller().getRequest(
                      Urls.deleteTask(taskId),
                    );
                    if (response.isSuccess) {
                      _taskListModel.data!
                          .removeWhere((element) => element.sId == taskId);
                      if (mounted) {
                        setState(() {});
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Task Deleted successfully'),
                            backgroundColor: Colors.green,
                          ),
                        );
                      }
                    } else {
                      if (mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Task deletion failed'),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
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
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ],
            )
          ],
          contentPadding: const EdgeInsets.all(15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        );
      },
    );
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
        child: Column(
          children: [
            const UserProfileAppBar(),
            GetBuilder<CancelledTaskController>(
              builder: (cancelledTaskController) {
                if (cancelledTaskController.getProgressTaskCancelled) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return Expanded(
                  child: RefreshIndicator(
                    onRefresh: () async {
                      cancelledTaskController.getCancelledTask();
                    },
                    child: cancelledTaskController.getProgressTaskCancelled
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : ListView.separated(
                            itemCount: cancelledTaskController
                                    .taskListModel.data?.length ??
                                0,
                            itemBuilder: (context, index) {
                              return TaskListTile(
                                data: cancelledTaskController
                                    .taskListModel.data![index],
                                onEditTap: () {
                                  showStatueUpdateBottomSheet(
                                      cancelledTaskController
                                          .taskListModel.data![index]);
                                },
                                onDeleteTap: () {
                                  //deleteTask(_taskListModel.data![index].sId!);

                                  deleteTask(index);
                                },
                              );
                            },
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return const Divider(
                                height: 4,
                              );
                            },
                          ),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }

  void deleteTask(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Deleting...',
            style: TextStyle(fontSize: 23, fontWeight: FontWeight.normal),
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
                GetBuilder<DeleteTaskController>(
                  builder: (deleteTaskController) {
                    return TextButton(
                      onPressed: () {
                        deleteTaskController
                            .deleteTask(cancelledTaskController
                                .taskListModel.data![index].sId!)
                            .then(
                          (result) {
                            cancelledTaskController.getProgressTaskCancelled;
                            if (result == true) {
                              Get.back();
                              Get.snackbar(
                                  'Success!', 'Task Deleted successfully');
                            } else {
                              Get.snackbar('Failed!', 'Task deletion failed');
                            }
                          },
                        );
                      },
                      child: const Text(
                        'Yes',
                        style: TextStyle(
                          color: Colors.red,
                        ),
                      ),
                    );
                  },
                ),
                TextButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: const Text(
                    'No',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ],
            )
          ],
          contentPadding: const EdgeInsets.all(15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        );
      },
    );
  }

  void showStatueUpdateBottomSheet(TaskData task) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return UpdateTaskStatusSheet(
          task: task,
          onUpdate: () {
            CancelledTaskController;
          },
        );
      },
    );
  }
}
