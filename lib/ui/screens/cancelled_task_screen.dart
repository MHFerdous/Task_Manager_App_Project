import 'package:flutter/material.dart';
import 'package:mobile_application/data/models/task_list_model.dart';
import 'package:mobile_application/ui/screens/update_task_status_sheet.dart';
import 'package:mobile_application/ui/widgets/screen_background.dart';
import '../../data/models/network_response.dart';
import '../../data/services/network_caller.dart';
import '../../data/utils/urls.dart';
import '../widgets/task_list_tile.dart';
import '../widgets/user_profile_AppBar.dart';

class CancelledTaskScreen extends StatefulWidget {
  const CancelledTaskScreen({Key? key}) : super(key: key);

  @override
  State<CancelledTaskScreen> createState() => _CancelledTaskScreenState();
}

class _CancelledTaskScreenState extends State<CancelledTaskScreen> {
  bool _getProgressTaskCancelled = false;

  TaskListModel _taskListModel = TaskListModel();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        getCancelledTask();
      },
    );
  }

  Future<void> getCancelledTask() async {
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
  }

  Future<void> deleteTask(String taskId) async {
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
                      }
                    } else {
                      if (mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Task deletion failed'),
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
                    Navigator.pop(context);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
        child: Column(
          children: [
            const UserProfileAppBar(),
            Expanded(
              child: RefreshIndicator(
                onRefresh: () async {
                  getCancelledTask();
                },
                child: _getProgressTaskCancelled
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : ListView.separated(
                        itemCount: _taskListModel.data?.length ?? 0,
                        itemBuilder: (context, index) {
                          return TaskListTile(
                            data: _taskListModel.data![index],
                            onEditTap: () {
                              showStatueUpdateBottomSheet(
                                  _taskListModel.data![index]);
                            },
                            onDeleteTap: () {
                              deleteTask(_taskListModel.data![index].sId!);
                            },
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return const Divider(
                            height: 4,
                          );
                        },
                      ),
              ),
            )
          ],
        ),
      ),
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
            getCancelledTask();
          },
        );
      },
    );
  }
}
