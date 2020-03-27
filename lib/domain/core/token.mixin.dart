mixin Tokenizable {
  num get nbf => 0;
  set nbf(num value) => nbf = value;

  num get exp => 0;
  set exp(num value) => exp = value;

  num get iat => 0;
  set iat(num value) => iat = value;

  String get iss => null;
  set iss(String value) => iss = value;

  String get aud => null;
  set aud(String value) => aud = value;
}
