import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'TaskProvider.dart';
import 'TaskCreate.dart';
import 'TaskEdit.dart';

class TaskList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('タスクリスト'),
        actions: [
          IconButton(
            icon: Icon(Icons.sort),
            onPressed: () {
              Provider.of<TaskProvider>(context, listen: false).sortTaskByPriority();
            },
          ),
          IconButton(
            icon: Icon(Icons.sort),
            onPressed: () {
              Provider.of<TaskProvider>(context, listen: false).sortTaskBydeadline();
            },
          ),
        ],
      ),
      body: Consumer<TaskProvider>(
        builder: (context, taskProvider, child) {
          return ListView.builder(
            itemCount: taskProvider.task.length,
            itemBuilder: (context, index) {
              final task = taskProvider.task[index];
              return ListTile(
                title: Text(task.name),
                subtitle: Text('所要時間: ${task.time}, 優先度: ${task.priority}, 締め切り: ${task.deadline}, 内容: ${task.contents}'),
                tileColor: _getTileColor(task.complete),
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    taskProvider.removeTask(index);
                  },
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TaskEdit(
                        task: task,
                        index: index,
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => TaskCreateScreen()),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Color _getTileColor(int complete){
    if(complete == 0){
      return Colors.red.withOpacity(0.5);
    }else{
      return Colors.green.withOpacity(0.5);
    }
  }
}

