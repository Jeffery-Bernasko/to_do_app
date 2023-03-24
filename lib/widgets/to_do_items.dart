import 'package:flutter/material.dart';
import 'package:hello_world/constants/colors.dart';

import '../model/todo.dart';

class ToDoItem extends StatelessWidget {
  const ToDoItem({Key? key, required this.todo, required this.onToDeleteItem, this.onToDoChanged}) : super(key: key);

  final ToDo todo;
  final onToDeleteItem;
  final onToDoChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 30),
      child: ListTile(
        onTap: (){
          onToDoChanged(todo);
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        tileColor: Colors.white,
        leading: Icon(
        todo.isDone? Icons.check_box : Icons.check_box_outline_blank,
          color: tdBlue,
        ),
        title: Text(
          todo.todoText!,
          style: TextStyle(
            fontSize: 16,
            color: tdBlack,
            decoration: todo.isDone? TextDecoration.lineThrough: null
          ),
        ),
        trailing: Container(
          height: 35,
          width: 35,
          decoration: BoxDecoration(
            color: tdRed,
            borderRadius: BorderRadius.circular(5),
          ),
          child: IconButton(
            color: Colors.white,
            iconSize: 18,
            icon: Icon(Icons.delete),
            onPressed: (){
              onToDeleteItem(todo.id);
            },
          ),
        ),
      ),
    );
  }
}
