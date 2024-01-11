import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_using_getx/controller/todo_controller.dart';

class TodoListScreen extends StatelessWidget{
  final TodoController todoController = Get.put(TodoController());

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('Todo List'),
        actions: [
          IconButton(
              icon: Icon(Icons.sort),
              onPressed: (){
                showSortDailog();
              },
          ),
        ],
      ),

      body: Obx(
          () => ListView.builder(
            itemCount: todoController.todos.length,
            itemBuilder: (context, index){
              var todo = todoController.todos[index];
              return ListTile(
                title: Text(todo.title),
                leading: Checkbox(
                  value: todo.isCompleted,
                  onChanged: (value) {
                    todoController.toggleComplete(index);
                  },
                ),
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    todoController.removeTodo(index);
                  },
                ),
                onTap: (){
                  showEditDailog(index, todo.title);
                },
              );
            },
          ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showAddDailog();
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void showAddDailog(){
    TextEditingController titleController = TextEditingController();

    Get.defaultDialog(
      title: 'Add Todo',
      content: TextFormField(
        controller: titleController,
        decoration: InputDecoration(labelText:  'Todo Title '),
      ),
      actions: [
        ElevatedButton(
            onPressed: (){
              todoController.addTodo(titleController.text);
              Get.back();
            },
            child: Text('Add'),
        ),
        ElevatedButton(
            onPressed: () {
              Get.back();
            },
            child: Text('Cancle'),
        ),
      ],
    );
  }

  void showEditDailog(int index, String currentTitle){
    TextEditingController titleController = TextEditingController(text: currentTitle);

    Get.defaultDialog(
      title: 'Edit Todo',
      content: TextFormField(
        controller: titleController,
        decoration: InputDecoration(labelText: 'Todo Title'),
      ),
      actions: [
        ElevatedButton(
            onPressed: (){
              todoController.editTodo(index, titleController.text);
              Get.back();
            },
            child: Text('Save'),
        ),
        ElevatedButton(
            onPressed: (){
              Get.back();
            },
            child: Text('Cancle'),
        ),
      ],
    );
  }
  void showSortDailog(){
    Get.defaultDialog(
      title: 'Sort Todos',
      content: Column(
        children: [
          ElevatedButton(
              onPressed: (){
                todoController.sortTodos(true);
                Get.back();
              },
              child: Text('Completed First'),
          ),
        ],
      ),
      actions: [
        ElevatedButton(
            onPressed: (){
              Get.back();
            },
            child: Text('Cancle'),
        ),
      ],
    );
  }
}