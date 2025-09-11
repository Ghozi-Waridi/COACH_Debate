enum AppRouterEnum {
  loginScreen,
  homeScreen,
  topicsScreen,
  debateScreen,
  profileScreen,
  analiticsScreen,
}

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
      case AppRouterEnum.profileScreen:
        return 'profileScreen';
      case AppRouterEnum.analiticsScreen:
        return 'analiticsScreen';
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
      case AppRouterEnum.profileScreen:
        return '/profile';
      case AppRouterEnum.analiticsScreen:
        return '/analitics';
      default:
        return '/unknown';
    }
  }
}
