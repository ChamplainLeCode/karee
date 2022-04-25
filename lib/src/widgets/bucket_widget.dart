import 'dart:math' as math show Point;

import 'package:flutter/material.dart';
import '../observables/observable.dart';
import 'screen_widget.dart';
import '../observables/observable_widget.dart';

///
/// Bucket Widget, a new Material widget that provides you a simple and pretty
/// way to send your main menu behind of screen. To take full advantages of this
/// we recommend you to set a RouterWidget as his child.
///
class Bucket extends StatefulComponent {
  /// **child** of the bucket, this widget is displayed at the top layer
  final Widget child;

  /// **decoration** is used to decorate the background of the
  /// bottom layer
  final Decoration? decoration;

  /// **drawer** is used as the background widget shown behind the child
  final Widget? drawer;

  /// **enableBucketDragGesture** Whether this bucket should been opened or
  /// closed through the drag
  final bool enableBucketDragGesture;

  /// **onBucketChange** function triggered when the bucket is opened or closed
  final void Function(bool)? onBucketChange;

  /// Bucket Widget, a new Material widget that provides you a simple and pretty
  /// way to send your main menu behind of screen. To take full advantages of this
  /// we recommend you to set a RouterWidget as his child.
  Bucket(
      {required this.child,
      this.decoration,
      this.drawer,
      this.enableBucketDragGesture = true,
      this.onBucketChange,
      Key? key})
      : super(key: key);

  @override
  BucketState createState() => BucketState();

  static BucketState? of(BuildContext context) {
    var st = context.findAncestorStateOfType<BucketState>();
    return st;
  }
}

class BucketState extends ComponentState<Bucket> {
  late final Widget _child;

  late final Of<math.Point<double>> _childPosition;

  Of<Size>? _bucketChildSize;

  bool _bucketActionLock = true;

  math.Point? _dragStartPoint;

  bool get isOpen => !_bucketActionLock;

  late final math.Point<double> _bucketLockEndPoint =
      math.Point(screenSize.width * .80, screenSize.height * .125);

  late final math.Point<double> _bucketLockStartPoint = math.Point(0, 0);

  initState() {
    _child = widget.child;
    _childPosition = Of(math.Point(0.0, 0.0));
    super.initState();
  }

  void dispose() {
    try {
      context.findAncestorStateOfType<BucketActionButtonState>()?.dispose();
    } catch (e) {
    } finally {
      super.dispose();
    }
  }

  Widget builder(BuildContext context) {
    _bucketChildSize ??= Of(Size.copy(screenSize));

    return GestureDetector(
        onHorizontalDragStart:
            !widget.enableBucketDragGesture ? null : _onBucketDragStart,
        onHorizontalDragEnd:
            !widget.enableBucketDragGesture ? null : _onBucketDragEnd,
        onHorizontalDragUpdate:
            !widget.enableBucketDragGesture ? null : _onBucketDragged,
        child: Stack(children: [
          Positioned(
              top: 0,
              left: 0,
              width: screenSize.width,
              height: screenSize.height,
              child: Material(
                  child: SafeArea(
                      top: false,
                      child: Container(
                        decoration: widget.decoration,
                        child: widget.drawer,
                      )))),
          Observer(
              of: _childPosition,
              child: (_) => AnimatedPositioned(
                  duration: Duration(milliseconds: 200),
                  top: _childPosition.value.y,
                  left: _childPosition.value.x,
                  width: _bucketChildSize?.value.width ?? screenSize.width,
                  height: _bucketChildSize?.value.height ?? screenSize.height,
                  child: ClipRRect(
                      borderRadius: _bucketActionLock
                          ? BorderRadius.zero
                          : BorderRadius.circular(20),
                      child: GestureDetector(
                          onTap: _bucketActionLock ? null : close,
                          child: _child)))),
        ]));
  }

  void _onBucketDragStart(DragStartDetails d) =>
      _dragStartPoint = math.Point(d.globalPosition.dx, d.globalPosition.dy);

