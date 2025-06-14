import 'package:flutter/foundation.dart';

@immutable
sealed class HomeState {
  const HomeState();

  bool get isChatEnabled => true;
}

class InitialHomeState extends HomeState {
  const InitialHomeState();
}

class LoadingHomeState extends HomeState {
  const LoadingHomeState();
}

class ListeningHomeState extends HomeState {
  const ListeningHomeState();

  @override
  bool get isChatEnabled => false;
}

class LoadedHomeState extends HomeState {
  final String response;

  const LoadedHomeState({required this.response});
}

class ErrorHomeState extends HomeState {
  final String error;

  const ErrorHomeState({required this.error});
}
