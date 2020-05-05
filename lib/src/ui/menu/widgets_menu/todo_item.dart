import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_firebase_flutter_2/src/modelo/lesson.dart';
import 'package:flutter_firebase_flutter_2/src/repository/crud_firebase/src/models/models.dart';
import 'package:meta/meta.dart';

class TodoItem extends StatelessWidget {
  final DismissDirectionCallback onDismissed;
  final GestureTapCallback onTap;
  final ValueChanged<bool> onCheckboxChanged;
  final Todo todo;
  final Lesson lesson;

  TodoItem({
    Key key,
    @required this.onDismissed,
    @required this.onTap,
    @required this.onCheckboxChanged,
    @required this.todo,
    @required this.lesson,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key('__todo_item_${todo.id}'),
      onDismissed: onDismissed,
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        onTap: onTap,
        leading: Container(
          padding: EdgeInsets.only(right: 12.0),
          decoration: new BoxDecoration(
              border: new Border(
                  right: new BorderSide(width: 1.0, color: Colors.white24))),
          child: Icon(Icons.airport_shuttle, color: Colors.white),
        ),
        title: Hero(
          tag: '${todo.id}__heroTag',
          child: Container(
            width: MediaQuery.of(context).size.width,
            child: Text(
              todo.task.toUpperCase(),
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        subtitle: todo.note.isNotEmpty
            ? Row(
                children: <Widget>[
                  Expanded(
                      flex: 1,
                      child: Container(
                        // tag: 'hero',
                        child: LinearProgressIndicator(
                            backgroundColor: Color.fromRGBO(209, 224, 224, 0.2),
                            value: lesson.indicatorValue,
                            valueColor: AlwaysStoppedAnimation(
                                lesson.colour_indicator)),
                      )),
                  Expanded(
                    flex: 4,
                    child: Padding(
                        padding: EdgeInsets.only(left: 10.0),
                        child: Text(lesson.level,
                            style: TextStyle(color: Colors.white))),
                  )
                ],
              )
            : null,
        trailing:
            Icon(Icons.keyboard_arrow_right, color: Colors.white, size: 30.0),
      ),
    );
  }
}
