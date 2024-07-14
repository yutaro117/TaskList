import 'package:flutter/material.dart';
import 'dart:async';
import 'main.dart';


class Task {
  int complete;
  String name;
  String time;
  String priority;
  int deadline;
  String contents;

  Task({
    required this.complete,
    required this.name,
    required this.time,
    required this.priority,
    required this.deadline,
    required this.contents,
  });

  DateTime get deadlineDateTime {
    String deadlineString = deadline.toString().padLeft(8, '0');
    int month = int.parse(deadlineString.substring(0, 2));
    int day = int.parse(deadlineString.substring(2, 4));
    int hour = int.parse(deadlineString.substring(4, 6));
    int minute = int.parse(deadlineString.substring(6, 8));
    return DateTime(DateTime.now().year, month, day, hour, minute);
  }
}

class TaskProvider with ChangeNotifier {
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey = GlobalKey<ScaffoldMessengerState>();
  List<Task> _task = [
    Task(complete: 1, name: 'Task1:英語', time: '60分', priority: '1', deadline: 07141600, contents: 'P34~56'),
    Task(complete: 1, name: 'Task2:数学', time: '40分', priority: '1', deadline: 07132000, contents: 'P12~23'),
    Task(complete: 0, name: 'Task3:化学', time: '70分', priority: '1', deadline: 07151000, contents: 'P56~78'),
    Task(complete: 0, name: 'Task4:情報', time: '30分', priority: '2', deadline: 07141700, contents: 'P45~67'),
    Task(complete: 0, name: 'Task5:国語', time: '60分', priority: '2', deadline: 07161300, contents: 'P22~25'),
    Task(complete: 0, name: 'Task6:世界史', time: '80分', priority: '3', deadline: 07201500, contents: 'P45~78'),
    Task(complete: 0, name: 'Task7:地理', time: '40分', priority: '3', deadline: 07161500, contents: 'P33~56'),
  ];

  List<Task> get task => _task;

  void addTask(Task task) {
    _task.add(task);
    notifyListeners();
    _scheduleDeadlineNotification(task);
    
  }

  void updateTask(int index, Task newTask) {
    if (index >= 0 && index < _task.length) {
      _task[index] = newTask;
      notifyListeners();
      _scheduleDeadlineNotification(newTask);
    }
  }

  void sortTaskByPriority() {
    _task.sort((a, b) => a.priority.compareTo(b.priority));
    notifyListeners();
  }

  void sortTaskBydeadline() {
    _task.sort((a, b) => a.deadline.compareTo(b.deadline));
    notifyListeners();
  }

  void removeTask(int index) {
    if (index >= 0 && index < _task.length) {
      _task.removeAt(index);
      notifyListeners();
    }
  }

  void _scheduleDeadlineNotification(Task task) {
    final now = DateTime.now();
    final deadlineDateTime = task.deadlineDateTime.subtract(Duration(hours: 12));
    final difference = deadlineDateTime.difference(now).inSeconds;
    if (difference > 0) {
      Timer(Duration(seconds: difference), () {
        showNotification('${task.name}','の締め切りが近づいています！');
      });
    }
  }

  
}