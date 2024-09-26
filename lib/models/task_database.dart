import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:todo_app/models/task.dart';

class TaskDatabase extends ChangeNotifier {
  static late Isar _isar;

  // Intialize db
  static Future<void> init() async {
    final dir = await getApplicationDocumentsDirectory();
    _isar = await Isar.open([TaskSchema], directory: dir.path);
  }

  // List of notes
  final List<Task> currentTasks = [];

  // Create a task
  Future<void> createTask(String textFromUser) async {
    // Create a new task object
    final newTask = Task()..text = textFromUser;

    // Save the task object to the database
    await _isar.writeTxn(() => _isar.tasks.put(newTask));

    // Re-fetch the tasks
    fetchTasks();
  }

  // Read all tasks
  Future<void> fetchTasks() async {
    List<Task> fetchedTasks = await _isar.tasks.where().findAll();
    currentTasks.clear();
    currentTasks.addAll(fetchedTasks);
    notifyListeners();
  }

  // Update a task
  Future<void> updateTask(int id, String newText, bool? isChecked) async {
    final existingNote = await _isar.tasks.get(id);
    if (existingNote != null) {
      existingNote.text = newText;
      existingNote.isChecked = isChecked ?? false;
      await _isar.writeTxn(() => _isar.tasks.put(existingNote));
      await fetchTasks();
    }
  }

  // Delete a task
  Future<void> deleteTask(int id) async {
    await _isar.writeTxn(() => _isar.tasks.delete(id));
    await fetchTasks();
  }
}
