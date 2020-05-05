import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firebase_flutter_2/src/bloc/authentication_bloc/authentication_bloc.dart';
import 'package:flutter_firebase_flutter_2/src/bloc/authentication_bloc/authentication_event.dart';
import 'package:flutter_firebase_flutter_2/src/bloc/tab/tab_bloc.dart';
import 'package:flutter_firebase_flutter_2/src/modelo/app_tab.dart';

import 'widgets_menu/FilteredTodos.dart';

class HomeScreen extends StatelessWidget {
  final String thisUser;

  HomeScreen(this.thisUser);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TabBloc, AppTab>(
      builder: (context, activeTab) {
        //Menu bar different options
        final makeBottom = Container(
          height: 55.0,
          child: BottomAppBar(
            color: Color.fromRGBO(58, 66, 86, 1.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.home, color: Colors.white),
                  onPressed: () {},
                ),
                IconButton(
                  icon: Icon(Icons.map, color: Colors.white),
                  onPressed: () {
                    Navigator.pushNamed(context, '/maps');
                  },
                ),
                IconButton(
                  icon: Icon(Icons.monetization_on, color: Colors.white),
                  onPressed: () {},
                ),
                IconButton(
                  icon: Icon(Icons.account_box, color: Colors.white),
                  onPressed: () {},
                ),
                IconButton(
                  icon: Icon(Icons.insert_comment, color: Colors.white),
                  onPressed: () {
                    Navigator.pushNamed(context, '/addTodo');
                  },
                )
              ],
            ),
          ),
        );
        //Top menu bar
        final topAppBar = AppBar(
          elevation: 0.1,
          backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
          title: Text("Noticias"),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.exit_to_app),
              onPressed: () {
                BlocProvider.of<AuthenticationBloc>(context).add(LoggedOut());
              },
            )
          ],
        );
        return Scaffold(
          //menu
          appBar: topAppBar,
          body: FilteredTodos(thisUser: thisUser),
          bottomNavigationBar: makeBottom,
          backgroundColor: Color.fromRGBO(64, 75, 96, .9),
        );
      },
    );
  }
}
