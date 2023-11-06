import 'package:hooks_riverpod/hooks_riverpod.dart';

extension AsyncValueExt<T> on AsyncValue<T> {
  Future<AsyncValue<T>> guardPlus(Future<T> Function() future) async {
    try {
      return AsyncValue<T>.data(await future());
    } catch (e, stackTrace) {
      return AsyncValue<T>.error(e, stackTrace).copyWithPrevious(this);
    }
  }
}
