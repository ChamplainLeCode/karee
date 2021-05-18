import 'package:karee_core/src/observables/observable.dart';

/// Cache implementation for observable state.
class PersistentContext {
  static final _context = <Type, dynamic>{};

  Map get cache => _context;

  static Of<T> of<T>() => _context[T];

  static Of<T> tag<T>(dynamic tag) {
    assert(tag != null);
    return _context[tag];
  }

  static void value<T>(Of<T> obs) {
    _context[obs.value.runtimeType] = obs;
  }

  static void valueWithTag<T>(Of<T> obs, dynamic tag) {
    assert(tag != null);
    if (_context[T] == null) {
      _context[T] = {};
    }
    _context[T][tag] = obs;
  }
}
