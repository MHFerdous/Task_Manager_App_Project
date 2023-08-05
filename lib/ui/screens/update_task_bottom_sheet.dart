import 'package:flutter/material.dart';
import '../../data/models/network_response.dart';
import '../../data/models/task_list_model.dart';
import '../../data/services/network_caller.dart';
import '../../data/utils/urls.dart';

class UpdateTaskBottomSheet extends StatefulWidget {
  final TaskData task;

  final VoidCallback onUpdate;
  const UpdateTaskBottomSheet(
      {super.key, required this.task, required this.onUpdate});
  @override
  State<UpdateTaskBottomSheet> createState() => _UpdateTaskBottomSheetState();
}

class _UpdateTaskBottomSheetState extends State<UpdateTaskBottomSheet> {
  late TextEditingController _titleTEController;

  late TextEditingController _descriptionTEController;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _updateTaskInProgress = false;

  @override
  void initState() {
    _titleTEController = TextEditingController(text: widget.task.title);
    _descriptionTEController =
        TextEditingController(text: widget.task.description);
    super.initState();
  }

  Future<void> updateTask() async {
    _updateTaskInProgress = true;
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

    _updateTaskInProgress = false;
    if (mounted) {
      setState(() {});
    }
    if (response.isSuccess) {
      _titleTEController.clear();
      _descriptionTEController.clear();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Task updated successfully'),
          ),
        );
      }
      widget.onUpdate();
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Task updating failed'),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text('Update Task',
                        style: Theme.of(context).textTheme.titleLarge),
                    const Spacer(),
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.close_outlined),
                    ),
                  ],
                ),
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
                  decoration: const InputDecoration(hintText: 'Description'),
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
                SizedBox(
                  width: double.infinity,
                  child: Visibility(
                    visible: _updateTaskInProgress == false,
                    replacement:
                        const Center(child: CircularProgressIndicator()),
                    child: ElevatedButton(
                      onPressed: () {
                        if (!_formKey.currentState!.validate()) {
                          return;
                        }
                        updateTask();
                      },
                      child: const Icon(Icons.arrow_forward_ios_outlined),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
