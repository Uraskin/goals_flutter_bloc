import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:goals/app.dart';

import 'bloc/block_delegate.dart';

void main() {
  BlocSupervisor().delegate = SimpleBlocDelegate();
  return runApp(GolasApp());
} 

