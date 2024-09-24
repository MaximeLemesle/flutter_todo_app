import 'package:isar/isar.dart';

// This line is for generate file
// Then run : dart run build_runner build
part 'task.g.dart';

@Collection()
class Task {
  Id id = Isar.autoIncrement;
  late String text;
}