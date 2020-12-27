import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'db_helper.dart';
import 'taskModel.dart';

class NewTask extends StatefulWidget {
  @override
  _NewTaskState createState() => _NewTaskState();
}

class _NewTaskState extends State<NewTask> {
  bool isComplet = false;

  String taskName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Task'),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
              )),
              onChanged: (value) {
                this.taskName = value;
              },
            ),
            Checkbox(
                value: this.isComplet,
                onChanged: (value) {
                  this.isComplet = value;
                  setState(() {});
                }),
            RaisedButton(
              child: Text('Add New Task'),
              onPressed: () {
                DbHalper.dbHalper.insertNewTasks(
                    Task(taskName: taskName, isComplete: isComplet));
                Navigator.pop(context);
              },
            )
          ],
        ),
      ),
    );
  }
}
