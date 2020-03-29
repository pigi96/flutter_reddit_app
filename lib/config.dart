import 'package:random_string/random_string.dart';

class Config {
  // Reddit API configs
  static final String clientId = "jVmkAKq1A8pRbA";
  static final String identifier = randomAlphaNumeric(12);
  static final String redirectUri = "https://sites.google.com/view/redditauth/home";
  static final String scopes = "identity";

  static String get redditAuthUrl => "https://www.reddit.com/api/v1/authorize?"
                              "client_id=$clientId"
                              "&response_type=code"
                              "&state=$identifier"
                              "&redirect_uri=$redirectUri"
                              "&scope=$scopes";
}