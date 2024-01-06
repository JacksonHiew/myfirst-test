import 'package:auto_route/auto_route.dart';
import 'package:map_exam/common/router/router.gr.dart';
import 'package:map_exam/global.dart';

class AuthGuard extends AutoRouteGuard {
  @override
  Future<void> onNavigation(
      NavigationResolver resolver, StackRouter router) async {
    var isAuth = Global.authState.isLoggedIn;
    if (isAuth == false) {
      router.push(
        const LoginScreenRoute(),
      );

      resolver.next(true);
      return;
    }

    resolver.next(true);
  }
}
