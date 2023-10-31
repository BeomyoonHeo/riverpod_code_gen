import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

abstract class BaseViewModel<T> extends StateNotifier<T> {
  BaseViewModel(super.state) {
    init();
  }

  @protected
  void init() {}

  @override
  void dispose() {
    super.dispose();
  }

  void changeState(T Function() callback) {
    state = callback.call();
  }
}
