/// `Karee Core` Base library for Karee
library karee_core;

export './constances/library.dart';

export './controllers/controller.dart';

export './errors/library.dart';

export './observables/library.dart' show Of, Observer;

export './resources/library.dart' show loadAppConfig, readConfig;

export './routes/library.dart' show KareeRouter, Route, RouteMode;

export './screens/library.dart' show screen, subscribeScreen;

export './widgets/library.dart'
    show
        ComponentState,
        KareeMaterialApp,
        RoutableWidget,
        RouterWidget,
        ScreenState,
        StatefulComponent,
        StatefulScreen,
        StatelessComponent,
        StatelessScreen;

/// package for Screen Annotation management
// export 'package:screen_tracker/screen_tracker.dart' show Screen;
export 'package:karee_inject/karee_inject.dart'
    show Screen, Value, Autowired, Service, AutowiredAnnotation /**Persistable*/;
