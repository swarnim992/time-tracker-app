import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker/models/models.dart';
import 'package:time_tracker/providers/project_task_providr.dart';

class AddTimeEntryScreen extends StatefulWidget {
  @override
  _AddTimeEntryScreenState createState() => _AddTimeEntryScreenState();
}

class _AddTimeEntryScreenState extends State<AddTimeEntryScreen> {
  final _formKey = GlobalKey<FormState>();
  String projectId = '';
  String taskId = '';
  double totalTime = 0.0;
  String notes = '';

  List<String> projectList=[];
  List<String> taskList=[];
  bool isFirst = true;

  DateTime _selectedDate=DateTime.now();

  Future<void> _pickDate(BuildContext context) async {
    DateTime now = DateTime.now();
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if(isFirst) {
      projectList = context.read<ProjectEntryProvider>().projectNames();
      taskList = context.read<TaskEntryProvider>().taskNames();

      projectId = projectList[0];
      taskId = taskList[0];
      isFirst = false;
    }
    print(projectId);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red[200],
        title: Text('Add Time Entry'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Form(
          key: _formKey,
          child: Column(
              children: <Widget>[
              DropdownButtonFormField<String>(
                  value: projectId,
                  onChanged: (String? newValue) {
                  setState(() {
                      projectId = newValue!;
                  });
                  },
                  decoration: InputDecoration(labelText: 'Project'),
                  items: projectList.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                  );
                  }).toList(),
              ),
              DropdownButtonFormField<String>(
                  value: taskId,
                  onChanged: (String? newValue) {
                  setState(() {
                      taskId = newValue!;
                  });
                  },
                  decoration: InputDecoration(labelText: 'Task'),
                  items: taskList.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                  );
                  }).toList(),
              ),

              SizedBox(height: 20,),
                GestureDetector(
                  onTap: () => _pickDate(context),
                  child: AbsorbPointer(
                    child: TextFormField(
                      decoration: InputDecoration(
                        // labelText: 'Select Date',
                        hintText: _selectedDate == null
                            ? 'Tap to pick a date'
                            : '${_selectedDate!.toLocal()}'.split(' ')[0],
                        suffixIcon: Icon(Icons.calendar_today),
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (_selectedDate == null) {
                          return 'Please select a date';
                        }
                        return null;
                      },
                    ),
                  ),
                ),

              TextFormField(
                  decoration: InputDecoration(labelText: 'Total Time (hours)'),
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  validator: (value) {
                  if (value == null || value.isEmpty) {
                      return 'Please enter total time';
                  }
                  if (double.tryParse(value) == null) {
                      return 'Please enter a valid number';
                  }
                  return null;
                  },
                  onSaved: (value) => totalTime = double.parse(value!),
              ),
              TextFormField(
                  decoration: InputDecoration(labelText: 'Notes'),
                  validator: (value) {
                  if (value == null || value.isEmpty) {
                      return 'Please enter some notes';
                  }
                  return null;
                  },
                  onSaved: (value) => notes = value!,
              ),
              SizedBox(height: 20,),
              ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        Provider.of<TimeEntryProvider>(context, listen: false)
                            .addTimeEntry(TimeEntry(
                            id: _selectedDate.toString(), // Simple ID generation
                            projectId: projectId,
                            taskId: taskId,
                            totalTime: totalTime,
                            date: _selectedDate!,
                            notes: notes,
                            ));
                        Navigator.pop(context);
                    }
                  },
                  child: Text('Save The Entry'),
              )
              ],
          ),
          ),
      ),
    );
  }
}