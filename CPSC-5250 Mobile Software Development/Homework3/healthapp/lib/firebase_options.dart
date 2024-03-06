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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyACc_oy5-8WDigSzABiHCVDGD6oh7nDBEs',
    appId: '1:613698699570:web:dc063f56edabace84c172b',
    messagingSenderId: '613698699570',
    projectId: 'healthify-7c26c',
    authDomain: 'healthify-7c26c.firebaseapp.com',
    storageBucket: 'healthify-7c26c.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCVJAUGSmZtfnic4CZVpC8cy3xKpTyNLHg',
    appId: '1:613698699570:android:f1b4833c6945fccc4c172b',
    messagingSenderId: '613698699570',
    projectId: 'healthify-7c26c',
    storageBucket: 'healthify-7c26c.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAby9lEmxdVy1kTZXGvhrgbToANMgG-97k',
    appId: '1:613698699570:ios:319fdbbef2d4f4024c172b',
    messagingSenderId: '613698699570',
    projectId: 'healthify-7c26c',
    storageBucket: 'healthify-7c26c.appspot.com',
    iosBundleId: 'com.example.healthapp',
  );
}
