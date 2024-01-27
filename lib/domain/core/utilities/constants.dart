///Constants used in the Domain layer
class DomainConstants {
  static const String releaseUserCollection = 'release_users';
  static const String debugUserCollection = 'debug_users';
  static const String phonePattern =
      r'^(\+7 \(\d{3}\) \d{3} \d{2} \d{2}|8 \(\d{3}\) \d{3} \d{2} \d{2})$';
}

///Constants used in the Views layer
class ViewsConstants {
  static const String appTitle = 'Phone Auth';
  static const String icBack = 'assets/icons/ic_back.svg';
  static const String icBackActive = 'assets/icons/ic_back_active.svg';
  static const String icMyAccount = 'assets/icons/ic_my_account.svg';
  static const String icMyAccountActive =
      'assets/icons/ic_my_account_active.svg';
  static const String icMyProject = 'assets/icons/ic_my_project.svg';
  static const String icMyProjectActive =
      'assets/icons/ic_my_project_active.svg';
  static const String icNext = 'assets/icons/ic_next.svg';
  static const String icProject = 'assets/icons/ic_profile.svg';
  static const String icEdit = 'assets/icons/ic_edit.svg';
  static const String cPhoneMask = '+7 (###) ### ## ##';
}
