import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/models/task.dart';
import 'package:todo_app/models/task_database.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Read all tasks
    readTasks();
  }

  // Create a task
  void createTask() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: TextField(
          controller: textController,
          decoration: const InputDecoration(hintText: 'Enter task'),
        ),
        actions: [
          // create button
          MaterialButton(
            onPressed: () {
              // add to database
              context.read<TaskDatabase>().createTask(textController.text);

              // clear text field
              textController.clear();

              // pop dialog box
              Navigator.pop(context);
            },
            child: const Text('Create'),
          )
        ],
      ),
    );
  }

  // Read all tasks
  void readTasks() {
    context.read<TaskDatabase>().fetchTasks();
  }

  // Update a task
  void updateTask(Task task) {
    textController.text = task.text;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Update task'),
        content: TextField(controller: textController),
        actions: [
          // update button
          MaterialButton(
            onPressed: () {
              // update task
              context
                  .read<TaskDatabase>()
                  .updateTask(task.id, textController.text);

              // clear text field
              textController.clear();

              // pop dialog box
              Navigator.pop(context);
            },
            child: const Text('Update'),
          )
        ],
      ),
    );
  }

  // Delete a task
  void deleteTask(int id) {
    context.read<TaskDatabase>().deleteTask(id);
  }

  @override
  Widget build(BuildContext context) {
    // Task database
    final taskDatabase = context.watch<TaskDatabase>();

    // Current tasks
    List<Task> currentTasks = taskDatabase.currentTasks;

    return Scaffold(
      appBar: AppBar(title: const Text('Tasks')),
      body: ListView.builder(
        itemCount: currentTasks.length,
        itemBuilder: (context, index) {
          // Get the task
          final task = currentTasks[index];

          // List tile for each task
          return ListTile(
              title: Text(task.text),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // update button
                  IconButton(
                    onPressed: () => updateTask(task),
                    icon: const Icon(Icons.edit),
                  ),

                  // delete button
                  IconButton(
                    onPressed: () => deleteTask(task.id),
                    icon: const Icon(Icons.delete),
                  ),
                ],
              ));
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createTask,
        child: const Icon(Icons.add),
      ),
    );
  }
}
