import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppBlocObserver extends BlocObserver {
  @override
  void onTransition(Bloc bloc, Transition transition) {
    debugPrint('AppBlocObserver: ${transition.toString()}');
    super.onTransition(bloc, transition);
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    debugPrint('AppBlocObserver Error: $error');
    debugPrint('AppBlocObserver Error: $stackTrace');

    super.onError(bloc, error, stackTrace);
  }
}
