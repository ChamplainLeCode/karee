/// ## Karee State Manager
///
/// Lite State manager integrate in Karee. it helps you to mange your UI
/// by providing you a Widget that can be refresh on change on its observable.
///
/// Karee Lit State Manager offers you
///
/// ### Observable
///
/// - Of: Observable used to subscribe listener on change
///   * **Of(T value)** that builds an observable from a value
///   * **Of<T>.type()** that retrieves an observable for a specific type
///
/// ### Observer
///
/// - Observer: Widget that read changes of Observable
///   * **Observer.on<T>**: Widget that watches changes on observable of type T
///   * **Observer()**: Widget that whatches changes on specifed observable
library karee_core.state_manager;

export 'observable.dart';
export 'persistent_context.dart';
export 'observable_widget.dart';
