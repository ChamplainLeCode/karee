import 'package:karee/src/errors/exceptions/observable_error.dart';

import '../observables/observable.dart';

///
/// Cache implementation for observable state.
///
class PersistentContext {
  static final _context = <Type, dynamic>{};

  ///
  /// `Getter` of all data in cache level.
  ///
  Map get cache => _context;

  /// **of()** Method to retrieve an observable.
  static Of<T> of<T>() => PersistentContext.getObsWithTag<T>(#base);

  /// **withTag()** Method to retrieve an observable from a provider `tag`
  /// reference.
  static Of<T> withTag<T>(dynamic tag) => PersistentContext.getObsByTag<T>(tag);

  ///
  /// **value()** Setup an observable in Cache using its runtime type and
  /// observable tag as Cache key.
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
  /// **valueWithTag()** Persist an observable in Cache level with its tag and
  /// runtime type.
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
  /// **getObsByTag()** Get an observable from its tag.
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
  /// **getObsWithTag()** Get and observable from its tag and type.
  ///
  static Of<T> getObsWithTag<T>([dynamic tag = #base]) {
    return _context[T]?[tag];
  }

  ///
  /// **remove()** Remove persisted observable from Cache level.
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
