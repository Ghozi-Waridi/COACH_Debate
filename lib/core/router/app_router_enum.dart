enum AppRouterEnum { loginScreen, homeScreen, topicsScreen, debateScreen }

extension AppRouterEnumExtension on AppRouterEnum {
  String get name {
    switch (this) {
      case AppRouterEnum.loginScreen:
        return 'loginScreen';
      case AppRouterEnum.homeScreen:
        return 'homeScreen';
      case AppRouterEnum.topicsScreen:
        return 'topicsScreen';
      case AppRouterEnum.debateScreen:
        return 'debateScreen';
    }
  }

  String get path {
    switch (this) {
      case AppRouterEnum.loginScreen:
        return '/login';
      case AppRouterEnum.homeScreen:
        return '/home';
      case AppRouterEnum.topicsScreen:
        return '/topics';
      case AppRouterEnum.debateScreen:
        return '/debate';
    }
  }
}
