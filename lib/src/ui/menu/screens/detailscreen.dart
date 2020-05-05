import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firebase_flutter_2/src/bloc/crub_firebase/todos.dart';
import 'package:flutter_firebase_flutter_2/src/ui/add_notice/AddEditNotice.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_place_picker/google_maps_place_picker.dart';
import 'package:meta/meta.dart';

class DetailsScreen extends StatelessWidget {
  final String id;
  final String thisUser;

  DetailsScreen({Key key, @required this.id, @required this.thisUser})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodosBloc, TodosState>(
      builder: (context, state) {
        void _showDialog() {
          // flutter defined function
          showDialog(
            context: context,
            builder: (BuildContext context) {
              // return object of type Dialog
              return AlertDialog(
                title: new Text("Usuario invalido"),
                content: new Text(
                    "No tiene permiso para realizar la accion..."),
                actions: <Widget>[
                  // usually buttons at the bottom of the dialog
                  new FlatButton(
                    child: new Text("Cerrar"),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );
        }
        final todo = (state as TodosLoaded)
            .todos
            .firstWhere((todo) => todo.id == id, orElse: () => null);

        return Scaffold(
          appBar: AppBar(
            title: Text('Editar'),
            actions: [
              IconButton(
                tooltip: 'Eliminar Todo',
                icon: Icon(Icons.delete),
                onPressed: () {
                  if (thisUser == todo.user) {
                    BlocProvider.of<TodosBloc>(context).add(DeleteTodo(todo));
                    Navigator.pop(context, todo);
                  }
                  else
                    _showDialog();
                },
              )
            ],
          ),
          body: todo == null
              ? Container()
              : Padding(
            padding: EdgeInsets.all(16.0),
            child: ListView(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: 8.0),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Hero(
                            tag: '${todo.id}__heroTag',
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              padding: EdgeInsets.only(
                                top: 8.0,
                                bottom: 16.0,
                              ),
                              child: Text(
                                todo.task,
                                style:
                                Theme.of(context).textTheme.headline,
                              ),
                            ),
                          ),
                          Text(
                            todo.note,
                            style: Theme.of(context).textTheme.subhead,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                DropdownButton<String>(
                  hint: Text(todo.nivel),
                  items: <String>[
                    'Menor',
                    'Moderada',
                    'Seria',
                    'Grave',
                    'Critica',
                    'Maxima'
                  ].map((String value) {
                    return new DropdownMenuItem<String>(
                      value: value,
                      child: new Text(value),
                    );
                  }).toList(),
                ),
                new Text(
                  'Direccion:' + todo.formattedAddress,
                  style: new TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                    fontFamily: 'Roboto',
                  ),
                ),
                new Text(''),
                /*
                      new RaisedButton(
                        child: Text("Ver ubicacion del problema"),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return PlacePicker(
                                  apiKey: 'AIzaSyDqXewuPJKfBZabt80iDfpyJ3dB4z65FLw',
                                  initialPosition: LatLng(double.parse(todo.lat), double.parse(todo.lng)),
                                  useCurrentLocation: false,
                                    enableMapTypeButton:false,
                                  onPlacePicked: (result) {
                                    Navigator.of(context).pop();
                                  },
                                );
                              },
                            ),
                          );
                        },
                      ),
                       */
                Center(
                  child: Card(
                    elevation: 4,
                    margin: EdgeInsets.symmetric(vertical: 8),
                    child: SizedBox(
                      width: MediaQuery
                          .of(context)
                          .size
                          .width - 30,
                      height: MediaQuery
                          .of(context)
                          .size
                          .height * (2 / 3),
                      child: PlacePicker(
                        apiKey: 'AIzaSyDqXewuPJKfBZabt80iDfpyJ3dB4z65FLw',
                        initialPosition: LatLng(double.parse(todo.lat),
                            double.parse(todo.lng)),
                        useCurrentLocation: false,
                        enableMapTypeButton: false,
                      ),
                    ),
                  ),
                ),
                new Text(
                  'Indicar el nivel del problema',
                  style: new TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15.0,
                    fontFamily: 'Roboto',
                  ),
                ),
                new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    new RaisedButton(
                        padding: const EdgeInsets.all(8.0),
                        textColor: Colors.white,
                        color: Colors.blue,
                        child: new Text("Alto"),
                        onPressed: () {
                          String indicador_string = (int.parse(todo.indicator) +
                              1).toString();
                          BlocProvider.of<TodosBloc>(context).add(
                            UpdateTodo(
                              todo.copyWith(
                                  task: todo.task,
                                  note: todo.note,
                                  nivel: todo.nivel,
                                  user: todo.user,
                                  formattedAddress: todo.formattedAddress,
                                  lat: todo.lat,
                                  lng: todo.lng,
                                  indicator: indicador_string
                              ),
                            ),
                          );
                          Navigator.pop(context);
                        }),
                    new RaisedButton(
                        textColor: Colors.white,
                        color: Colors.red,
                        padding: const EdgeInsets.all(8.0),
                        child: new Text(
                          "Bajo",
                        ),
                        onPressed: () {
                          if (int.parse(todo.indicator) > 0) {
                            String indicador_string = (int.parse(
                                todo.indicator) - 1).toString();
                            BlocProvider.of<TodosBloc>(context).add(
                              UpdateTodo(
                                todo.copyWith(
                                    task: todo.task,
                                    note: todo.note,
                                    nivel: todo.nivel,
                                    user: todo.user,
                                    formattedAddress: todo.formattedAddress,
                                    lat: todo.lat,
                                    lng: todo.lng,
                                    indicator: indicador_string
                                ),
                              ),
                            );
                            Navigator.pop(context);
                          }
                        }
                    ),

                  ],
                ),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            tooltip: 'Edit Todo',
            child: Icon(Icons.edit),
            onPressed: todo == null
                ? null
                : () {
              if (thisUser == todo.user) {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return AddEditScreen(
                        onSave: (task, note, nivel, user, formattedAddress, lat,
                            lng) {
                          BlocProvider.of<TodosBloc>(context).add(
                            UpdateTodo(
                              todo.copyWith(
                                  task: task,
                                  note: note,
                                  nivel: nivel,
                                  user: user,
                                  formattedAddress: formattedAddress,
                                  lat: lat,
                                  lng: lng),
                            ),
                          );
                        },
                        isEditing: true,
                        todo: todo,
                      );
                    },
                  ),
                );
              }
              else
                _showDialog();
            },
          ),
        );
      },
    );
  }
}
