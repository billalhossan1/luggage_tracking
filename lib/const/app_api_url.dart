class AppApiUrl {
  AppApiUrl._();
  //////////////////////////////////////  base
  static const String domain = "http://192.168.10.195:5005";
  static const String baseUrl = "$domain/api/v1";
  static const String token = "";
  //////////////////////////////////////  auth
  static const String login = "/auth/login";
  static const String signUp = "/user";
  static const String profileUpdate = "/user";
  static const String verifyEmail = "/auth/verify-email";
  static const String forgotPassword = "/auth/forgot-password";
  static const String resetPassword = "/auth/reset-password";
  static const String changePassword = "/auth/change-password";
  static const String profile = "/user/profile";

  //////////////////////////////////////  rule
  static const String privacyPolicy = "/rule/privacy-policy";
  static const String about = "/rule/about";
  static const String termsAndConditions = "/rule/terms-and-conditions";
  //////////////////////////////////////  services
  static const String service = "/service";
  //////////////////////////////////////  bookmark
  static const String bookmark = "/bookmark";

  //////////////////////////////////////  post
  static const String post = "/post";
  static const String postService = "/post/service";
  static const String postCreate = "/post/create";
  static const String popularPost = "/post/popular";
  static const String recommendedPost = "/post/recommended";
  static const String postUpdate = "/post/update-post";
  static const String myPost = "/post/my-post";
  //////////////////////////////////////  chat
  static const String chatCreate = "/chat";
  static const String chat = "/chat";
  //////////////////////////////////////  message
  static const String message = "/message";

  //////////////////////////////////////  review
  static const String review = "/review";

  //////////////////////////////////////  banner
  static const String banner = "/banner";
  //////////////////////////////////////  offer
  static const String offer = "/offer";

  //////////////////////////////////////  notification
  static const String notification = "/notification";
}
