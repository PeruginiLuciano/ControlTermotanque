// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyAutg7YmcoRZqs1u-6mMvdt3Xb7Lk6vQEQ',
    appId: '1:1028420292905:web:70e9a0957c3a8f89b9a738',
    messagingSenderId: '1028420292905',
    projectId: 'domotikapp-b7876',
    authDomain: 'domotikapp-b7876.firebaseapp.com',
    storageBucket: 'domotikapp-b7876.appspot.com',
    measurementId: 'G-BXFPWJEHPM',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBC3YtjoY34hdSzYMqWUgWZ7Fm1XT9K0yY',
    appId: '1:1028420292905:android:43323a468f76f8f7b9a738',
    messagingSenderId: '1028420292905',
    projectId: 'domotikapp-b7876',
    storageBucket: 'domotikapp-b7876.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDuvSsuzA9DTcGtaszhmCMdiAsr_C5wENw',
    appId: '1:1028420292905:ios:c235e2fe15b4fe68b9a738',
    messagingSenderId: '1028420292905',
    projectId: 'domotikapp-b7876',
    storageBucket: 'domotikapp-b7876.appspot.com',
    iosClientId: '1028420292905-1srkpik0riaial78nf717f25rejdfmf3.apps.googleusercontent.com',
    iosBundleId: 'com.example.prueba',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDuvSsuzA9DTcGtaszhmCMdiAsr_C5wENw',
    appId: '1:1028420292905:ios:c235e2fe15b4fe68b9a738',
    messagingSenderId: '1028420292905',
    projectId: 'domotikapp-b7876',
    storageBucket: 'domotikapp-b7876.appspot.com',
    iosClientId: '1028420292905-1srkpik0riaial78nf717f25rejdfmf3.apps.googleusercontent.com',
    iosBundleId: 'com.example.prueba',
  );
}
