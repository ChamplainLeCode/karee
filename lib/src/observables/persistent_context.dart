import 'package:karee/src/errors/exceptions/observable_error.dart';

import '../observables/observable.dart';

///
/// Cache implementation for observable state.
///
class PersistentContext {
  static final _context = <Type, dynamic>{};

  ///
  /// Get all data in cache level.
  ///
  Map get cache => _context;

  static Of<T> of<T>() => PersistentContext.getObsWithTag<T>(#base);
  static Of<T> withTag<T>(dynamic tag) => PersistentContext.getObsByTag<T>(tag);

  ///
  /// Setup an observable in cas using its runtime type and observable tag as cache key.
  ///
  static void value<T>(Of<T> obs) {
    assert(obs.value != null);
    if (_context[obs.value.runtimeType] == null) {
      _context[obs.value.runtimeType] = {};
    }
    obs.tag ??= #base;
    _context[obs.value.runtimeType][obs.tag] = obs;
  }

  ///
  /// Persist an observable in cache level with its tag and runtime type.
  ///
  static Of<T> valueWithTag<T>(T value, dynamic tag) {
    assert(tag != null);
    var obs = Of(value)..tag = tag;
    if (_context[obs.value.runtimeType] == null) {
      _context[obs.value.runtimeType] = {};
    }
    _context[obs.value.runtimeType][tag] = obs;
    return obs;
  }

  ///
  /// Get an observable from its tag.
  ///
  static Of<T> getObsByTag<T>(dynamic tag) {
    var entries = _context.entries;
    for (var obsTagEntry in entries) {
      var key = (obsTagEntry.value as Map).entries;
      for (var taggedObs in key) {
        if (taggedObs.key == tag &&
            taggedObs.value is Of &&
            taggedObs.value.value is T) {
          return taggedObs.value as Of<T>;
        }
      }
    }
    throw NoObservableFoundWithTagError(tag);
  }

  ///
  /// Get and observable from it tag and type.
  ///
  static Of<T> getObsWithTag<T>([dynamic tag = #base]) {
    return _context[T]?[tag];
  }

  ///
  /// Remove persisted observable from Cache level.
  ///
  static void remove<E>(Of<E> obs) {
    assert(obs.value != null);
    assert(obs.tag != null);
    var ld = _context[E];
    if (ld == null) {
      return;
    }
    (ld as Map).remove(obs.tag);
  }
}
