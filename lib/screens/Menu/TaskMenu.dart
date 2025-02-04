

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/models.dart';
import '../../providers/project_task_providr.dart';

class Taskmenu extends StatelessWidget {
  const Taskmenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Manage Tasks',style: TextStyle(
            color: Colors.white
        ),),
        backgroundColor: Colors.pink,
        leading: IconButton(
          icon : Icon(Icons.arrow_back_rounded),
          color: Colors.white,
          onPressed: () {
            Navigator.pop(context);
          },),
      ),
      body: Consumer<TaskEntryProvider>(
        builder: (context, provider, child) {
          return ListView.builder(
            itemCount: provider.entries.length,
            itemBuilder: (context, index) {
              final entry = provider.entries[index];
              return ListTile(
                title: Text('${entry.name}'),
                // subtitle: Text('${entry.date.toString()} - Notes: ${entry.notes}'),
                trailing: IconButton(
                  icon: Icon(Icons.delete,color: Colors.red,),
                  onPressed: () {
                    Provider.of<TaskEntryProvider>(context, listen: false)
                        .deleteTaskEntry(entry.id);
                  },
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddEntryDialog(context);
        },
        child: Icon(Icons.add),
        tooltip: 'Task',
      ),
    );
  }


  void _showAddEntryDialog(BuildContext context) {
    final TextEditingController _nameController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add Task'),
          content: TextField(
            controller: _nameController,
            decoration: InputDecoration(hintText: 'Task Name'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                if (_nameController.text.isNotEmpty) {
                  final random = Random();
                  int randomNumber = random.nextInt(10000) + 1;

                  final newEntry = Task(
                    id: randomNumber.toString(),
                    name: _nameController.text,
                  );
                  Provider.of<TaskEntryProvider>(context, listen: false)
                      .addTaskEntry(newEntry);
                  Navigator.of(context).pop();
                }
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }
}
