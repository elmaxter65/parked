import 'package:equatable/equatable.dart';
import 'package:flutter_firebase_flutter_2/src/repository/crud_firebase/src/models/models.dart';

abstract class StatsEvent extends Equatable {
  const StatsEvent();
}

class UpdateStats extends StatsEvent {
  final List<Todo> todos;

  const UpdateStats(this.todos);

  @override
  List<Object> get props => [todos];

  @override
  String toString() => 'UpdateStats { todos: $todos }';
}
