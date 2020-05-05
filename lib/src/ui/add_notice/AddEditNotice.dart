import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_flutter_2/src/repository/crud_firebase/src/models/models.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_place_picker/google_maps_place_picker.dart';


/*Es una funcion que recibe dos valores*/
typedef OnSaveCallback = Function(String task, String note, String nivel, String user, String formattedAddress, String lat, String lng);

class AddEditScreen extends StatefulWidget {
  final bool isEditing;
  final OnSaveCallback onSave;
  final Todo todo;
  final String thisUser;

  AddEditScreen({
    Key key,
    @required this.onSave,
    @required this.isEditing,
    @required this.thisUser,
    this.todo,
  }) : super(key: key);

  @override
  _AddEditScreenState createState() => _AddEditScreenState();
}

class _AddEditScreenState extends State<AddEditScreen> {
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _task;
  String _note;
  String _nivel;
  String _user;

  bool get isEditing => widget.isEditing;
  List<String> _locations = [
    'Menor',
    'Moderada',
    'Seria',
    'Grave',
    'Critica',
    'Maxima'
  ]; // Option 2
  List<String> _accident = [
    'CHOQUE',
    'TERREMOTO',
    'DERRUMBE',
    'CORONAVIRUS'
  ]; // Option 2
  PickResult selectedPlace;
  static final kInitialPosition = LatLng(-33.8567844, 151.213108);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          isEditing ? 'Editar Noticia' : 'Agregar Noticia',
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              DropdownButton(
                hint: isEditing ? Text(widget.todo.task) : Text(
                    'Ingrese un texto'),
                value: _task,
                onChanged: (newValue) {
                  setState(() {
                    _task = newValue;
                  });
                },
                items: _accident.map((location) {
                  return DropdownMenuItem(
                    child: new Text(location),
                    value: location,
                  );
                }).toList(),
              ),
              DropdownButton(
                hint: isEditing ? Text(widget.todo.nivel) : Text(
                    'Nivel de problema'),
                value: _nivel,
                onChanged: (newValue) {
                  setState(() {
                    _nivel = newValue;
                  });
                },
                items: _locations.map((location) {
                  return DropdownMenuItem(
                    child: new Text(location),
                    value: location,
                  );
                }).toList(),
              ),

              TextFormField(
                initialValue: isEditing ? widget.todo.note : '',
                maxLines: 10,
                style: textTheme.subhead,
                decoration: InputDecoration(
                  hintText: 'Agregué información de la noticia',
                ),
                validator: (val) {
                  return val
                      .trim()
                      .isEmpty ? 'Ingrese un texto' : null;
                },
                onSaved: (value) => _note = value,
              ),
              new Text(
                selectedPlace == null ? '' : selectedPlace.formattedAddress,
                style: new TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                  fontFamily: 'Roboto',
                ),
              ),
              RaisedButton(
                child: Text("Ingresar ubicacion"),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return PlacePicker(
                          apiKey: 'AIzaSyDqXewuPJKfBZabt80iDfpyJ3dB4z65FLw',
                          initialPosition: kInitialPosition,
                          useCurrentLocation: true,
                          enableMapTypeButton: false,
                          onPlacePicked: (result) {
                            selectedPlace = result;
                            Navigator.of(context).pop();
                            setState(() {});
                          },
                        );
                      },
                    ),
                  );
                },
              ),

            ],
          ),
        ),
      ),

      floatingActionButton: FloatingActionButton(
        tooltip: isEditing ? 'Save changes' : 'Add Todo',
        child: Icon(isEditing ? Icons.check : Icons.add),
        onPressed: () {
          _user = widget.thisUser;
          if (isEditing && selectedPlace == null) {
            String formattedAddress = widget.todo.formattedAddress;
            String lat = widget.todo.lat;
            String lng = widget.todo.lng;
            if (_formKey.currentState.validate()) {
              _formKey.currentState.save();
              widget.onSave(
                  _task,
                  _note,
                  _nivel,
                  _user,
                  formattedAddress,
                  lat,
                  lng);
              Navigator.pop(context);
            }
          }
          else {
            if (_nivel != null && _task != null && selectedPlace != null) {
              if (_formKey.currentState.validate()) {
                _formKey.currentState.save();
                widget.onSave(
                    _task,
                    _note,
                    _nivel,
                    _user,
                    selectedPlace.formattedAddress,
                    selectedPlace.geometry.location.lat.toString(),
                    selectedPlace.geometry.location.lng.toString());
                Navigator.pop(context);
              }
            }
            else
              _showDialog();
          }
        },
      ),
    );
  }

  void _showDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Informacion incompleta"),
          content: new Text("Complete la informacion para continuar..."),
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
}
