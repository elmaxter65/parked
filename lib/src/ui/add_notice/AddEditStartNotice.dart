import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firebase_flutter_2/src/bloc/crub_firebase/todos.dart';
import 'package:flutter_firebase_flutter_2/src/repository/crud_firebase/src/firebase_todos_repository.dart';
import 'package:flutter_firebase_flutter_2/src/repository/crud_firebase/src/models/models.dart';
import 'package:flutter_firebase_flutter_2/src/ui/add_notice/AddEditNotice.dart';

class AddEditStartNotice extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<TodosBloc>(
          create: (context) {
            print(LoadTodos());
            return TodosBloc(
              todosRepository: FirebaseTodosRepository(),
            )..add(LoadTodos());
          },
        )
      ],
      child: MaterialApp(
        title: 'Firestore Todos',
        routes: {
          '/': (context) {
            return AddEditScreen(
              onSave: (task, note) {
                BlocProvider.of<TodosBloc>(context).add(
                  AddTodo(Todo(task, note: note)),
                );
              },
              isEditing: false,
            );
          },
        },
      ),
    );
  }
}
