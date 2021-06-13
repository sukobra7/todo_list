import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TodoListPage extends StatelessWidget {

  Widget _buildBody(BuildContext context) {

    final TextEditingController _controller = TextEditingController();

    void _addTask() {

      FirebaseFirestore.instance.collection('todos')
          .add({"title": _controller.text});
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
        
        
        Expanded(
          child: ListView.builder(
            itemCount: 20,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text("Your task here..."),
              );
            }
          ),
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