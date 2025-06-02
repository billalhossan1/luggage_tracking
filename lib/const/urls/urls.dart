class Urls{
  static final String _baseUrl = 'http://10.0.80.75:6003/api/v1';
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
  static  String subscriptionUrl(String email) => 'https://buy.stripe.com/test_cNicN56drcUlehmggL6AM1t?prefilled_email=$email';

}