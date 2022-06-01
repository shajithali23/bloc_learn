import 'package:bloc_learning/pages/counter_page.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/counter_cubit.dart';
import 'bloc/internet_cubit.dart';

void main() {
  runApp(MyApp(
    connectivity: Connectivity(),
  ));
}

class MyApp extends StatelessWidget {
  MyApp({Key? key, required this.connectivity}) : super(key: key);
  Connectivity connectivity;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => IntenetCubit(connectivity: connectivity),
          ),
          BlocProvider(
            create: (_) => CounterCubit(),
          ),
        ],
        child: CounterPage(),
      ),
    );
  }
}
