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
    apiKey: 'AIzaSyDXPr0-vVDx31-vE3Bd1Hmnea2maS7fFdg',
    appId: '1:750034286762:web:c4292324aeb24af6ae78d3',
    messagingSenderId: '750034286762',
    projectId: 'flutter-rtm-1a91b',
    authDomain: 'flutter-rtm-1a91b.firebaseapp.com',
    storageBucket: 'flutter-rtm-1a91b.appspot.com',
    measurementId: 'G-TKDY2X2JQE',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCnrvQURWrJ4RV32p1GGxnUhmS3wbAsDOo',
    appId: '1:750034286762:android:4e178e1895b07a13ae78d3',
    messagingSenderId: '750034286762',
    projectId: 'flutter-rtm-1a91b',
    storageBucket: 'flutter-rtm-1a91b.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyD52cxkM_JHmM1vyGEEThAGdxkRyroLAiw',
    appId: '1:750034286762:ios:f5f996ccd790ee4fae78d3',
    messagingSenderId: '750034286762',
    projectId: 'flutter-rtm-1a91b',
    storageBucket: 'flutter-rtm-1a91b.appspot.com',
    iosBundleId: 'com.example.rtmFirebaseUpload',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyD52cxkM_JHmM1vyGEEThAGdxkRyroLAiw',
    appId: '1:750034286762:ios:99adb0c701e2da4dae78d3',
    messagingSenderId: '750034286762',
    projectId: 'flutter-rtm-1a91b',
    storageBucket: 'flutter-rtm-1a91b.appspot.com',
    iosBundleId: 'com.example.rtmFirebaseUpload.RunnerTests',
  );
}
