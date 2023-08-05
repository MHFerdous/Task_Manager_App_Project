import 'package:flutter/material.dart';
import 'package:mobile_application/data/models/task_list_model.dart';

class TaskListTile extends StatelessWidget {
  final VoidCallback onDeleteTap, onEditTap;
  const TaskListTile({
    super.key,
    required this.data,
    required this.onDeleteTap,
    required this.onEditTap,
  });
  final TaskData data;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        title: Text(data.title ?? 'Unknown'),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(data.description ?? ''),
            Text(data.createdDate ?? ''),
            Row(
              children: [
                Chip(
                  label: Text(
                    data.status ?? 'New',
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  backgroundColor: Colors.teal,
                ),
                const Spacer(),
                IconButton(
                  onPressed: onEditTap,
                  icon: Icon(
                    Icons.edit,
                    color: Colors.green.shade500,
                  ),
                ),
                IconButton(
                  onPressed: onDeleteTap,
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
