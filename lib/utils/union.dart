typedef Union1<A> = void Function(
  void Function(A value),
);

typedef Union2<A, B> = void Function(
  void Function(A value),
  void Function(B value),
);

extension AsUnion<T> on T {
  /// Transform the object in a union where the object type is the first type
  /// the union can take.
  ///
  /// ```dart
  /// Union1<int> a = 42.asFirst();
  /// Union2<int, String> b = 42.asFirst();
  /// ```
  Union1<T> asFirst() => (a) => a(this);

  /// Transform the object in a union where the object type is the second type
  /// the union can take.
  ///
  /// ```dart
  /// Union2<String, int> a = 42.asFirst();
  /// Union3<String, int, double> b = 42.asFirst();
  /// ```
  Union2<A, T> asSecond<A>() {
    return (a, b) => b(this);
  }
}
