// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i4;
import 'package:flutter/material.dart' as _i5;
import 'package:map_exam/common/models/models.dart' as _i6;
import 'package:map_exam/screens/edit_screen.dart' as _i1;
import 'package:map_exam/screens/home_screen.dart' as _i2;
import 'package:map_exam/screens/login_screen.dart' as _i3;

abstract class $AppRouter extends _i4.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i4.PageFactory> pagesMap = {
    EditScreenRoute.name: (routeData) {
      final args = routeData.argsAs<EditScreenRouteArgs>(
          orElse: () => const EditScreenRouteArgs());
      return _i4.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i1.EditScreen(
          key: args.key,
          note: args.note,
          viewMode: args.viewMode,
        ),
      );
    },
    HomeScreenRoute.name: (routeData) {
      return _i4.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.HomeScreen(),
      );
    },
    LoginScreenRoute.name: (routeData) {
      return _i4.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i3.LoginScreen(),
      );
    },
  };
}

/// generated route for
/// [_i1.EditScreen]
class EditScreenRoute extends _i4.PageRouteInfo<EditScreenRouteArgs> {
  EditScreenRoute({
    _i5.Key? key,
    _i6.Note? note,
    bool? viewMode = false,
    List<_i4.PageRouteInfo>? children,
  }) : super(
          EditScreenRoute.name,
          args: EditScreenRouteArgs(
            key: key,
            note: note,
            viewMode: viewMode,
          ),
          initialChildren: children,
        );

  static const String name = 'EditScreenRoute';

  static const _i4.PageInfo<EditScreenRouteArgs> page =
      _i4.PageInfo<EditScreenRouteArgs>(name);
}

class EditScreenRouteArgs {
  const EditScreenRouteArgs({
    this.key,
    this.note,
    this.viewMode = false,
  });

  final _i5.Key? key;

  final _i6.Note? note;

  final bool? viewMode;

  @override
  String toString() {
    return 'EditScreenRouteArgs{key: $key, note: $note, viewMode: $viewMode}';
  }
}

/// generated route for
/// [_i2.HomeScreen]
class HomeScreenRoute extends _i4.PageRouteInfo<void> {
  const HomeScreenRoute({List<_i4.PageRouteInfo>? children})
      : super(
          HomeScreenRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeScreenRoute';

  static const _i4.PageInfo<void> page = _i4.PageInfo<void>(name);
}

/// generated route for
/// [_i3.LoginScreen]
class LoginScreenRoute extends _i4.PageRouteInfo<void> {
  const LoginScreenRoute({List<_i4.PageRouteInfo>? children})
      : super(
          LoginScreenRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginScreenRoute';

  static const _i4.PageInfo<void> page = _i4.PageInfo<void>(name);
}
