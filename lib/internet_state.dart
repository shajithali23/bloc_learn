enum ConnectionType {
  wifi,
  mobile,
}

abstract class NetworkState {}

class ConnectionInitial extends NetworkState {}

class ConnectionSuccess extends NetworkState {
  final ConnectionType connectionType;

  ConnectionSuccess({required this.connectionType});
}

class ConnectionFailure extends NetworkState {}
