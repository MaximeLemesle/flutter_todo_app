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
          decoration: InputDecoration(
            hintText: 'Enter task',
            hintStyle: Theme.of(context).inputDecorationTheme.hintStyle,
            filled: true,
            fillColor: Theme.of(context).inputDecorationTheme.fillColor,
            border: Theme.of(context).inputDecorationTheme.border,
          ),
        ),
        actions: [
          // create button
          ElevatedButton(
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

  // Home screen
  @override
  Widget build(BuildContext context) {
    // Task database
    final taskDatabase = context.watch<TaskDatabase>();

    // Current tasks
    List<Task> currentTasks = taskDatabase.currentTasks;

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'Tasks list',
              style: Theme.of(context).textTheme.displayLarge,
            ),
          ],
        ),
        backgroundColor: Theme.of(context).colorScheme.surface,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(.5),
          child: Container(
            height: .5,
            color: Colors.black26,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.background,
              ),
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: ListView.builder(
                itemCount: currentTasks.length,
                itemBuilder: (context, index) {
                  // Get the task
                  final task = currentTasks[index];

                  // List tile for each task
                  return Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surface,
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(
                        color: Colors.black12,
                        width: .5,
                      ),
                    ),
                    margin:
                        const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
                    child: ListTile(
                      title: Text(
                        task.text,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // update button
                          IconButton(
                            onPressed: () => updateTask(task),
                            icon: const Icon(
                              Icons.edit,
                              size: 22,
                              color: Colors.black54,
                            ),
                          ),

                          // delete button
                          IconButton(
                            onPressed: () => deleteTask(task.id),
                            icon: const Icon(
                              Icons.delete,
                              size: 22,
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createTask,
        backgroundColor: Theme.of(context).colorScheme.primary,
        child: const Icon(Icons.add),
      ),
    );
  }
}
