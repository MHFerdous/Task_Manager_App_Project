import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_application/ui/state_managers/add_new_task_controller.dart';
import 'package:mobile_application/ui/widgets/user_profile_AppBar.dart';

class AddNewTaskScreen extends StatefulWidget {
  const AddNewTaskScreen({Key? key}) : super(key: key);

  @override
  State<AddNewTaskScreen> createState() => _AddNewTaskScreenState();
}

class _AddNewTaskScreenState extends State<AddNewTaskScreen> {
  final TextEditingController _titleTEController = TextEditingController();
  final TextEditingController _descriptionTEController =
      TextEditingController();

/*  bool _addNewTaskInProgress = false;

  Future<void> addNewTask() async {
    _addNewTaskInProgress = true;
    if (mounted) {
      setState(() {});
    }
    Map<String, dynamic> requestBody = {
      "title": _titleTEController.text.trim(),
      "description": _descriptionTEController.text.trim(),
      "status": "New"
    };

    final NetworkResponse response =
        await NetworkCaller().postRequest(Urls.createTask, requestBody);

    _addNewTaskInProgress = false;
    if (mounted) {
      setState(() {});
    }
    if (response.isSuccess) {
      _titleTEController.clear();
      _descriptionTEController.clear();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Task added successfully'),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.pop(context);
      }
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Task adding failed'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }*/

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const UserProfileAppBar(),
              Padding(
                padding: const EdgeInsets.all(14.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 50,
                      ),
                      Text('Add New Task',
                          style: Theme.of(context).textTheme.titleLarge),
                      const SizedBox(
                        height: 24,
                      ),
                      TextFormField(
                        textInputAction: TextInputAction.next,
                        controller: _titleTEController,
                        decoration: const InputDecoration(hintText: 'Title'),
                        validator: (String? value) {
                          if (value?.trim().isEmpty ?? true) {
                            return 'Please enter title';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      TextFormField(
                        textInputAction: TextInputAction.done,
                        controller: _descriptionTEController,
                        maxLines: 4,
                        decoration:
                            const InputDecoration(hintText: 'Description'),
                        validator: (String? value) {
                          if (value?.trim().isEmpty ?? true) {
                            return 'Please enter description';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      GetBuilder<AddNewTaskController>(
                        builder: (addNewTaskController) {
                          return SizedBox(
                            width: double.infinity,
                            child: Visibility(
                              visible:
                                  addNewTaskController.addNewTaskInProgress ==
                                      false,
                              replacement: const Center(
                                  child: CircularProgressIndicator()),
                              child: ElevatedButton(
                                onPressed: () {
                                  if (!_formKey.currentState!.validate()) {
                                    return;
                                  }
                                  addNewTaskController
                                      .addNewTask(
                                          _titleTEController.text.trim(),
                                          _descriptionTEController.text.trim())
                                      .then(
                                    (result) {
                                      if (result == true) {
                                        Get.back();
                                        Get.snackbar(
                                            'Success!', 'New task added');
                                      } else {
                                        Get.snackbar(
                                            'Fail!', 'Task adding failed');
                                      }
                                    },
                                  );
                                },
                                child: const Icon(
                                    Icons.arrow_forward_ios_outlined),
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
