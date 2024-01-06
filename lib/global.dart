import 'dart:async';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:map_exam/common/providers/providers.dart';
import 'package:map_exam/common/router/router.dart';
import 'package:map_exam/firebase_options.dart';

class Global {
  static AuthStateProvider authState = AuthStateProvider();

  static AppRouter? appRouter;

  static bool get isRelease => const bool.fromEnvironment("dart.vm.product");

  static late GlobalKey<NavigatorState> appKey;

  static bool isLoaderActive = false;

  static Future init() async {
    WidgetsFlutterBinding.ensureInitialized();

    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
    );

    appKey = GlobalKey<NavigatorState>();

    if (Platform.isAndroid) {
      SystemUiOverlayStyle systemUiOverlayStyle = const SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.dark,
      );
      SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
    } else {
      SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle.dark.copyWith(
          statusBarBrightness: Brightness.light,
        ),
      );
    }

    await Future.wait([
      Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      ),
    ]);
  }

  static void listenToAuth() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      authState.updateUserData(user);
    });
  }
}
