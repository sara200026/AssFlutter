import 'package:flutter/material.dart';

import 'db_helper.dart';
import 'newTask.dart';
import 'taskModel.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: TabBarPage(),
    );
  }
}

class TabBarPage extends StatefulWidget {
  @override
  _TabBarPageState createState() => _TabBarPageState();
}

class _TabBarPageState extends State<TabBarPage> with TickerProviderStateMixin {
  TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return NewTask();
                  }),
                );
              })
        ],
        title: Text('My Tasks'),
        bottom: TabBar(
          controller: tabController,
          tabs: [
            Tab(
              text: 'All Tasks',
            ),
            Tab(
              text: 'Complete Tasks',
            ),
            Tab(
              text: 'InComplete Tasks',
            ),
          ],
          isScrollable: true,
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Expanded(
            child: TabBarView(controller: tabController, children: [
              AllTasks(),
              CompleteTasks(),
              InCompleteTasks(),
            ]),
          ),
        ],
      ),
    );
  }
}

class AllTasks extends StatefulWidget {
  @override
  _AllTasksState createState() => _AllTasksState();
}

class _AllTasksState extends State<AllTasks> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
      future: DbHalper.dbHalper.selectAllTasks(),
      builder: (context, snap) {
        if (snap.hasData) {
          return ListView.builder(
            itemCount: snap.data.length,
            itemBuilder: (context, position) {
              bool isComplete = false;
              int index = snap.data[position].row[2];

              if (index == 1) {
                isComplete = true;
              } else {
                isComplete = false;
              }
              return Card(
                  margin: EdgeInsets.all(10),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              AlertDialog alertDialog = AlertDialog(
                                title: Text("AlertDialog"),
                                content: Text("are you sure to delete Task?"),
                                actions: [
                                  FlatButton(
                                    child: Text("Yes"),
                                    onPressed: () {
                                      DbHalper.dbHalper.deleteTask(
                                          snap.data[position].row[0]);
                                      Navigator.of(context).pushAndRemoveUntil(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  TabBarPage()),
                                          (Route<dynamic> route) => false);
                                    },
                                  ),
                                  FlatButton(
                                    child: Text("No"),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                  ),
                                ],
                              );
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return alertDialog;
                                },
                              );
                            });
                          },
                          child: Icon(
                            Icons.delete,
                          ),
                        ),
                        Text(snap.data[position].row[1]),
                        Checkbox(
                            value: isComplete,
                            onChanged: (value) {
                              setState(() {
                                DbHalper.dbHalper.updateTask(Task(
                                  taskId: snap.data[position].row[0],
                                  taskName: snap.data[position].row[1],
                                  isComplete: value,
                                ));
                              });
                            }),
                      ],
                    ),
                  ));
            },
          );
        }
        return CircularProgressIndicator();
      },
    ));
  }
}

class CompleteTasks extends StatefulWidget {
  @override
  _CompleteTasksState createState() => _CompleteTasksState();
}

class _CompleteTasksState extends State<CompleteTasks> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder<List>(
      future: DbHalper.dbHalper.selectSpecificTasks(1),
      initialData: List(),
      builder: (context, snap) {
        if (snap.hasData) {
          return ListView.builder(
            itemCount: snap.data.length,
            itemBuilder: (context, position) {
              bool isComplete = false;

              int index = snap.data[position].row[2];
              if (index == 1) {
                isComplete = true;
              } else {
                isComplete = false;
              }
              return Card(
                  margin: EdgeInsets.all(10),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              AlertDialog alert = AlertDialog(
                                title: Text("AlertDialog"),
                                content: Text("are you sure to delte Task?"),
                                actions: [
                                  FlatButton(
                                    child: Text("Yes"),
                                    onPressed: () {
                                      DbHalper.dbHalper.deleteTask(
                                          snap.data[position].row[0]);
                                      Navigator.of(context).pushAndRemoveUntil(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  TabBarPage()),
                                          (Route<dynamic> route) => false);
                                    },
                                  ),
                                  FlatButton(
                                    child: Text("No"),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                  ),
                                ],
                              );
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return alert;
                                },
                              );
                            });
                          },
                          child: Icon(
                            Icons.delete,
                          ),
                        ),
                        Text(snap.data[position].row[1]),
                        Checkbox(
                            value: isComplete,
                            onChanged: (value) {
                              setState(() {
                                DbHalper.dbHalper.updateTask(Task(
                                  taskId: snap.data[position].row[0],
                                  taskName: snap.data[position].row[1],
                                  isComplete: value,
                                ));
                              });
                            }),
                      ],
                    ),
                  ));
            },
          );
        }

        return CircularProgressIndicator();
      },
    ));
  }
}

class InCompleteTasks extends StatefulWidget {
  @override
  _InCompleteTasksState createState() => _InCompleteTasksState();
}

class _InCompleteTasksState extends State<InCompleteTasks> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
      future: DbHalper.dbHalper.selectSpecificTasks(0),
      builder: (context, snap) {
        if (snap.hasData) {
          return ListView.builder(
            itemCount: snap.data.length,
            itemBuilder: (context, position) {
              bool isComplete = false;
              int index = snap.data[position].row[2];
              if (index == 1) {
                isComplete = true;
              } else {
                isComplete = false;
              }
              return Card(
                  margin: EdgeInsets.all(10),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              AlertDialog alertDialog = AlertDialog(
                                title: Text("AlertDialog"),
                                content: Text("are you sure to delete Task?"),
                                actions: [
                                  FlatButton(
                                    child: Text("Yes"),
                                    onPressed: () {
                                      DbHalper.dbHalper.deleteTask(
                                          snap.data[position].row[0]);
                                      Navigator.of(context).pushAndRemoveUntil(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  TabBarPage()),
                                          (Route<dynamic> route) => false);
                                    },
                                  ),
                                  FlatButton(
                                    child: Text("No"),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                  ),
                                ],
                              );
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return alertDialog;
                                },
                              );
                            });
                          },
                          child: Icon(
                            Icons.delete,
                          ),
                        ),
                        Text(snap.data[position].row[1]),
                        Checkbox(
                            value: isComplete,
                            onChanged: (value) {
                              setState(() {
                                DbHalper.dbHalper.updateTask(Task(
                                  taskId: snap.data[position].row[0],
                                  taskName: snap.data[position].row[1],
                                  isComplete: value,
                                ));
                              });
                            }),
                      ],
                    ),
                  ));
            },
          );
        }
        return CircularProgressIndicator();
      },
    ));
  }
}
