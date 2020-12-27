import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'taskModel.dart';

class TaskWidget extends StatefulWidget {
  Task task;
  TaskWidget(this.task);

  @override
  _TaskWidgetState createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskWidget> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                showDialog(
                  context: context,
                );
              },
            ),
            Text(widget.task.taskName),
            Checkbox(
                value: widget.task.isComplete,
                onChanged: (value) {
                  this.widget.task.isComplete = !this.widget.task.isComplete;
                  setState(() {});
                })
          ],
        ),
      ),
    );
  }
}
