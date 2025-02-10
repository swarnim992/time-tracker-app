


import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../models/models.dart';
import '../../providers/project_task_providr.dart';
import '../AddTimeEntry.dart';

class Groupent extends StatelessWidget {
  const Groupent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      Consumer<TimeEntryProvider>(
        builder: (context, provider, child) {
          List<TimeEntry> timeEntries = provider.entries;

          Map<String, List<TimeEntry>> groupedEntries = {};

          for (var entry in timeEntries) {
            if (!groupedEntries.containsKey(entry.projectId)) {
              groupedEntries[entry.projectId] = [];
            }
            groupedEntries[entry.projectId]!.add(entry);
          }
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.builder(
              itemCount: groupedEntries.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 4, // Adds shadow
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                    title: Text(groupedEntries.keys.elementAt(index),
                      style: TextStyle(color: Colors.red[300],fontSize: 22,fontWeight: FontWeight.w600),),
                    subtitle: ListView.builder(
                      shrinkWrap: true,
                      itemCount: groupedEntries.entries.elementAt(index).value.length,
                        itemBuilder: (context,i){
                          final demoentry = groupedEntries.entries.elementAt(index).value[i];
                        return Text('${demoentry.taskId}: ${demoentry.totalTime} hours (${DateFormat('MMM dd,yyyy').format(demoentry.date)})',
                          style: const TextStyle(fontWeight: FontWeight.w500,
                              fontSize: 15),);
                    }),
                  ),
                );
              },
            ),
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
