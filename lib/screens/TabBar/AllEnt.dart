


import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../providers/project_task_providr.dart';
import '../AddTimeEntry.dart';

class Allent extends StatelessWidget {
  const Allent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      Consumer<TimeEntryProvider>(
        builder: (context, provider, child) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.builder(
              itemCount: provider.entries.length,
              itemBuilder: (context, index) {
                final entry = provider.entries[index];
                return Card(
                  elevation: 4, // Adds shadow
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    contentPadding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                    title: Text('${entry.projectId} - ${entry.taskId}',
                      style: TextStyle(color: Colors.red[300],fontSize: 18,fontWeight: FontWeight.w600),),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Text('Total Time: ${entry.totalTime} hours',style: TextStyle(fontWeight: FontWeight.w500,fontSize: 15),),
                        Text('Date: ${DateFormat('MMM dd,yyyy').format(entry.date)}',style: TextStyle(fontWeight: FontWeight.w500,fontSize: 15,color: Colors.grey[700]),),
                        Text('Notes: ${entry.notes}',style: TextStyle(fontWeight: FontWeight.w500,fontSize: 15),),

                      ],
                    ),
                    trailing: IconButton(
                      onPressed: (){
                        Provider.of<TimeEntryProvider>(context, listen: false)
                            .deleteTimeEntry(entry.id);
                      },
                      icon: Icon(Icons.delete,color: Colors.red,),),
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
