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
    apiKey: 'AIzaSyAkkWxh2825Xr-C8T70f3UVWvhWghVPE40',
    appId: '1:382112883953:web:f40efa968ee7300311b550',
    messagingSenderId: '382112883953',
    projectId: 'primal-analytics-81805',
    authDomain: 'primal-analytics-81805.firebaseapp.com',
    storageBucket: 'primal-analytics-81805.appspot.com',
    measurementId: 'G-FPZHQ9HDL3',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyApiX8bucZcoctyylE2OoCT7k8_-sqLf2g',
    appId: '1:382112883953:android:8f4ab507eced111111b550',
    messagingSenderId: '382112883953',
    projectId: 'primal-analytics-81805',
    storageBucket: 'primal-analytics-81805.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAH-zWVfPEMY_-A17r2ovgt-6Xyj1uR20k',
    appId: '1:382112883953:ios:872d3f0be59e976011b550',
    messagingSenderId: '382112883953',
    projectId: 'primal-analytics-81805',
    storageBucket: 'primal-analytics-81805.appspot.com',
    androidClientId: '382112883953-bbllfq30crmbj8r6990lcvoegbr41vqj.apps.googleusercontent.com',
    iosClientId: '382112883953-6bsmfrio0ouc5rhgqdjfh80uhrf3vahv.apps.googleusercontent.com',
    iosBundleId: 'com.primal.app',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAH-zWVfPEMY_-A17r2ovgt-6Xyj1uR20k',
    appId: '1:382112883953:ios:872d3f0be59e976011b550',
    messagingSenderId: '382112883953',
    projectId: 'primal-analytics-81805',
    storageBucket: 'primal-analytics-81805.appspot.com',
    androidClientId: '382112883953-bbllfq30crmbj8r6990lcvoegbr41vqj.apps.googleusercontent.com',
    iosClientId: '382112883953-6bsmfrio0ouc5rhgqdjfh80uhrf3vahv.apps.googleusercontent.com',
    iosBundleId: 'com.primal.app',
  );
}
