import 'package:flutter/material.dart';

import '../models/task.dart';
import 'database_service.dart';

class Tasklist with ChangeNotifier {
  final DatabaseService _databaseService = DatabaseService();

  List<Task> _taskList = [];
  String _taskName = "";
  int _taskId = 0;

  get taskList => _taskList;
  get taskName => _taskName;
  get taskId => _taskName;

  void changeTaskName(String taskName) {
    _taskName = taskName;
    notifyListeners();
  }

  Future<void> fetchTaskList() async {
    _taskList = await _databaseService.taskList();
    notifyListeners();
  }

  Future<void> showTaskList() async {
    _taskList = (await _databaseService.taskById(
      Task(name: _taskName, status: 0)
    )) as List<Task>;
    notifyListeners();
  }

  Future<void> addTask() async {
    await _databaseService.insertTask(
      Task(name: _taskName, status: 0),
    );
    _taskList = await _databaseService.taskList();
    notifyListeners();
  }

  Future<void> updateTask(String name) async {
    await _databaseService.updateTask(
      Task(name: _taskName, status: 0), name
    );
    _taskList = await _databaseService.taskList();
    notifyListeners();
  }

  Future<void> deleteTask(String name) async {
    await _databaseService.deleteTask(name);
    _taskList = await _databaseService.taskList();
    notifyListeners();
  }

  // final List<Task> _taskList = [];

  // get taskList => _taskList;

  // void addNewTask() {
  //   _taskList.add(
  //     Task(name: "Task Baru", status: 0),
  //   );
  //   notifyListeners();
  // }
}
