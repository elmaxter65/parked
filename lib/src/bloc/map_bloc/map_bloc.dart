import 'dart:async';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter_firebase_flutter_2/src/bloc/crub_firebase/todos.dart';
import 'package:flutter_firebase_flutter_2/src/repository/crud_firebase/src/firebase_todos_repository.dart';
import 'package:flutter_firebase_flutter_2/src/repository/crud_firebase/src/models/models.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rxdart/rxdart.dart';

class MapBloc implements BlocBase {
  Todo focusedPlace;
  List<Todo> places = <Todo>[
    Todo("task", "nivel", "user", "formattedAddress", "6.1431564",
        "-75.37938539999999",
        note: "ddqd")
  ];
  Map<MarkerId, Marker> markers = {};

  final StreamController _placesController = BehaviorSubject<List<Todo>>();

  final StreamController<Todo> _placeFocusedController =
      StreamController<Todo>();

  final StreamController<Map<MarkerId, Marker>> _markersController =
      StreamController<Map<MarkerId, Marker>>();

  Stream<List<Todo>> get outPlaces => _placesController.stream;

  Stream<Todo> get outPlaceFocused => _placeFocusedController.stream;

  Stream<Map<MarkerId, Marker>> get outMarkers => _markersController.stream;

  Sink get inFocusPlace => _placeFocusedController.sink;

  MapBloc() {
    (TodosBloc(
      todosRepository: FirebaseTodosRepository(),
    )..add(LoadTodos()))
        .forEach((f) {
      f.props.forEach((x) {
        _placesController.sink.add(x);
        _createMarkers(x);
        _markersController.sink.add(markers);
        _placeFocusedController.stream.listen(_focusPlace);
      });
    });
  }

  void _createMarkers(List<Todo> places) {
    places.forEach((el) {
      final MarkerId _markerId = MarkerId(el.id.toString());

      Marker _marker = Marker(
        markerId: _markerId,
        position: LatLng(double.parse(el.lat), double.parse(el.lng)),
        infoWindow: InfoWindow(
          title: el.task,
          snippet: '${el.formattedAddress}',
        ),
        icon: BitmapDescriptor.defaultMarker,
      );

      markers[_markerId] = _marker;
    });
  }

  void _focusPlace(Todo place) {
    focusedPlace = place;
  }

  @override
  void dispose() {
    _placesController.close();
    _placeFocusedController.close();
    _markersController.close();
  }
}
