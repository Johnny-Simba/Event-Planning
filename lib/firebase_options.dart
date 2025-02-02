// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
        return windows;
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
    apiKey: 'AIzaSyBsdm3-CoWNvqVAEIvMJKPiugP5v1oogA8',
    appId: '1:1060594657622:web:941b3f5de9c5ea9070cef7',
    messagingSenderId: '1060594657622',
    projectId: 'event-planning-b4c48',
    authDomain: 'event-planning-b4c48.firebaseapp.com',
    storageBucket: 'event-planning-b4c48.firebasestorage.app',
    measurementId: 'G-LXHKDC3M82',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAaHfu5PiTn-fcc2jIvR1tpr9TVBb0iVWA',
    appId: '1:1060594657622:android:cc5fb081d95eec6370cef7',
    messagingSenderId: '1060594657622',
    projectId: 'event-planning-b4c48',
    storageBucket: 'event-planning-b4c48.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCTiB9dVdfgq-OuujwEN4ATDsfZZ5aN4D8',
    appId: '1:1060594657622:ios:6de753c95643b3b770cef7',
    messagingSenderId: '1060594657622',
    projectId: 'event-planning-b4c48',
    storageBucket: 'event-planning-b4c48.firebasestorage.app',
    iosBundleId: 'com.example.eventPlanning',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCTiB9dVdfgq-OuujwEN4ATDsfZZ5aN4D8',
    appId: '1:1060594657622:ios:6de753c95643b3b770cef7',
    messagingSenderId: '1060594657622',
    projectId: 'event-planning-b4c48',
    storageBucket: 'event-planning-b4c48.firebasestorage.app',
    iosBundleId: 'com.example.eventPlanning',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBsdm3-CoWNvqVAEIvMJKPiugP5v1oogA8',
    appId: '1:1060594657622:web:31970b6efd51f9f970cef7',
    messagingSenderId: '1060594657622',
    projectId: 'event-planning-b4c48',
    authDomain: 'event-planning-b4c48.firebaseapp.com',
    storageBucket: 'event-planning-b4c48.firebasestorage.app',
    measurementId: 'G-Q69ZENDV6C',
  );
}
