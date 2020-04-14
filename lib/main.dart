import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firebase_flutter_2/src/bloc/authentication_bloc/bloc.dart';
import 'package:flutter_firebase_flutter_2/src/bloc/crub_firebase/todos.dart';
import 'package:flutter_firebase_flutter_2/src/bloc/simple_bloc_delegate.dart';
import 'package:flutter_firebase_flutter_2/src/bloc/stats/stats.dart';
import 'package:flutter_firebase_flutter_2/src/bloc/tab/tab_bloc.dart';
import 'package:flutter_firebase_flutter_2/src/repository/crud_firebase/src/firebase_todos_repository.dart';
import 'package:flutter_firebase_flutter_2/src/repository/crud_firebase/src/models/models.dart';
import 'package:flutter_firebase_flutter_2/src/repository/user_repository.dart';
import 'package:flutter_firebase_flutter_2/src/ui/add_notice/AddEditNotice.dart';
import 'package:flutter_firebase_flutter_2/src/ui/login/login_screen.dart';
import 'package:flutter_firebase_flutter_2/src/ui/splash_screen.dart';

import 'src/bloc/filtered_todos/filtered_todos.dart';
import 'src/ui/menu/menu_form.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  BlocSupervisor.delegate = SimpleBlocDelegate();

  runApp(
      Mysplash()
  );
}

class App extends StatelessWidget {
  final UserRepository _userRepository;

  App({Key key, @required UserRepository userRepository})
      : assert (userRepository != null),
        _userRepository = userRepository,
        super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthenticationBloc>(
          create: (context) {
            return AuthenticationBloc(
              userRepository: UserRepository(),
            )
              ..add(AppStarted());
          },
        ),
        BlocProvider<TodosBloc>(
          create: (context) {
            return TodosBloc(
              todosRepository: FirebaseTodosRepository(),
            )
              ..add(LoadTodos());
          },
        )
      ],
      child: MaterialApp(
        title: 'Firestore Todos',
        routes: {
          '/': (context) {
            return BlocBuilder<AuthenticationBloc, AuthenticationState>(
              builder: (context, state) {
                if (state is Uninitialized) {
                  return SplashScreen();
                }
                if (state is Authenticated) {
                  return MultiBlocProvider(
                    providers: [
                      BlocProvider<TabBloc>(
                        create: (context) => TabBloc(),
                      ),
                      BlocProvider<FilteredTodosBloc>(
                        create: (context) =>
                            FilteredTodosBloc(
                              todosBloc: BlocProvider.of<TodosBloc>(context),
                            ),
                      ),
                      BlocProvider<StatsBloc>(
                        create: (context) =>
                            StatsBloc(
                              todosBloc: BlocProvider.of<TodosBloc>(context),
                            ),
                      ),
                    ],
                    child: HomeScreen(),
                  );
                  //  return ListPage(title: 'Menu');
                }
                if (state is Unauthenticated) {
                  return LoginScreen(userRepository: _userRepository,);
                }
                return Container();
              },
            );
          },
          '/addTodo': (context) {
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
