import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_life_cycle.g.dart';

@Riverpod(keepAlive: true)
AppLifecycleState appLifeCycle(AppLifeCycleRef ref) {
  final observer = _AppLifeCycleObserver((value) => ref.state = value);

  final binding = WidgetsBinding.instance..addObserver(observer);
  ref
    ..onDispose(() => binding.removeObserver(observer))
    ..listenSelf((previous, next) {});

  return AppLifecycleState.resumed;
}

class _AppLifeCycleObserver extends WidgetsBindingObserver {
  _AppLifeCycleObserver(this._didChangeState);

  final ValueChanged<AppLifecycleState> _didChangeState;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    _didChangeState(state);
  }
}
