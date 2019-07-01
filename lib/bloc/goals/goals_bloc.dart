import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:goals/model/goal.dart';
import 'goals.dart';

class GoalsBloc extends Bloc<GoalsEvent, GoalsState> {
  StreamSubscription streamCounter;

  List<Goal> goals = [];

  @override
  GoalsState get initialState => GoalsPrepared();

  @override
  Stream<GoalsState> mapEventToState(GoalsEvent event) async* {
    if (event is AddGoal) {
      if (streamCounter == null) {
        streamCounter =
            Stream.periodic(Duration(milliseconds: 50), (timer) => timer)
                .listen((count) => this.dispatch(UpdateCounter()));
      }

      goals.add(event.goal);
      yield GoalsUpdated(goals: goals);
    }

    if (event is UpdateCounter) {
      goals.forEach(
          (goal) => goal.timeLeft = goal.date.difference(DateTime.now()));
      yield GoalsUpdated(goals: goals);
    }
  }

  @override
  void dispose() {
    streamCounter.cancel();
    super.dispose();
  }
}
