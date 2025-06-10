class Urls{
  static final String _baseUrl = 'http://10.0.80.75:6003/api/v1';
  static final String imageBaseUrl = 'http://10.0.80.75:6003';
  static final String registerUrl = '$_baseUrl/user';
  static final String loginUrl = '$_baseUrl/auth/login';
  static final String forgotPasswordUrl = '$_baseUrl/auth/forgot-password';
  static final String resetPasswordUrl = '$_baseUrl/auth/reset-password';
  static final String changePasswordUrl = '$_baseUrl/user/change-password';
  static final String resendOtpUrl = '$_baseUrl/auth/resend-otp';
  static final String verifyEmailUrl = '$_baseUrl/auth/verify-email';
  static final String socialUrl = '$_baseUrl/auth/social-login';
  static final String updateProfileUrl = '$_baseUrl/user';
  static final String getSubscriptionPlanListUrl = '$_baseUrl/plan';
  static final String getCategoryListUrl = '$_baseUrl/category';
  static final String getProductListUrl = '$_baseUrl/product';
  static final String getWishListUrl = '$_baseUrl/bookmark';
  static final String getOrderListUrl = '$_baseUrl/order';
  static final String makeOrderListUrl = '$_baseUrl/order';
  static final String getProfileDetailsUrl = '$_baseUrl/user/profile';
  static final String getFAQListUrl = '$_baseUrl/faq';
  static final String bookMarkUrl = '$_baseUrl/bookmark';
  static final String feedbackUrl = '$_baseUrl/review';
  static final String deleteAccountUrl = '$_baseUrl/auth/delete-account';
  static final String profileUpdateUrl = '$_baseUrl/user';
  static  String subscriptionUrl(String email) => 'https://buy.stripe.com/test_cNicN56drcUlehmggL6AM1t?prefilled_email=$email';

}