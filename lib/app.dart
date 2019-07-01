import 'package:flutter/material.dart';
import 'package:goals/resources/colors.dart';
import 'package:goals/ui/goals_list_screen.dart';

class GolasApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My goals app',
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.grey,
        accentColor: AppColors.orange,
      ),
      home: GoalsListScreen(),
    );
  }
}
