export 'database_service_interface.dart';

export 'database_service_native.dart'
    if (dart.library.js_interop) 'database_service_web.dart';
