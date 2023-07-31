import 'package:flutter/material.dart';
import 'package:mobile_application/data/models/task_list_model.dart';

class TaskListTile extends StatelessWidget {
  const TaskListTile({
    super.key,
    required this.data,
  });
  final TaskData data;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        title: Text(data.title!),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(data.description!),
            Text(data.createdDate!),
            Row(
              children: [
                const Chip(
                  label: Text(
                    'New',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  backgroundColor: Colors.teal,
                ),
                const Spacer(),
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.edit,
                    color: Colors.green.shade500,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.delete_forever_outlined,
                    color: Colors.red,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
