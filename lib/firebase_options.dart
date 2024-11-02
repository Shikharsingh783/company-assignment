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
    apiKey: 'AIzaSyBLWOhMK4KBm9OebxplmikA_hy--qSmUzY',
    appId: '1:846480440172:web:a6d67a269ad3fd4671d149',
    messagingSenderId: '846480440172',
    projectId: 'assignment-e2a99',
    authDomain: 'assignment-e2a99.firebaseapp.com',
    storageBucket: 'assignment-e2a99.firebasestorage.app',
    measurementId: 'G-X229STWE45',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBj8XMwrTVUO6EYiHWon6I1pNDOTX-XJ0Q',
    appId: '1:846480440172:android:d5da5a40f34bbe3471d149',
    messagingSenderId: '846480440172',
    projectId: 'assignment-e2a99',
    storageBucket: 'assignment-e2a99.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAmwZ8VI1cpaW-dfRnVobKcJZk0j62ZyKw',
    appId: '1:846480440172:ios:169b85234de5272271d149',
    messagingSenderId: '846480440172',
    projectId: 'assignment-e2a99',
    storageBucket: 'assignment-e2a99.firebasestorage.app',
    iosBundleId: 'com.example.assignment',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAmwZ8VI1cpaW-dfRnVobKcJZk0j62ZyKw',
    appId: '1:846480440172:ios:169b85234de5272271d149',
    messagingSenderId: '846480440172',
    projectId: 'assignment-e2a99',
    storageBucket: 'assignment-e2a99.firebasestorage.app',
    iosBundleId: 'com.example.assignment',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBLWOhMK4KBm9OebxplmikA_hy--qSmUzY',
    appId: '1:846480440172:web:744a98b809c40a2a71d149',
    messagingSenderId: '846480440172',
    projectId: 'assignment-e2a99',
    authDomain: 'assignment-e2a99.firebaseapp.com',
    storageBucket: 'assignment-e2a99.firebasestorage.app',
    measurementId: 'G-X08JYT93EE',
  );
}
