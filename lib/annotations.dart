/// ## Karee Annotation
/// This library helps you to know all the annotations used by Karee.
/// Each of them are useful and works with code generation.
/// ## Annotations exposed
/// - [Autowired]
/// - [KareeInjector]
/// - [Module]
/// - [Screen]
/// - [Service]
/// - [Value]

library karee.annotations;

export 'package:karee_inject/karee_inject.dart'
    show
        Controller,
        Screen,
        Value,
        Autowired,
        Service,
        Module /**Persistable*/,
        KareeInjector;
