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
    apiKey: 'AIzaSyABoe22ZHfn-wXwSER1rUcwEEyULY4op7U',
    appId: '1:670102274118:web:a6677d731692f0a156ca47',
    messagingSenderId: '670102274118',
    projectId: 'fir-connectivity-e5cd1',
    authDomain: 'fir-connectivity-e5cd1.firebaseapp.com',
    storageBucket: 'fir-connectivity-e5cd1.appspot.com',
    measurementId: 'G-KVSBZ5ZRV1',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyD7tsFmnH3ln0RkR8H18bYWH5AhGqgvCs0',
    appId: '1:670102274118:android:591bf004e734f44956ca47',
    messagingSenderId: '670102274118',
    projectId: 'fir-connectivity-e5cd1',
    storageBucket: 'fir-connectivity-e5cd1.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAeiQXhli5JdO30TF1Okd2AZAjYmQ-blyM',
    appId: '1:670102274118:ios:a368182512561fd356ca47',
    messagingSenderId: '670102274118',
    projectId: 'fir-connectivity-e5cd1',
    storageBucket: 'fir-connectivity-e5cd1.appspot.com',
    androidClientId: '670102274118-lplolnahph2qh2hfqdof2b0oqqolb0aa.apps.googleusercontent.com',
    iosClientId: '670102274118-k8rrvcn1tj06hu8qpaoqc98oth2thcae.apps.googleusercontent.com',
    iosBundleId: 'com.example.gymTest',
  );
}
