class ApiConstants {
  static const String APP_NAME = 'We Coin';
  static const String BASE_URL = 'http://wecoin.pk/weCoinApp/api/enrollment';
  static const String SIGN_UP = '/register';
  static const String SIGN_IN = '/login';
  static const String FORGOT_PASSWORD = '/forgotPass';
  static const String IDENTITY_VERIFICATION = '/identityVerification';
  static const String ADDRESS_VERIFICATION = '/addressVerification';
  static const String VERIFIED_OTP = '/verifyOtp';
  static const String PASSWORD_RESET = '/passwordReset';
  static const String EDIT_PROFILE = '/editProfile';
  static const String VIEW_PROFILE = '/profileView';
  static const String SETTING_NOTIFICATION = '/notificationTypes';
  static const String SETTING_ACTIVITY_LIST = '/activities';

  /// 3rd time api creation
  static const String GET_CATEGORIES = '/applicationsList';
  static const String GET_TICKETS = '/tickets';
  static const String GET_VIEW_TICKETS = '/viewTicket?id=2';
  static const String GET_DISPUTES = '/disputes';
  //  post links for api
  static const String ADD_DISPUTE = '/addDispute';
  static const String ADD_TICKETS = '/addTicket';
  static const String SEND_MONEY = '/sendMoney';

  // get currencies
  static const String GET_CURRENCIES = '/currencies';
  static const String GET_WALLETS = '/wallets';
  static const String GET_TRANSACTION = '/transactions';
}