  void _onBucketDragEnd(DragEndDetails d) => !isBucketOpen
      ? _childPosition.value.x >= 100
          ? open()
          : close()
      : (_bucketLockEndPoint.x - _childPosition.value.x).abs() >= 100
          ? close()
          : open();

  void _onBucketDragged(DragUpdateDetails dragInfo) {
    double dx = 0;

    if (_bucketActionLock) {
      if (dragInfo.globalPosition.dx < _dragStartPoint!.x.toDouble())
        dx = _bucketLockStartPoint.x;
      else
        dx = _dragStartPoint!.distanceTo(
            math.Point(dragInfo.globalPosition.dx, _dragStartPoint!.y));
      _childPosition.value = math.Point(dx, dx / 2);
    } else {
      if (dragInfo.globalPosition.dy > _bucketLockEndPoint.y ||
          dragInfo.globalPosition.dy > _dragStartPoint!.y) if (dragInfo
              .globalPosition.dx >
          _dragStartPoint!.x) {
        dx = 0;
      } else
        dx = _dragStartPoint!.x - dragInfo.globalPosition.dx;

      var absDx = _bucketLockEndPoint.x - dx;
      _childPosition.value =
          math.Point(absDx < 0 ? 0 : absDx, _bucketLockEndPoint.y);
    }
  }

  /// **isBucketOpen** Getter used to know whether the bucket is open or not
  bool get isBucketOpen => !_bucketActionLock;

  ///
  /// **void open()** Method used to open the bucket
  ///
  void open() {
    _bucketActionLock = false;
    _childPosition.value = _bucketLockEndPoint;
    if (widget.onBucketChange != null)
      Future.microtask(() => widget.onBucketChange!(true));
    _bucketChildSize?.value =
        Size(screenSize.width * .80, screenSize.height * .8);
  }

  ///
  /// **void close()** Methode used to close the bucket
  void close() {
    _bucketActionLock = true;
    _bucketChildSize?.value = screenSize;
    if (widget.onBucketChange != null)
      Future.microtask(() => widget.onBucketChange!(false));
    _childPosition.value = _bucketLockStartPoint;
  }
}

///
/// BucketActionButton, is used as the default button to manage event on Bucket
///
class BucketActionButton extends StatefulComponent {
  ///
  /// **icon** an animated Icon Date, use when bucket changes its state
  ///
  final AnimatedIconData icon;

  ///
  /// BucketActionButton, is used as the default button to manage event on Bucket
  ///
  BucketActionButton({required this.icon, Key? key}) : super(key: key);

  BucketActionButtonState createState() => BucketActionButtonState();
}

class BucketActionButtonState extends ComponentState<BucketActionButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _iconAnimationController;

  @override
  initState() {
    _iconAnimationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );
    super.initState();
  }

  @override
  dispose() {
    _iconAnimationController.dispose();
    super.dispose();
  }

  Widget builder(BuildContext context) {
    return IconButton(
        icon:
            AnimatedIcon(icon: widget.icon, progress: _iconAnimationController),
        onPressed: () {
          var state = Bucket.of(context);
          if (state == null) return;
          if (state.isOpen) {
            closeBucket();
          } else {
            openBucket();
          }
        });
  }

  ///
  /// Method used to send *close event* to default Bucket.
  ///
  /// Bucket is accessed through **Bucket.of(context)**
  void closeBucket() {
    Bucket.of(context)?.close();
    Future.microtask(() => _iconAnimationController.animateTo(0));
  }

  ///
  /// Method used to animate the passed icon
  ///
  void animateIcon(bool state) => state
      ? Future.microtask(() => _iconAnimationController.animateBack(1))
      : Future.microtask(() => _iconAnimationController.animateTo(0));

  /// Method used to sent *open event* of the default Bucket
  ///
  /// Bucket is accessed through **Bucket.of(context)**
  ///
  void openBucket() {
    Bucket.of(context)?.open();
    Future.microtask(() => _iconAnimationController.animateBack(1));
  }
}
