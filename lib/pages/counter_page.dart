import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/counter_cubit.dart';
import '../bloc/internet_cubit.dart';
import '../internet_state.dart';

class CounterPage extends StatelessWidget {
  const CounterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bloc Cubit"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BlocBuilder<IntenetCubit, NetworkState>(
            builder: (context, state) {
              if (state is ConnectionSuccess &&
                  state.connectionType == ConnectionType.wifi) {
                return Text(
                  'Wifi',
                  style: TextStyle(color: Colors.green, fontSize: 30),
                );
              } else if (state is ConnectionSuccess &&
                  state.connectionType == ConnectionType.mobile) {
                return Text(
                  'Mobile',
                  style: TextStyle(color: Colors.yellow, fontSize: 30),
                );
              } else if (state is ConnectionFailure) {
//                 SnackBar snackBar = SnackBar(
//                   content: Text('Yay! A SnackBar!'),
//                 );

// // Find the ScaffoldMessenger in the widget tree
// // and use it to show a SnackBar.
//                 ScaffoldMessenger.of(context).showSnackBar(snackBar);
                return Text("DISCONNECTED");
              }
              return CircularProgressIndicator();
            },
          ),
          BlocBuilder<CounterCubit, int>(
            builder: (context, count) => Center(child: Text('$count')),
          ),
        ],
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          FloatingActionButton(
            onPressed: () {
              print(context.read<CounterCubit>().state);
              context.read<CounterCubit>().increment();
            },
            child: Icon(Icons.add),
          ),
          FloatingActionButton(
            backgroundColor: Colors.red,
            onPressed: () {
              if (context.read<CounterCubit>().state != 0) {
                context.read<CounterCubit>().decrement();
              }
            },
            child: Icon(Icons.remove),
          ),
        ],
      ),
    );
  }
}
