import 'package:flutter/widgets.dart';
import 'package:goals/model/goal.dart';

abstract class GoalsState {}

class GoalsPrepared extends GoalsState {
  @override
  String toString() => 'GoalsPrepared';
}

class GoalsUpdated extends GoalsState {
  final List<Goal> goals;

  GoalsUpdated({@required this.goals});

  @override
  String toString() => 'GoalsUpdated';
}
