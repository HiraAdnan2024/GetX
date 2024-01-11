import 'package:get/state_manager.dart';
import 'package:todo_using_getx/model/todo.dart';

class TodoController extends GetxController{
  RxList<Todo> todos = <Todo>[].obs;

  void addTodo(String title){
    todos.add(Todo(title, false));
  }

  void removeTodo(int index) {
    todos.removeAt(index);
  }

  void editTodo(int index, String newTitle){
    todos[index].title = newTitle;
  }

  void toggleComplete(int index){
    todos[index].isCompleted = !todos[index].isCompleted;
  }

  void sortTodos(bool completedFirst){
    todos.sort((a,b){
      if (completedFirst){
        return a.isCompleted ? -1 : 1;
      }else{
        return a.isCompleted ? 1 : -1;
      }
    });
  }
}