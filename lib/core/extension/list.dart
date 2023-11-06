extension SafetyListExt<T> on List<T> {
  List<T>? whereOrNull(bool Function(T) test) {
    final list = <T>[];
    for (final element in this) {
      if (test(element)) {
        list.add(element);
      }
    }
    return null;
  }

  T? firstWhereOrNull(bool Function(T) test) {
    for (final element in this) {
      if (test(element)) {
        return element;
      }
    }
    return null;
  }
}
