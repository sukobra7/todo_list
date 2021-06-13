import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'Pages/todo_list_page.dart';


void main() async {
  //firebase 
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      home: TodoListPage(),
      title: "Todo List"
    );
  }
}
