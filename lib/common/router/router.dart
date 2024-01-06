import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:map_exam/common/router/guards/auth_guard.dart';
import 'package:map_exam/common/router/router.gr.dart';
import 'package:map_exam/global.dart';

Widget zoomInTransition(BuildContext context, Animation<double> animation,
    Animation<double> secondaryAnimation, Widget child) {
  // you get an animation object and a widget
  // make your own transition
  return ScaleTransition(scale: animation, child: child);
}

/// Use the [watch] flag to watch the files' system for edits and rebuild as necessary.
/// dart run build_runner watch
///
/// if you want the generator to run one time and exits use
/// dart run build_runner build

@AutoRouterConfig(replaceInRouteName: '')
class AppRouter extends $AppRouter {
  AppRouter({
    GlobalKey<NavigatorState>? navigatorKey,
  }) : super(
          navigatorKey: Global.appKey,
        );

  @override
  List<MaterialRoute> get routes => [
        MaterialRoute(
          page: LoginScreenRoute.page,
          path: "/",
          initial: true,
          guards: const [],
        ),
        MaterialRoute(
          page: HomeScreenRoute.page,
          path: "/home",
          guards: [
            AuthGuard(),
          ],
        ),
        MaterialRoute(
          page: EditScreenRoute.page,
          path: "/:noteId/edit",
          guards: [
            AuthGuard(),
          ],
        ),
      ];
}
