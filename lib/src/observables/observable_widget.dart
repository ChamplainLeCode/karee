import 'package:flutter/widgets.dart';
import './persistent_context.dart';
import './observable.dart';
import '../widgets/screen_widget.dart';

/// An overriding of WidgetBuilder
typedef _OfBuilder<K> = Widget Function(BuildContext ctx);

/// An overloading of see [_OfBuilder<K>] use tu send state on building
typedef _OfBuilderWithState<K> = Widget Function(BuildContext ctx, Of<K> state);

/// ### Observer<T>
/// Used as base Widget of this library. When you want to watch changes on an object
/// add this widget in your flutter tree.
///
class Observer<T> extends _ObservableElement<T> {
  /// ### Definition
  /// ObserverBuilder for watching changes on an object, by sending its Type
  /// ### Usage
  /// To use this, you should first setup the provider for this type. Means you should
  ///
  /// send the general instance of this type in `KareeMaterialApp` to watch
  /// in all your application
  /// ```dart
  ///   Observer.on<int>(
  ///     builder: (ctx, counterObs) {
  ///     return Text('general counter ${counterObs.value}');
  ///   }),
  /// ```
  ///
  /// see also [Observer.withProviders]
  static _OfWidgetBuilder<E> on<E>({dynamic? tag = #base, required _OfBuilderWithState<E> builder}) {
    return _OfWidgetBuilder<E>(of: PersistentContext.getObsWithTag(E, tag), child: builder);
  }

  /// ### Definition
  /// Observer.withProviders method use to register objects to observe in your application
  /// ### Usage
  /// To use this, just provide all observable instance and a widgetBuilder
  /// ```dart
  ///    Observer.withProviders(
  ///       providers: [Of(User(firstName: 'Mark', lastName: 'Ngourtchou'))],
  ///       child: (ctx) {
  ///         return Scaffold(
  ///           body: Observe.on<User>(
  ///             builder: (ctx, userObs) =>
  ///               Text(
  ///                 'Welcome ${userObs.value.firstName}'
  ///                 ' ${userObs.value.lastName}')
  ///           )
  ///         );
  ///       }
  ///     )
  /// ```
  ///
  /// see also [Observer.withProviders]
  static Widget withProviders({required List<Of> providers, required _OfBuilder child}) {
    return _OfWidgetProvider(obs: providers, child: child);
  }

  /// ### Definition
  /// Observer: To watch changes of a specific object, send this one as value of property **of**
  ///
  /// and provide a widget builder that will be used when your watched object changes.
  ///
  /// ### Usage
  /// To use this, you should first setup the provider for this type. Means you should
  ///
  /// send the general instance of this type in `KareeMaterialApp` to watch
  /// in all your application
  /// ```dart
  ///   final counter = Of(0);
  ///   Observer.on<int>(
  ///     of: counter,
  ///     child: (ctx) {
  ///     return Text('Counter value ${counter.value}');
  ///   }),
  /// ```
  ///
  /// see [Observer.withProviders]
  ///
  /// see also [Observer.on]
  Observer({required Of<T> of, required _OfBuilder<T> child}) : super(of, child);

  _OfWidgetManager<T> createState() => _OfWidgetManager<T>();
}

class _OfWidgetManager<T> extends _ObservableState<T> {
  @override
  void _notifyUpdate(T value) {
    widget.child(context);
    super._notifyUpdate(value);
  }
}

class _OfWidgetBuilder<E> extends _ObservableElementWithState<E> {
  _OfWidgetBuilder({required _OfBuilderWithState<E> child, required Of<E> of}) : super(of, child);

  @override
  _OfWidgetBuilderStateManager<E> createState() => _OfWidgetBuilderStateManager<E>();
}

class _OfWidgetBuilderStateManager<E> extends _ObservableStateWithObs<E> {
  @override
  void _notifyUpdate(E value) {
    widget.child(context, widget.of);
    super._notifyUpdate(value);
  }
}

class _OfWidgetProvider<T> extends StatelessComponent {
  final List<Of<T>> obs;
  final _OfBuilder<T> child;
  _OfWidgetProvider({required this.obs, required this.child}) {
    obs.forEach((obs) {
      PersistentContext.value(obs);
    });
  }

  @override
  Widget builder(BuildContext context) {
    return child(context);
  }
}

abstract class _ObservableElement<E> extends StatefulComponent {
  late final Of<E> of;

  late final _OfBuilder<E> child;
  _ObservableElement(this.of, this.child);
}

abstract class _ObservableState<E> extends ComponentState<_ObservableElement<E>> {
  initState() {
    widget.of.listen(_notifyUpdate);
    super.initState();
  }

  @override
  void didUpdateWidget(_ObservableElement<E> oldWidget) {
    super.didUpdateWidget(oldWidget);
    final oldObs = oldWidget.of;
    final currentObs = widget.of;
    if (currentObs != oldObs) oldObs.unListen(_notifyUpdate);
    currentObs.listen(_notifyUpdate);
  }

  @mustCallSuper
  void _notifyUpdate(E value) {
    if (mounted) super.update();
  }

  @override
  void dispose() {
    widget.of.unListen(_notifyUpdate);
    super.dispose();
  }

  @override
  Widget builder(BuildContext context) {
    return widget.child(context);
  }
}

abstract class _ObservableElementWithState<E> extends StatefulComponent {
  late final Of<E> of;

  late final _OfBuilderWithState<E> child;
  _ObservableElementWithState(this.of, this.child);
}

abstract class _ObservableStateWithObs<E> extends ComponentState<_ObservableElementWithState<E>> {
  initState() {
    widget.of.listen(_notifyUpdate);
    super.initState();
  }

  @override
  void didUpdateWidget(_ObservableElementWithState<E> oldWidget) {
    super.didUpdateWidget(oldWidget);
    final oldObs = oldWidget.of;
    final currentObs = widget.of;
    if (currentObs != oldObs) oldObs.unListen(_notifyUpdate);
    currentObs.listen(_notifyUpdate);
  }

  @mustCallSuper
  void _notifyUpdate(E value) {
    if (mounted) super.update();
  }

  @override
  void dispose() {
    widget.of.unListen(_notifyUpdate);
    super.dispose();
  }

  @override
  Widget builder(BuildContext context) {
    return widget.child(context, widget.of);
  }
}
