import 'package:choach_debate/features/Auth/presentation/bloc/auth_bloc.dart';
import 'package:choach_debate/features/Auth/presentation/pages/auth_pages.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:choach_debate/core/router/app_router_enum.dart';
import 'package:choach_debate/injection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRouter {
  static final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  static final _rootNavigatorKey = GlobalKey<NavigatorState>();
  static final _sheelNavigatorHome = GlobalKey<NavigatorState>(
    debugLabel: 'HOME',
  );
  static final _sheelNavigatorProfile = GlobalKey<NavigatorState>(
    debugLabel: 'PROFILE',
  );
  static final _sheelNavigatorAnalis = GlobalKey<NavigatorState>(
    debugLabel: 'ANALIS',
  );

  /* GoRouter => Package dari luar Pub.dev
  * 
  *
  **/
  static GoRouter router = GoRouter(
    refreshListenable: GoRouterRefreshStream(sl<AuthBloc>().stream),
    navigatorKey: _rootNavigatorKey,
    initialLocation: AppRouterEnum.loginScreen.path,

    routes: [
      GoRoute(
        parentNavigatorKey: _rootNavigatorKey,
        path: AppRouterEnum.loginScreen.path,
        name: AppRouterEnum.loginScreen.name,
        builder: (context, state) => BlocProvider(
          create: (context) => sl<AuthBloc>(),
          child: AuthPages(),
        ),
      ),
      // Page for HomeScreen
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationshell) => Container(),
        branches: [
          StatefulShellBranch(
            navigatorKey: _sheelNavigatorHome,
            routes: [
              GoRoute(
                parentNavigatorKey: _sheelNavigatorHome,
                path: AppRouterEnum.homeScreen.path,
                name: AppRouterEnum.homeScreen.name,
                builder: (context, state) => Container(),
              ),
            ],
          ),
        ],
      ),
    ],
  );
}

class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(Stream<dynamic> stream) {
    notifyListeners();
    stream.asBroadcastStream().listen((_) {
      notifyListeners();
    });
  }
}
