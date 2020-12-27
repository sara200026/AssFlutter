import 'db_helper.dart';

class Task {
  int taskId;
  String taskName;
  bool isComplete;
  Task({this.taskId, this.taskName, this.isComplete});
  toJson() {
    return {
      DbHalper.taskIdColumnName: this.taskId,
      DbHalper.taskNameColumnName: this.taskName,
      DbHalper.taskIsCompleteColumnName: this.isComplete ? 1 : 0
    };
  }

  Task.fromMap(Map<String, dynamic> map) {
    this.taskId = map['id'];
    this.taskName = map['taskName'];
    this.isComplete = map['isComplete'];
  }
}
