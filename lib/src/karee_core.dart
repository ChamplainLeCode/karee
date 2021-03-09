/// `Karee Core` Base library for Karee
library karee_core;

/// package for Screen Annotation management
export 'package:screen_tracker/screen_tracker.dart' show Screen;

/// package for Controller management
export './controllers/controller.dart'
    show ControllerReflectable, Controller, subscribeController;

/// package for Route & Router management
export './routes/Router.dart' show Route, KareeRouter, doRouting, RouteMode;

/// package for screen management
export './screens/screens.dart' show screen, subscribeScreen;

/// package for core widget
export './widgets/karee_material_app.dart' show KareeMaterialApp;
