import 'package:meta/meta.dart';

import '../entities/entities.dart';

@immutable
class Todo {
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

  Todo(this.task, this.nivel, this.user, this.formattedAddress, this.lat,
      this.lng,
      {this.complete = false, String note = '', String id, String indicator})
      : this.note = note ?? '',
        this.id = id,
        this.indicator=indicator ?? '0';

  Todo copyWith(
      {bool complete, String id, String note, String task, String nivel, String indicator, String user, String formattedAddress, String lat, String lng}) {
    return Todo(
      task ?? this.task,
      nivel ?? this.nivel,
      user ?? this.user,
      formattedAddress ?? this.formattedAddress,
      lat ?? this.lat,
      lng ?? this.lng,
      complete: complete ?? this.complete,
      id: id ?? this.id,
      note: note ?? this.note,
      indicator: indicator ?? this.indicator,
    );
  }

  @override
  int get hashCode =>
      complete.hashCode ^ task.hashCode ^ note.hashCode ^ id.hashCode ^ nivel
          .hashCode ^ indicator.hashCode ^ user.hashCode ^ formattedAddress
          .hashCode ^ lat.hashCode ^ lng.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Todo &&
          runtimeType == other.runtimeType &&
          complete == other.complete &&
          task == other.task &&
          note == other.note &&
          id == other.id &&
          nivel == other.nivel &&
          indicator == other.indicator &&
          user == other.user &&
          formattedAddress == other.formattedAddress &&
          lat == other.lat &&
          lng == other.lng;

  @override
  String toString() {
    return 'Todo{complete: $complete, task: $task, note: $note, id: $id, nivel: $nivel, indicator: $indicator, user: $user, formattedAddress: $formattedAddress, lat: $lat, lng: $lng}';
  }

  TodoEntity toEntity() {
    return TodoEntity(
        task,
        id,
        note,
        complete,
        nivel,
        indicator,
        user,
        formattedAddress,
        lat,
        lng);
  }

  static Todo fromEntity(TodoEntity entity) {
    return Todo(
      entity.task,
      entity.nivel,
      entity.user,
      entity.formattedAddress,
      entity.lat,
      entity.lng,
      complete: entity.complete ?? false,
      note: entity.note,
      id: entity.id,
      indicator: entity.indicator,
    );
  }
}
