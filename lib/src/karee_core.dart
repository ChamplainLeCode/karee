/// `Karee Core` Base library for Karee
library karee_core;

/// package for Screen Annotation management
// export 'package:screen_tracker/screen_tracker.dart' show Screen;
export 'package:karee_inject/karee_inject.dart' show Persistable, Screen, Value, Autowired, Service;

/// package for Controller management
export './controllers/controller.dart' show ControllerReflectable, Controller, subscribeController;

/// package for Route & Router management
export './routes/Router.dart' show Route, KareeRouter, doRouting, RouteMode;

/// package for screen management
export './screens/screens.dart' show screen, subscribeScreen;

/// package for core widget
export './widgets/widget.dart' show KareeMaterialApp;

/// package for enumerations and constances
export './constances/constances.dart' show KareeInstanceProfile, KareeConstants;

/// package for errors management in Karee
export './errors/errors.dart' show ErrorContactAddress;

/// package for application configurations
export './resources/app_config.dart' show loadAppConfig, readConfig;
