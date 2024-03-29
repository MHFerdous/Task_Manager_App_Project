import 'package:flutter/material.dart';
import 'package:mobile_application/ui/screens/cancelled_task_screen.dart';
import 'package:mobile_application/ui/screens/completed_task_screen.dart';
import 'package:mobile_application/ui/screens/in_progress_task_screen.dart';
import 'package:mobile_application/ui/screens/new_task_screen.dart';

class BottomNavBaseScreen extends StatefulWidget {
  const BottomNavBaseScreen({Key? key}) : super(key: key);

  @override
  State<BottomNavBaseScreen> createState() => _BottomNavBaseScreenState();
}

class _BottomNavBaseScreenState extends State<BottomNavBaseScreen> {
  int _selectedScreenIndex = 0;
  final List<Widget> _screens = const [
    NewTaskScreen(),
    InProgressTaskScreen(),
    CancelledTaskScreen(),
    CompletedTaskScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedScreenIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedScreenIndex,
        unselectedItemColor: Colors.grey,
        unselectedLabelStyle: const TextStyle(
          color: Colors.grey,
        ),
        showUnselectedLabels: true,
        selectedItemColor: Colors.teal,
        onTap: (int index) {
          _selectedScreenIndex = index;
          if (mounted) {
            setState(() {});
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.task_outlined),
            label: 'New',
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.access_time_filled_outlined),
              label: 'In Progress'),
          BottomNavigationBarItem(
              icon: Icon(Icons.cancel_outlined), label: 'Cancelled'),
          BottomNavigationBarItem(
              icon: Icon(Icons.done_outlined), label: 'Completed'),
        ],
      ),
    );
  }
}
