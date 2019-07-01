import 'package:flutter/material.dart';
import 'package:goals/bloc/goals/goals.dart';
import 'package:goals/model/goal.dart';
import 'package:goals/resources/colors.dart';
import 'package:goals/resources/res.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'add_new_goal_screen.dart';

class GoalsListScreen extends StatelessWidget {
  final GoalsBloc _bloc = GoalsBloc();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
        bloc: _bloc,
        builder: (context, state) {
          return Scaffold(
            appBar: _buildAppBar(),
            body: _buildBody(state),
            floatingActionButton: _buildAddNewGoalFab(context),
          );
        });
  }

  Widget _buildAppBar() {
    return AppBar(
      centerTitle: true,
      backgroundColor: AppColors.grey,
      title: SafeArea(
        child: Text(AppStrings.goalsListTitle),
      ),
      elevation: 0,
    );
  }

  Widget _buildAddNewGoalFab(BuildContext context) {
    return FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: AppColors.orange,
        onPressed: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (_) {
                return AddNewGoalScreen(
                  onCreate: (name, date) => _bloc
                      .dispatch(AddGoal(goal: Goal(name: name, date: date))),
                );
              },
            )));
  }

  Widget _buildBody(GoalsState state) {
    if (state is GoalsPrepared) {
      return _buildEmptyGoalsList();
    } else if (state is GoalsUpdated) {
      return _buildGoalsList(state.goals);
    } else {
      return Container(
        child: Text('wtf?!'),
      );
    }
  }

  Widget _buildEmptyGoalsList() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(
            Icons.error_outline,
            size: 50,
            color: AppColors.orange,
          ),
          SizedBox(height: 10),
          Text(AppStrings.goalsEmptyListTitle,
              style: TextStyle(fontSize: 18, color: AppColors.orange)),
        ],
      ),
    );
  }

  Widget _buildGoalsList(List<Goal> goals) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: goals.length,
        itemBuilder: (context, index) {
          return _buildGoalListItem(goals[index]);
        });
  }

  Widget _buildGoalListItem(Goal goal) {
    return Container(
      decoration: BoxDecoration(
          color: AppColors.black,
          borderRadius: BorderRadius.all(Radius.circular(12))),
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            goal.name,
            style: TextStyle(
                color: AppColors.white,
                fontSize: 20,
                fontWeight: FontWeight.w700),
          ),
          SizedBox(height: 10),
          Text(
            goal.leftTime(),
            style: TextStyle(
                color: AppColors.white,
                fontSize: 16,
                fontWeight: FontWeight.w400),
          )
        ],
      ),
    );
  }
}
