import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker/providers/project_task_providr.dart';
import 'package:time_tracker/screens/AddTimeEntry.dart';

class HomeScreen extends StatelessWidget {
  // const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Time Entries'),
      ),
      body:
      Consumer<TimeEntryProvider>(
        builder: (context, provider, child) {
          return ListView.builder(
            itemCount: provider.entries.length,
            itemBuilder: (context, index) {
              final entry = provider.entries[index];
              return ListTile(
                title: Text('${entry.projectId} - ${entry.totalTime} hours'),
                subtitle: Text('${entry.date.toString()} - Notes: ${entry.notes}'),
                onTap: () {
                  // This could open a detailed view or edit screen
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to the screen to add a new time entry
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddTimeEntryScreen()),
          );
        },
        child: Icon(Icons.add),
        tooltip: 'Add Time Entry',
      ),
    );
  }
}