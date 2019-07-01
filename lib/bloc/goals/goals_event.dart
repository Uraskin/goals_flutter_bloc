import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:goals/model/goal.dart';

abstract class GoalsEvent extends Equatable {}

class InitGoals extends GoalsEvent {
  @override
  String toString() => 'InitGoals';
}


class UpdateGoals extends GoalsEvent {
  @override
  String toString() => 'UpdateGoals';
}

class AddGoal extends GoalsEvent {
  final Goal goal;

  AddGoal({@required this.goal});

  @override
  String toString() => 'AddGoal { goald: $goal }';
}

class UpdateCounter extends GoalsEvent {
  @override
  String toString() => 'UpdateCounter';
}
