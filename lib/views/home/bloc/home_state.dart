abstract class HomeState {
  final bool isChatEnabled;

  const HomeState({this.isChatEnabled = true});
}

class InitialHomeState extends HomeState {
  const InitialHomeState({super.isChatEnabled});
}

class LoadingHomeState extends HomeState {
  const LoadingHomeState({super.isChatEnabled});
}

class LoadedHomeState extends HomeState {
  final String response;

  const LoadedHomeState({required this.response, super.isChatEnabled});
}

class ErrorHomeState extends HomeState {
  final String error;

  const ErrorHomeState({required this.error});
}
