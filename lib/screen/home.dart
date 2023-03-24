import 'package:flutter/material.dart';
import 'package:hello_world/constants/colors.dart';
import 'package:hello_world/widgets/to_do_items.dart';

import '../model/todo.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final todoList = ToDo.todoList();
  List<ToDo> _foundToDo =[];
  final _todoController = TextEditingController();

  _handletoDeleteIten(String id){
    setState((){
      todoList.removeWhere((item) => item.id == id);
    });
  }

  _handletoDoChange(ToDo todo){
    setState((){
      todo.isDone = !todo.isDone;
    });
  }

  _addtoDoItem(String toDo){
    if(toDo.isEmpty){}
    else{
      setState((){
        todoList.add(ToDo(id: DateTime.now().millisecondsSinceEpoch.toString(), todoText: toDo));
      });
      _todoController.clear();
      FocusScope.of(context).unfocus();
    }
  }

  _runFilter(String keyword) {
    List<ToDo> result = [];
    if(keyword.isEmpty){result = todoList;}
    else{
      result = todoList
          .where((item) => item.todoText!
          .toLowerCase()
          .contains(keyword
          .toLowerCase()))
          .toList();
    }
    setState(() {
      _foundToDo = result;
    });
  }
    @override
    void initState(){
      _foundToDo = todoList;
      super.initState();
    }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tdBGColor,
      appBar: _buildAppBar(),
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
            child: Column(
              children: [
                searchBox(),
                Expanded(
                  child: ListView(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 15,bottom: 20),
                        child: const Text("All To Do List",
                        style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
                        ),
                      ),
                      for (ToDo todoo in _foundToDo.reversed)
                        ToDoItem(
                            todo: todoo,
                            onToDoChanged: _handletoDoChange,
                          onToDeleteItem: _handletoDeleteIten,
                        )
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(
                            bottom: 20,
                            right: 20,
                            left: 20,
                          ),
                          padding: EdgeInsets.symmetric(vertical: 5,horizontal: 20),
                          decoration: BoxDecoration(
                          color: Colors.white,
                            boxShadow: const [BoxShadow(
                              color: Colors.grey,
                              offset: Offset(0.0, 0.0),
                              blurRadius: 10.0,
                              spreadRadius: 0.0
                            )
                            ],
                            borderRadius: BorderRadius.circular(10)
                          ),
                          child: TextField(
                            controller: _todoController,
                            decoration: InputDecoration(
                              hintText: "Add new todo item",
                              border: InputBorder.none
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                          right: 20,
                          bottom: 20,
                        ),
                        child: ElevatedButton(
                          child: Text('+',style: TextStyle(fontSize: 40),),
                          onPressed: (){
                            _addtoDoItem(_todoController.text);
                          },
                          style: ElevatedButton.styleFrom(
                            primary: tdBlue,
                            minimumSize: Size(60,60),
                            elevation: 10
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  AppBar _buildAppBar(){
    return  AppBar(
      elevation: 0,
      backgroundColor: tdBGColor,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const  Icon(Icons.menu, color: tdBlack,),

          Container(
            height: 40,
            width: 40,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset("assets/avatar.jpg"),
            ),
          )
        ],
      ),
    );
  }

  Widget searchBox(){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.0),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20)
      ),
      child: TextField(
        onChanged: (value) => _runFilter(value),
        decoration: InputDecoration(
            contentPadding: EdgeInsets.all(0),
            prefixIcon: Icon(Icons.search, color: tdBlack,size: 20,),
            prefixIconConstraints: BoxConstraints(maxHeight: 20,minWidth: 25),
            border: InputBorder.none,
            hintText: "Search",
            hintStyle: TextStyle(color: tdGrey)
        ),
      ),
    );
  }
}
