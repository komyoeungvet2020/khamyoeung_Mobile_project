import 'package:flutter/material.dart';
import 'Todo.dart';

class ListTodo extends StatefulWidget {
  @override
  _ListTodoState createState() => _ListTodoState();
}

class _ListTodoState extends State<ListTodo> {
  List<Todo> todos = [];
  TextEditingController controller = new TextEditingController();
  _toggleTodo(Todo todo, bool isChecked) {
    setState(() {
      todo.isDone = isChecked;
    });
  }

  Widget _builElement(BuildContext context, int index) {
    final todo = todos[index];
    return CheckboxListTile(
      value: todo.isDone,
      title: Text(todo.title),
      onChanged: (bool isChecked) {
        _toggleTodo(todo, isChecked);
      },
    );
  }

  _addTodoList() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("New todo"),
            content: TextField(
              controller: controller,
              autofocus: true,
            ),
            actions: <Widget>[
              MaterialButton(
                child: Text("Cancel"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              MaterialButton(
                child: Text("Add"),
                onPressed: () {
                  setState(() {
                    final todo = new Todo(title: controller.value.text);
                    if (controller.value.text == "") {
                      print("");
                    } else {
                      todos.add(todo);
                    }
                    controller.clear();
                    Navigator.of(context).pop();
                  });
                },
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Todo List"),
      ),
      body: ListView.builder(
        itemBuilder: _builElement,
        itemCount: todos.length,
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: _addTodoList,
      ),
    );
  }
}
