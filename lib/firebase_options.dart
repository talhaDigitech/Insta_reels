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
    apiKey: 'AIzaSyBPtMXmdFAdnq2S2Z07eVcmwrmmJeOmfoE',
    appId: '1:484278017943:web:aa56d7b19b61384d6e2ed2',
    messagingSenderId: '484278017943',
    projectId: 'videos-2314c',
    authDomain: 'videos-2314c.firebaseapp.com',
    storageBucket: 'videos-2314c.firebasestorage.app',
    measurementId: 'G-0KSMYSDYEJ',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyB37SSE-Mv7qcBbi1A6fGk8fawGzkZ_FGc',
    appId: '1:484278017943:android:6162a640fea9e3496e2ed2',
    messagingSenderId: '484278017943',
    projectId: 'videos-2314c',
    storageBucket: 'videos-2314c.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDDIxdS3X5OS5W4wrF7YBVOyvxuz2BAF8I',
    appId: '1:484278017943:ios:e1c2c1e513a0f9dd6e2ed2',
    messagingSenderId: '484278017943',
    projectId: 'videos-2314c',
    storageBucket: 'videos-2314c.firebasestorage.app',
    iosBundleId: 'com.example.videos',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDDIxdS3X5OS5W4wrF7YBVOyvxuz2BAF8I',
    appId: '1:484278017943:ios:e1c2c1e513a0f9dd6e2ed2',
    messagingSenderId: '484278017943',
    projectId: 'videos-2314c',
    storageBucket: 'videos-2314c.firebasestorage.app',
    iosBundleId: 'com.example.videos',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBPtMXmdFAdnq2S2Z07eVcmwrmmJeOmfoE',
    appId: '1:484278017943:web:4d6afdf96d5a6b3e6e2ed2',
    messagingSenderId: '484278017943',
    projectId: 'videos-2314c',
    authDomain: 'videos-2314c.firebaseapp.com',
    storageBucket: 'videos-2314c.firebasestorage.app',
    measurementId: 'G-56ZB9TCP3L',
  );
}