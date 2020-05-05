// Copyright 2018 The Flutter Architecture Sample Authors. All rights reserved.
// Use of this source code is governed by the MIT license that can be found
// in the LICENSE file.

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class TodoEntity extends Equatable {
  final bool complete;
  final String id;
  final String note;
  final String task;
  final String nivel;
  final String indicator;
  final String user;
  final String formattedAddress;
  final String lat;
  final String lng;

  const TodoEntity(this.task, this.id, this.note, this.complete, this.nivel,
      this.indicator, this.user, this.formattedAddress, this.lat, this.lng);

  Map<String, Object> toJson() {
    return {
      "complete": complete,
      "task": task,
      "note": note,
      "id": id,
      "nivel": nivel,
      "indicator": indicator,
      "user": user,
      "user": formattedAddress,
      "user": lat,
      "user": lng
    };
  }

  @override
  List<Object> get props =>
      [
        complete,
        id,
        note,
        task,
        nivel,
        indicator,
        user,
        formattedAddress,
        lat,
        lng
      ];

  @override
  String toString() {
    return 'TodoEntity { complete: $complete, task: $task, note: $note, id: $id , nivel: $nivel , indicator: $indicator , user: $user, formattedAddress: $formattedAddress, lat: $lat, lng: $lng}';
  }

  static TodoEntity fromJson(Map<String, Object> json) {
    return TodoEntity(
      json["task"] as String,
      json["id"] as String,
      json["note"] as String,
      json["complete"] as bool,
        json["nivel"] as String,
        json["indicator"] as String,
        json["user"] as String,
        json["formattedAddress"] as String,
        json["lat"] as String,
        json["lng"] as String
    );
  }

  static TodoEntity fromSnapshot(DocumentSnapshot snap) {
    return TodoEntity(
      snap.data['task'],
      snap.documentID,
      snap.data['note'],
      snap.data['complete'],
      snap.data['nivel'],
      snap.data['indicator'],
      snap.data['user'],
      snap.data['formattedAddress'],
      snap.data['lat'],
      snap.data['lng'],
    );
  }

  Map<String, Object> toDocument() {
    return {
      "complete": complete,
      "task": task,
      "note": note,
      "nivel": nivel,
      "indicator": indicator,
      "user": user,
      "formattedAddress": formattedAddress,
      "lat": lat,
      "lng": lng
    };
  }
}
