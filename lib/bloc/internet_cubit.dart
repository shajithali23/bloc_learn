import 'dart:async';

import 'package:bloc_learning/internet_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class IntenetCubit extends Cubit<NetworkState> {
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  Connectivity connectivity = Connectivity();
  IntenetCubit({required this.connectivity})
      : assert(connectivity != null),
        super(ConnectionInitial()) {
    _connectivitySubscription =
        connectivity.onConnectivityChanged.listen((connectivityResult) {
      if (connectivityResult == ConnectivityResult.wifi) {
        emitInternetConnected(ConnectionType.wifi);
      } else if (connectivityResult == ConnectivityResult.mobile) {
        emitInternetConnected(ConnectionType.mobile);
      } else if (connectivityResult == ConnectivityResult.none) {
        emitInternetDisconnected();
      }
    });
  }
  void emitInternetConnected(ConnectionType _connectionType) =>
      emit(ConnectionSuccess(connectionType: _connectionType));

  void emitInternetDisconnected() => emit(ConnectionFailure());

  @override
  Future<void> close() {
    _connectivitySubscription.cancel();
    return super.close();
  }
}
