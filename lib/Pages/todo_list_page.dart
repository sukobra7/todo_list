import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_list/models/task.dart';

class TodoListPage extends StatelessWidget {

  Widget _buildList(QuerySnapshot snapshot) {
    return ListView.builder(
      itemCount: snapshot.docs.length,
      itemBuilder: (context, index) {
        final doc = snapshot.docs[index];
        final task = Task.fromSnapshot(doc);
        // QueryDocumentSnapshot
        // QuerySnapshotが持っているデータの中身一つ一つを持っています
       return _buildListItem(task);
      }
    );
  }

  Widget _buildListItem(Task task) {
    return ListTile(
      title: Text(task.title)
    );
}

  Widget _buildBody(BuildContext context) {

    final TextEditingController _controller = TextEditingController();

    void _addTask() {

      FirebaseFirestore.instance.collection('todos').add({"title": _controller.text});
      _controller.text = "";

    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(children: [
        Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _controller,
                decoration: InputDecoration(hintText: "Enter task name"),
              )),
              FlatButton(
                child: Text("ADD Task", style: TextStyle(color: Colors.white)),
                color: Colors.green,
              onPressed: () {
                _addTask();
              },
              )
            ],
          ),
        // イベントが起きるたびにその情報を自動でキャッチして、アプリの画面に表示を反映
        // これらのイベントをstreamと呼ぶ。
        // streamから流れてくるイベントを監視して、
        // 新しいイベントが発生する度に、再ビルドでき常に最新の状態を表示できる
        // Querysnapshotとは複数のドキュメントデータを持っている。
        // データベースから複数のドキュメントを取得した時はquerysnapshotがこの形でデータを持っている。
        StreamBuilder<QuerySnapshot>(
          // todosに変更が会ったときに、そのデータをstreamに流す。
          stream: FirebaseFirestore.instance.collection("todos").snapshots(),
          // snapshot of stream snapshot are consist of these documents
          builder: (context, snapshot) {
            // ロード中
            if (!snapshot.hasData) return LinearProgressIndicator();

            return Expanded(
              child: _buildList(snapshot.data)
            );
          }
        )
       
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Todo List')
      ),
      body: _buildBody(context),
    );
  }
}