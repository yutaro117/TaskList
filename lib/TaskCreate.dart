import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'TaskProvider.dart';

class TaskCreateScreen extends StatefulWidget {
  @override
  _TaskCreateScreenState createState() => _TaskCreateScreenState();
}

class _TaskCreateScreenState extends State<TaskCreateScreen> {
  final _completeController = TextEditingController();
  final _nameController = TextEditingController();
  final _timeController = TextEditingController();
  final _priorityController = TextEditingController();
  final _deadlineController = TextEditingController();
  final _contentsController = TextEditingController();

  void _addTask() {
    final complete = int.tryParse(_completeController.text);
    final name = _nameController.text;
    final time = _timeController.text;
    final priority = _priorityController.text;
    final deadline = int.tryParse(_deadlineController.text);
    final contents = _contentsController.text;


    if (complete != null && name.isNotEmpty && time.isNotEmpty && priority.isNotEmpty && deadline != null && contents.isNotEmpty)  {
      final newTask = Task(complete: complete, name: name, time: time, priority: priority, deadline: deadline, contents: contents);
      Provider.of<TaskProvider>(context, listen: false).addTask(newTask);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('タスク追加'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _completeController,
              decoration: InputDecoration(
                labelText: 'タスクが完了しましたか？',
                hintText: 'Yes:1,No:0',
                ),
            ),
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'タスクの名前',
                hintText: 'task1:英語',
                ),
            ),
            TextField(
              controller: _timeController,
              decoration: InputDecoration(
                labelText: 'Time',
                hintText: '60分',
                ),
            ),
            TextField(
              controller: _priorityController,
              decoration: InputDecoration(
                labelText: 'タスクの優先度',
                hintText: '優先度高:1,優先度中:2,優先度低:3',
                ),
            ),
            TextField(
              controller: _deadlineController,
              decoration: InputDecoration(
                labelText: 'タスクの締め切り日時',
                hintText: '07/14 16:00の場合 07141600',
                ),
            ),
            TextField(
              controller: _contentsController,
              decoration: InputDecoration(
                labelText: 'タスクの内容',
                hintText: '教科書P34~P56',
                ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: _addTask,
              child: Text('タスク登録'),
            ),
          ],
        ),
      ),
    );
  }
}
