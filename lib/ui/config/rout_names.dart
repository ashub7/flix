enum RoutesName {
  login,
  registration,
  home,
  account,
  favorites,
  detail,
  fullScreenImage,
}

extension RoutesNameHelper on RoutesName {
  String get name {
    switch (this) {
      case RoutesName.login:
        return 'login';
      case RoutesName.registration:
        return 'registration';
      case RoutesName.home:
        return 'home';
      case RoutesName.account:
        return 'account';
      case RoutesName.favorites:
        return 'favorites';
      case RoutesName.detail:
        return 'detail';
      case RoutesName.fullScreenImage:
        return 'fullScreenImage';
    }
  }

  String get path => '/$name';
}
