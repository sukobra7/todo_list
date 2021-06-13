import 'package:cloud_firestore/cloud_firestore.dart';

class Task {

  final String title;
  final String taskId;

  Task(this.title, [this.taskId]);

  // factoryコンストラクタはインスタンスを生成しません。
  // 手動でインスタンスを生成して、明示的にreturnする必要がある
  factory Task.fromSnapshot(DocumentSnapshot snapshot) {
    final Map map = snapshot.data();
    return Task(map['title'], snapshot.id);
  }

}