import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'db_helper.dart';
import 'main.dart';
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
                // alert(
                //   context,
                // );
                setState(() {});
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

// alert(BuildContext context) {
//   Task task;
//   AlertDialog alertDialog = AlertDialog(
//     title: Text("AlertDialog"),
//     content: Text("are you sure to delete Task?"),
//     actions: [
//       FlatButton(
//         child: Text("Yes"),
//         onPressed: () {
//           DbHalper.dbHalper.deleteTask(task.taskId);
//            Navigator.push(
//                                             context,
//                                             MaterialPageRoute(
//                                                 builder: (context) =>
//                                                     TabBarPage()),
//                                           );
// //         },
//       ),
//       FlatButton(
//         child: Text("No"),
//         onPressed: () {
//           Navigator.pop(context);
//         },
//       ),
//     ],
//   );
//   showDialog(
//     context: context,
//     builder: (BuildContext context) {
//       return alertDialog;
//     },
//   );
// }
