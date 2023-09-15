import 'package:flutter/material.dart';
import 'package:todo/models/task.dart';
import 'package:todo/screens/my_drawer.dart';
import 'package:todo/widgets/task_list.dart';
import 'package:todo/blocs/bloc_exports.dart';
import 'package:todo/screens/add_task_screen.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({super.key});

  static const id = 'tasks_screen';

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  _addTask(BuildContext context) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: const AddTaskScreen(),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TasksBloc, TasksState>(
      builder: (context, state) {
        List<Task> tasksList = state.allTasks;

        return Scaffold(
          extendBody: true,
          appBar: AppBar(
            title: const Text('widget.title'),
            actions: [
              IconButton(
                onPressed: () => _addTask(context),
                icon: const Icon(Icons.add),
              )
            ],
          ),
          drawer: const MyDrawer(),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Chip(
                  label: Text('Tasks: ${tasksList.length}'),
                ),
              ),
              TasksList(tasksList: tasksList),
            ],
          ),
          floatingActionButton: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FloatingActionButton(
                heroTag: '1',
                onPressed: () => {},
                tooltip: 'Test',
                child: const Icon(Icons.terminal_rounded),
              ),
              const SizedBox(height: 10),
              FloatingActionButton(
                heroTag: '2',
                onPressed: () => _addTask(context),
                tooltip: 'Add Task',
                child: const Icon(Icons.add),
              ),
            ],
          ),
        );
      },
    );
  }
}
