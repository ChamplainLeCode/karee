import '../observables/observable.dart';

/// Cache implementation for observable state.
class PersistentContext {
  static final _context = <Type, dynamic>{};

  Map get cache => _context;

  static Of<T> of<T>() => PersistentContext.getObsWithTag(T, #base);
  static Of withTag(dynamic tag) => PersistentContext.getObsByTag(tag);

  // static Of<T> tag<T>(dynamic tag) {
  //   assert(tag != null);
  //   return _context[tag];
  // }

  static void value<T>(Of<T> obs) {
    assert(obs.value != null);
    if (_context[obs.value.runtimeType] == null) {
      _context[obs.value.runtimeType] = {};
    }
    obs.tag = #base;
    _context[obs.value.runtimeType][obs.tag] = obs;
  }

  static Of<T> valueWithTag<T>(T value, dynamic tag) {
    assert(tag != null);
    var obs = Of(value)..tag = tag;
    if (_context[obs.value.runtimeType] == null) {
      _context[obs.value.runtimeType] = {};
    }
    _context[obs.value.runtimeType][tag] = obs;
    return obs;
  }

  static Of getObsByTag(dynamic tag) {
    var entries = _context.entries;
    for (var obsTagEntry in entries) {
      var key = (obsTagEntry.value as Map).entries;
      for (var taggedObs in key) {
        if (taggedObs.key == tag) {
          return taggedObs.value;
        }
      }
    }
    throw Exception('No Observable with tag $tag');
  }

  static Of<T> getObsWithTag<T>(Type t, [dynamic tag = #base]) {
    return _context[T]?[tag];
  }

  static void remove<E>(Of<E> obs) {
    assert(obs.value != null);
    assert(obs.tag != null);
    var ld;
    if ((ld = _context[E]) == null) {
      return;
    }
    (ld as Map).remove(obs.tag);
  }
}
