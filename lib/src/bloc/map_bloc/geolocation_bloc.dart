import 'dart:async';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter_firebase_flutter_2/src/modelo/userLocation.dart';
import 'package:location/location.dart';

class GeolocationBloc implements BlocBase {
  UserLocation userLocation;

  final StreamController<UserLocation> _userLocationController =
      StreamController<UserLocation>();

  Stream<UserLocation> get outUserLocation => _userLocationController.stream;

  GeolocationBloc() {
    _getUserLocation();
  }

  _getUserLocation() {
    try {
      var location = new Location();
      location.getLocation().then((coords) {
        userLocation = UserLocation(
          latitude: coords.latitude,
          longitude: coords.longitude,
        );

        _userLocationController.sink.add(userLocation);
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void dispose() {
    _userLocationController.close();
  }
}
