import 'package:choach_debate/features/Analis/presentation/pages/analis_page.dart';
import 'package:choach_debate/features/Auth/presentation/bloc/auth_bloc.dart';
import 'package:choach_debate/features/Auth/presentation/pages/auth_pages.dart';
import 'package:choach_debate/features/Home/presentation/pages/home_page.dart';
import 'package:choach_debate/features/Profile/presentation/pages/profile_page.dart';
import 'package:choach_debate/shared/presentation/pages/navigation_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:choach_debate/core/router/app_router_enum.dart';
import 'package:choach_debate/injection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

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
    initialLocation: AppRouterEnum.homeScreen.path,

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
        builder: (context, state, navigationshell) => NavigationPage(
          navigationShell: navigationshell,
          navigatorKey: _scaffoldKey,
        ),
        branches: [
          // HomeBranch
          StatefulShellBranch(
            navigatorKey: _sheelNavigatorHome,
            routes: [
              GoRoute(
                parentNavigatorKey: _sheelNavigatorHome,
                path: AppRouterEnum.homeScreen.path,
                name: AppRouterEnum.homeScreen.name,
                builder: (context, state) => HomePage(),
                // SubRoute || SubPage
                routes: [

                ]
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _sheelNavigatorProfile,
            routes: [
              GoRoute(
                parentNavigatorKey: _sheelNavigatorProfile,
                path: AppRouterEnum.profileScreen.path,
                name: AppRouterEnum.profileScreen.path,
                builder: (context, state) => ProfilePage(),
                routes: [

                ]
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _sheelNavigatorAnalis,
            routes: [
              GoRoute(
                parentNavigatorKey: _sheelNavigatorAnalis,
                path: AppRouterEnum.analiticsScreen.path,
                name: AppRouterEnum.analiticsScreen.name,
                builder: (context, state) => AnalisPage(),
                routes: [],
              ),
            ],
          ),
        ],
      ),
    ],
    redirect: (BuildContext context, GoRouterState state) {
      final currenLocation = state.uri.toFilePath();
      final currentUser = Supabase.instance.client.auth.currentUser;
      final isLoogin = currentUser != null;

      final publicRoutes = [AppRouterEnum.loginScreen.path];
      final isPublish = publicRoutes.contains(currenLocation);
      // if (isLoogin && isPublish) {
      //   return AppRouterEnum.homeScreen.path;
      // }
      //
      // if (!isLoogin && !isPublish) {
      //   return AppRouterEnum.loginScreen.path;
      // }
      return null;
    },
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
