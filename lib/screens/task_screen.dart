import 'package:flutter/material.dart';
import 'package:todo/blocs/bloc_exports.dart';
import 'package:todo/models/task.dart';
import 'package:todo/screens/add_task_screen.dart';
import 'package:todo/widgets/task_list.dart';

// ignore: must_be_immutable
class TaskScreen extends StatefulWidget {
  const TaskScreen({super.key});

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  _addTask(BuildContext context) {
    final shared = List.filled(13, []);
    shared[0].add(123);
    shared[1].add(3445);

    print(shared);

    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom + 50,
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
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Center(
                  child: Chip(
                    label: Text('Tasks: '),
                  ),
                ),
                TasksList(tasksList: tasksList),
              ],
            ),
          ),
          floatingActionButton: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FloatingActionButton(
                onPressed: () => {},
                tooltip: 'Test',
                child: const Icon(Icons.terminal_rounded),
              ),
              const SizedBox(height: 10),
              FloatingActionButton(
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
