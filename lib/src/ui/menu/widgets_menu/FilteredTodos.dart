import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firebase_flutter_2/src/bloc/crub_firebase/todos.dart';
import 'package:flutter_firebase_flutter_2/src/bloc/filtered_todos/filtered_todos.dart';
import 'package:flutter_firebase_flutter_2/src/modelo/lesson.dart';
import 'package:flutter_firebase_flutter_2/src/ui/menu/screens/detailscreen.dart';

import 'delete_todo_snack_bar.dart';
import 'todo_item.dart';

class FilteredTodos extends StatelessWidget {
  FilteredTodos({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Card makeCard(Lesson lesson, var todo) => Card(
          elevation: 8.0,
          margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
          child: Container(
            decoration: BoxDecoration(color: Color.fromRGBO(64, 75, 96, .9)),
            child: // makeListTile(lesson),
                TodoItem(
              todo: todo,
              onDismissed: (direction) {
                BlocProvider.of<TodosBloc>(context).add(DeleteTodo(todo));
                Scaffold.of(context).showSnackBar(DeleteTodoSnackBar(
                  todo: todo,
                  onUndo: () =>
                      BlocProvider.of<TodosBloc>(context).add(AddTodo(todo)),
                ));
              },
              onTap: () async {
                final removedTodo = await Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) {
                    return DetailsScreen(id: todo.id);
                  }),
                );
                if (removedTodo != null) {
                  Scaffold.of(context).showSnackBar(
                    DeleteTodoSnackBar(
                      todo: todo,
                      onUndo: () => BlocProvider.of<TodosBloc>(context)
                          .add(AddTodo(todo)),
                    ),
                  );
                }
              },
              onCheckboxChanged: (_) {
                BlocProvider.of<TodosBloc>(context).add(
                  UpdateTodo(todo.copyWith(complete: !todo.complete)),
                );
              },
              lesson: lesson,
            ),
          ),
        );
    //cambio de datos que vienen de base de datos
    return BlocBuilder<FilteredTodosBloc, FilteredTodosState>(
      builder: (context, state) {
        if (state is FilteredTodosLoaded) {
          final todos = state.filteredTodos;
          List lessons = [];
          return ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: todos.length,
            itemBuilder: (context, index) {
              final todo = todos[index];
              lessons.add(new Lesson(
                  title: todo.task,
                  level: "Intermidiate",
                  indicatorValue: 0.66,
                  price: 30,
                  content: todo.note));
              return makeCard(lessons[index], todo);
            },
          );
        } else {
          return Container();
        }
      },
    );
  }
}
