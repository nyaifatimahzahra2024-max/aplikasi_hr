import 'package:flutter_bloc/flutter_bloc.dart';

class AppBlocObserver extends BlocObserver {
  @override
  void onEvent(Bloc<dynamic, dynamic> bloc, Object? event) {
    super.onEvent(bloc, event);
    // ignore: avoid_print
    print('[${bloc.runtimeType}] event: $event');
  }

  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    super.onChange(bloc, change);
    // ignore: avoid_print
    print(
      '[${bloc.runtimeType}] '
      '${change.currentState.runtimeType} -> '
      '${change.nextState.runtimeType}',
    );
  }

  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    // ignore: avoid_print
    print('[${bloc.runtimeType}] error: $error');
    super.onError(bloc, error, stackTrace);
  }
}