import 'package:flutter/material.dart';
import 'package:mobile_application/data/models/network_response.dart';
import 'package:mobile_application/data/models/task_list_model.dart';
import 'package:mobile_application/data/services/network_caller.dart';
import 'package:mobile_application/data/utils/urls.dart';
import 'package:mobile_application/ui/screens/add_new_task_screen.dart';
import 'package:mobile_application/ui/screens/update_task_bottom_sheet.dart';
import 'package:mobile_application/ui/screens/update_task_status_sheet.dart';
import 'package:mobile_application/ui/widgets/screen_background.dart';
import '../../data/models/taskModel.dart';
import '../widgets/dash_board_item.dart';
import '../widgets/task_list_tile.dart';
import '../widgets/user_profile_AppBar.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({Key? key}) : super(key: key);

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  bool _getNewTaskInProgress = false;

  TaskListModel _taskListModel = TaskListModel();
  TaskModel taskListModel = TaskModel();
  dynamic count1;
  dynamic count2;
  dynamic count3;
  dynamic count4;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      statusCount();
      getNewTask();
    });
  }

  Future<void> statusCount() async {
    final responseNewTask =
        await NetworkCaller().getRequest(Urls.updateNewTask);
    final getNewTaskModel = TaskModel.fromJson(responseNewTask.body!);

    setState(
      () {
        count1 = "${getNewTaskModel.data?.length ?? 0}";
      },
    );

    final responseInProgressTask =
        await NetworkCaller().getRequest(Urls.updateInProgressTask);
    final getProgressTaskModel =
        TaskModel.fromJson(responseInProgressTask.body!);
    setState(
      () {
        count4 = "${getProgressTaskModel.data?.length ?? 0}";
      },
    );

    final responseCancelledTask =
        await NetworkCaller().getRequest(Urls.updateCancelledTask);
    final getCaneTaskModel = TaskModel.fromJson(responseCancelledTask.body!);
    setState(
      () {
        count2 = "${getCaneTaskModel.data?.length ?? 0}";
      },
    );

    final responseCompletedTask =
        await NetworkCaller().getRequest(Urls.updateCompletedTask);
    final getCompletedTaskModel =
        TaskModel.fromJson(responseCompletedTask.body!);
    setState(
      () {
        count3 = "${getCompletedTaskModel.data?.length ?? 0}";
      },
    );
  }

  Future<void> getNewTask() async {
    _getNewTaskInProgress = true;
    if (mounted) {
      setState(() {});
    }
    final NetworkResponse response =
        await NetworkCaller().getRequest(Urls.newTask);
    if (response.isSuccess) {
      _taskListModel = TaskListModel.fromJson(response.body!);
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to load new task'),
          ),
        );
      }
    }
    _getNewTaskInProgress = false;
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
                        Navigator.pop(context);
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: DashBoardItem(
                      typeOfTask: 'New',
                      numberOfTask: count1,
                    ),
                  ),
                  Expanded(
                    child: DashBoardItem(
                      typeOfTask: 'In Progress',
                      numberOfTask: count4,
                    ),
                  ),
                  Expanded(
                    child: DashBoardItem(
                      typeOfTask: 'Cancelled',
                      numberOfTask: count2,
                    ),
                  ),
                  Expanded(
                    child: DashBoardItem(
                      typeOfTask: 'Completed',
                      numberOfTask: count3,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: RefreshIndicator(
                onRefresh: () async {
                  getNewTask();
                  statusCount();
                },
                child: _getNewTaskInProgress
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : ListView.separated(
                        itemCount: _taskListModel.data?.length ?? 0,
                        itemBuilder: (context, index) {
                          return TaskListTile(
                            data: _taskListModel.data![index],
                            onDeleteTap: () {
                              deleteTask(_taskListModel.data![index].sId!);
                            },
                            onEditTap: () {
                              //showEditBottomSheet(_taskListModel.data![index]);
                              showStatueUpdateBottomSheet(
                                  _taskListModel.data![index]);
                            },
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return const Divider(
                            color: Colors.grey,
                            height: 4,
                          );
                        },
                      ),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddNewTaskScreen(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void showEditBottomSheet(TaskData task) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return UpdateTaskBottomSheet(
          task: task,
          onUpdate: () {
            getNewTask();
          },
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
            getNewTask();
          },
        );
      },
    );
  }
}
