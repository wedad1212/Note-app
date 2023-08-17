import 'package:get/get.dart';

import '../db/db_helper.dart';
import '../models/task.dart';

class TaskController extends GetxController {
  final RxList<Task> taskList = <Task>[].obs;

  Future<int> addTask({required Task task}) async {
    return await DBHelper.insert(task);
  }

  getTask() async {
    final List<Map<String, dynamic>> _tasks = await DBHelper.query();
    taskList.assignAll(_tasks.map((e) => Task.fromJson(e)).toList());
  }

  void deleteTask(Task task) async {
    await DBHelper.delete(task);

    getTask();
  }

  void deleteAllTasks() async {
    await DBHelper.deleteAll();
    getTask();
  }

  void updateTask(int id) async {
    await DBHelper.update(id);
    getTask();
  }
}
